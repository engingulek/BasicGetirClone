//
//  ProductService.swift
//  MarketTest
//
//  Created by Engin Gülek on 17.08.2024.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts(subCategoryId:Int) async throws -> [Product]
    func fetchCartProducts(userId:Int) async throws -> [Cart]
    func fetchCategories() async throws -> [Category]
    func addProductToCart(parameter:[String:Any]) async throws
    func decreaseProductFromCart(cartId:Int) async throws
}

class ProductService: ProductServiceProtocol {
 
    private let networkManager : NetworkManagerProtocol = NetworkManager()
    
    /// This function fetchs  products for database
    /// - Parameter userId: id of subCategory for  Products
    /// - Returns: [Product]
    func fetchProducts(subCategoryId:Int) async throws -> [Product] {
        do{
            let response = try await networkManager.fetch(
                target: .productsBySubCategoryId(subCategoryId),
                responseClass: [Product].self)
            return response
        }catch{
            throw error
        }
    }
    
    
    /// This function fetchs cart products for database
    /// - Parameter userId: id of use for cart Products
    /// - Returns: [Carts]
    func fetchCartProducts(userId:Int) async throws -> [Cart] {
        
        do{
            let response = try await networkManager.fetch(
                target: .cartProductByUser(userId),
                responseClass: [Cart].self)
            return response
        }catch{
            throw error
        }
    }
    
    
    /// This function fetchs categories
    /// - Returns: [Category]
    func fetchCategories() async throws -> [Category] {
        do {
            let response = try await networkManager.fetch(target: .categories, responseClass: [Category].self)
            return response
        }catch{
            throw error
        }
      
    }

    
    /// When minus button was clicked, ıf quantit of prroduct on cart is zero product will be added to cart or quantit of product on cart will be inrement
    /// - Parameter parameter: [userId:Strifng,productId:String]
    func addProductToCart(parameter: [String : Any]) async throws {
        do{
            _ = try await networkManager.fetch(target: .addProduct(parameter), responseClass: String?.self)
        }catch{
         
            throw error
        }
    }
    
    /// When decrease buttom was clicked, qıantiy of product on cart decreases
    /// - Parameter cartId: id for cart product
    func decreaseProductFromCart(cartId: Int) async throws {
        do {
            _ = try await networkManager.fetch(target: .decreaseProduct(cartId), responseClass: String?.self)
        }catch {
            throw error
        }
    }
    
    
}
