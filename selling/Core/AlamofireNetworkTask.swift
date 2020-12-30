//
//  AlamofireNetworkTask.swift
//  selling
//
//  Created by Thien on 12/30/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper

open class AlamofireNetworkTask<T>: BaseNetworkTask<T> where T: Mappable {
    fileprivate var _log: String = String.empty

    open func httpBodyEncoding() -> ParameterEncoding {
        return URLEncoding.default
    }

    private func shouldPrintLog() -> Bool {
        return true
    }

    override open func execute () {
        //execute pre block first
        self.preProcessBlock?()

        //Prepare log
        self._log = "================================================================="
        self._log = "\(self._log)\n\(self.httpMethod().rawValue): \(self.requestURL().encodeURL())"
        if let header = self.httpHeader() {
            self._log = "\(self._log)\nHEADER: \(header)"
        }

        if let body = self.httpBody() {
            self._log = "\(self._log)\nBODY: \(BKHelpers.convertDictionanyToJsonString(dict: body))"
        }

        Alamofire.request(self.requestURL().encodeURL(),
                          method: self.httpMethod(),
            parameters: self.httpBody(),
            encoding: self.httpBodyEncoding(),
            headers: self.httpHeader())
            .validate(statusCode: 200..<401)
            .responseString(completionHandler: { (response) in
                switch response.result {
                case .success(let responseObject):
                    if let data = response.data {
                        do {
                            let json = try JSON(data: data)
                            self._log = "\(self._log)\nResponse Success: \(json)"
                            self.taskDidFinishWithJSON(json: JSON(parseJSON: responseObject))
                        } catch let e as NSError {
                            self.taskDidFailWithError(error: e)
                        }
                    } else {
                        self._log = "\(self._log)\nResponse Failure: Received nil from server."
                        self.notifyErrorOccurred(error: NSError.errorWithMessage(code: 400, msg: "Received nil from server."))
                    }
                case .failure(let error as NSError):
                    self._log = "\(self._log)\nResponse Failure: \(String(describing: error))"
                    self.taskDidFailWithError(error: error)
                default: break
                }
                self._log = "\(self._log)\n================================================================="
                if self.shouldPrintLog() {
                    print(self._log)
                }
            })
    }
}

