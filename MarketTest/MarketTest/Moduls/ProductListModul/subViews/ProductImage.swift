//
//  ProductImage.swift
//  MarketTest
//
//  Created by Engin Gülek on 17.08.2024.
//

import SwiftUI

struct ProductImage: View {
    let imageUrl:String
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable() // Resmi yeniden boyutlandırmaya izin verir.
                    .scaledToFill() // Resmin oranını koruyarak sığmasını sağlar.
                    
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    ProductImage(imageUrl: Product.exampleProduct.imageUrl)
}
