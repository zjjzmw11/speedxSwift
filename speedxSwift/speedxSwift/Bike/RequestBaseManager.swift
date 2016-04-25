//
//  RequestBaseManager.swift
//  speedxSwift
//
//  Created by speedx on 16/4/25.
//  Copyright © 2016年 speedx. All rights reserved.
//

import Alamofire

let kNetwork_Invalid_Code   =   -3010
let kHttp_Error_Code        =   -3020
let kSocial_Login_Failed    =   -3030

let kResponse_Code_Key      =   "code"
let kResponse_Message_Key   =   "message"
let kResponse_Result_Key    =   "result"

//let kNetwork_Invalid_Block : (Bool,String)


class RequestBaseManager: NSObject {

    /**
     *  请求 JSON
     *
     *  @param method        HTTP 请求方法
     *  @param URLString     URL字符串
     *  @param parameters    参数字典
     *  @param completion    完成回调，返回NetworkResponse
     */
    class func requestJSON(method: Alamofire.Method, URLString: String, parameters: [String: AnyObject]? = nil, completion:(response: NetworkResponse?) -> ()) {
        Alamofire.request(method, URLString, parameters: parameters, encoding: .URL, headers: nil).responseJSON { (JSON) in
            switch JSON.result {
            case .Success:
                if let value = JSON.result.value {
                    let nResponse = NetworkResponse(dict: value as! [String : AnyObject])
                    completion(response: nResponse)
                }
            case .Failure(let error):
                debugPrint(error)
            }
        }
    }

    
}
