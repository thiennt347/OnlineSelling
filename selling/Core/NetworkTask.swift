//
//  NetwordTask.swift
//  selling
//
//  Created by Thien on 12/30/20.
//

import UIKit
import SwiftyJSON
import ObjectMapper
import SwiftyUserDefaults
import Alamofire

open class NetworkTask<T>: AlamofireNetworkTask<T> where T: Mappable {
    open var params: [String: Any]! = [:]

    override open func httpBody() -> [String: Any]? {
        return self.params
    }

    override open func httpHeader() -> [String: String]? {
        let token = String.empty
        if token.isEmpty == false {
            return [
                "Authorization": token,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }

        return [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }

    override open func taskDidFinishWithJSON(json: JSON) {
        guard let rawStr = json.rawString() else {
            self.notifyErrorOccurred(error: NSError.errorWithMessage(code: 0, msg: "Can't receive data from server"))
            return
        }

        let response = Mapper<BaseResponse<T>>().map(JSONString: rawStr)
        // we assume 200 code mean success
        if response!.code == 200 {
            self.notifySucceeded(obj: response)
        } else {
            self.notifyErrorOccurred(error: NSError.errorWithMessage(code: response!.error!.code, msg: response!.error!.message))
        }
    }
    
}

open class JSONNetworkTask<T>: NetworkTask<T> where T: Mappable {
    override open func httpHeader() -> [String: String]? {
        let token = String.empty
        if token.isEmpty == false {
            return [
                "Authorization": token,
                "Content-Type": "application/json"
            ]
        }

        return [
            "Content-Type": "application/json"
        ]
    }

    override open func httpBodyEncoding() -> ParameterEncoding {
        return JSONEncoding.prettyPrinted
    }
}
