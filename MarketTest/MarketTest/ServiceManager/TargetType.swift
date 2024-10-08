//
//  TargetType.swift
//  MarketTest
//
//  Created by Engin Gülek on 24.08.2024.
//

import Foundation
import Alamofire

protocol TargetType {
    var baseURL: String {get}
    var path: String {get}
    var method: AlamofireMethod {get}
    var requestType: RequestType {get}
    var headers: [String: String]? {get}
}

enum AlamofireMethod: String {
    case GET
    case POST
    case DELETE
}

enum RequestType {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
                
  
}
