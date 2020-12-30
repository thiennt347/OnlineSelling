//
//  BKBaseNetworkTask.swift
//  selling
//
//  Created by Thien on 12/30/20.
//

import Foundation
import SwiftyJSON
import ObjectMapper
import Alamofire

open class BaseNetworkTask<T>: NSObject where T: Mappable {
    
    internal var preProcessBlock:  (() -> Void)?
    internal var postProcessBlock: ((_ object: BaseResponse<T>?, _ error: NSError?) -> Void)?
    
    internal var retryTimes: Int = 0
    open func shouldRetry() -> Bool {
        return true
    }
    
    
    open func requestURL() -> String {
        fatalError("\(#function) Must be overridden in subclass")
    }
    
    open func httpMethod() -> Alamofire.HTTPMethod {
        return .get // get method by default
    }
    
    open func httpHeader() -> [String: String]? {
        return [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
    
    open func httpBody() -> [String: Any]? {
        return nil
    }
    
    open func setCompletion(completion:((_ object: BaseResponse<T>?, _ error: NSError?) -> Void)?) -> BaseNetworkTask {
        postProcessBlock = completion
        return self
    }
    
    open func setBeforeProcess(preProcessBlock: @escaping () -> Void) {
        self.preProcessBlock = preProcessBlock
    }
    
    open func execute() {
        fatalError("\(#function) Must be overridden in subclass")
    }
    
    open func taskDidFinishWithJSON(json: JSON) {
        fatalError("\(#function) Must be overridden in subclass")
    }
    
    open func taskDidFailWithError(error: NSError) {
        self.notifyErrorOccurred(error: error)
    }
    
    open func notifySucceeded(obj: BaseResponse<T>?) {
        self.postProcessBlock?(obj, nil)
    }
    
    open func notifyErrorOccurred(error: NSError?) {
        if shouldRetry() == true
            && self.retryTimes <= BKConfiguration.instance.maximumRetryTimes {
            self.retryTimes += 1
            //Execute again
            print("\(self.className) will retry: \(self.retryTimes)")
            self.execute()
        } else {
            self.postProcessBlock?(nil, error)
        }
    }
}
