//
//  Product.swift
//  MarketTest
//
//  Created by Engin Gülek on 17.08.2024.
//

import Foundation
struct Product: Identifiable,Hashable,Decodable {
    let id: Int
    let imageUrl:String
    let name: String
    let price: Double
    let aboutProduct: String
    // piece is nil, Because Its data doesn't come from database
    var piece : Int? = 0
    
    
    static let exampleProduct : Product = Product(
        id: 0,
        imageUrl: "https://ideacdn.net/idea/my/16/myassets/products/085/g.png?revision=1698847802",
        name: "Ürün 1",
        price: 10.0,
        aboutProduct: "Açıklama 1")
}

