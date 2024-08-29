//
//  ProductDetailViewModel.swift
//  MarketTest
//
//  Created by Engin Gülek on 17.08.2024.
//

import Foundation
import SwiftUI


protocol ProductDetailViewPModelrotocol : ObservableObject {
  
    var product:Product {get}
    var errorStata:Bool {get}
    func addProductToCart() async
   
}

class ProductDetailViewModel: ProductDetailViewPModelrotocol {
  
    var errorStata: Bool = false
    @Published var product: Product
    private let productDetailService: ProductDetailServiceProtocol = ProductDetailService()
    init( product: Product) {
       
        self.product = product
        
    }

    func addProductToCart() async {
        do{
            let cartProductParameter : [String:Any] = ["user_id":1,"product_id":product.id]
            try await productDetailService.addProductToCart(parameter: cartProductParameter)
            errorStata = false
        }catch{
           errorStata = true
        }
    }
    
}
