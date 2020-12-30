//
//  BKBaseResponse.swift
//  selling
//
//  Created by Thien on 12/30/20.
//

import UIKit
import ObjectMapper

open class BaseResponse<T>: NSObject, Mappable where T: Mappable {
    public var code: Int?
    public var data: T?
    //https://github.com/Hearst-DD/ObjectMapper/issues/484
    public var dataArray: [T]?
    public var error: ErrorResponse?
    
    required public init?(map: Map) {
        super.init()
        self.mapping(map: map)
    }
    
    open func mapping(map: Map) {
        // I assume we have a comon format {code, message, data}
        code <- map["code"]
        data <- map["data"]
        dataArray <- map["data"]
        error <- map["message"]
    }
}

open class ErrorResponse: NSObject, Mappable {
    public var code: Int!
    public var message: String!
    
    required public init?(map: Map) {
        super.init()
        self.mapping(map: map)
    }
    
    open func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}
