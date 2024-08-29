//
//  CartProductItemView.swift
//  MarketTest
//
//  Created by Engin Gülek on 22.08.2024.
//

import SwiftUI

 struct CartProductItemView : View {
    let product : Cart
    var body: some View {
        HStack {
            ProductImage(imageUrl: product.imageurl)
                .frame(width: 70,height: 70)
                .padding(3)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            Color.gray.opacity(0.5),
                            style: StrokeStyle(lineWidth: 1)
                        )
                )
            VStack(alignment:.leading) {
                Text(product.name)
                    .font(.headline)
                Text(product.about_product)
                    .font(.caption)
                    .fontWeight(.light)
                Text("₺\(String(format: "%.2f", product.price))")
                Spacer()
            }
            
            Spacer()
        }
    }
}

#Preview {
    CartProductItemView(product: Cart.exampleCartProduct)
}
