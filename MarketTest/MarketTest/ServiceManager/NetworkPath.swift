//
//  NetworkPath.swift
//  MarketTest
//
//  Created by Engin Gülek on 24.08.2024.
//

import Foundation
import Alamofire
enum NetworkPath {
    case categories
    case productsBySubCategoryId(Int)
    case cartProductByUser(Int)
    case addProduct(Parameters)
    case incrementProduct(Int)
    case decreaseProduct(Int)
    case clearCartAll(Int)
}

extension NetworkPath : TargetType {
    var baseURL: String {
        return Constants.baseUrl.rawValue
    }
    
    var path: String {
        switch self {
        case .categories:
            return "\(Constants.category.rawValue)\(Constants.getAll.rawValue)"
        case .productsBySubCategoryId(let subCategoryId):
            return "\(Constants.product.rawValue)\(Constants.bySubCategoryId.rawValue)?\(Constants.subCategoryId.rawValue)=\(subCategoryId)"
        case .cartProductByUser(let userId):
            return "\(Constants.cart.rawValue)\(Constants.getCartByUserId.rawValue)?\(Constants.userId.rawValue)=\(userId)"
        case .incrementProduct(let id):
            return "\(Constants.cart.rawValue)\(Constants.incrementProduct.rawValue)?\(Constants.id.rawValue)=\(id)"
        case .decreaseProduct(let id):
            return "\(Constants.cart.rawValue)\(Constants.decreaseProduct.rawValue)?\(Constants.id.rawValue)=\(id)"
        case .addProduct:
            return "\(Constants.cart.rawValue)\(Constants.addProduct.rawValue)"
        case .clearCartAll(let userId):
            return "\(Constants.cart.rawValue)\(Constants.clearCart.rawValue)/\(userId)"
        }
    }
    
    var method: AlamofireMethod {
        switch self {
        case .addProduct:
            return .POST
        case .clearCartAll:
            return .DELETE
        default:
            return .GET
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .addProduct(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.init())
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}
