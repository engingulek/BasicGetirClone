//
//  ProductDetailService.swift
//  MarketTest
//
//  Created by Engin Gülek on 27.08.2024.
//

import Foundation


protocol ProductDetailServiceProtocol {
    func addProductToCart(parameter:[String:Any]) async throws
}


class ProductDetailService : ProductDetailServiceProtocol {

    
    private let networkManager : NetworkManagerProtocol = NetworkManager()
    
    func addProductToCart(parameter: [String : Any]) async throws {
        do{
            _ = try await networkManager.fetch(target: .addProduct(parameter), responseClass: String?.self)
        }catch{
         
            throw error
        }
    }
}
