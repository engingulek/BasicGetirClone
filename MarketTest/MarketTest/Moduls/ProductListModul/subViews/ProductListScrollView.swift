//
//  ProductListScrollView.swift
//  MarketTest
//
//  Created by Engin Gülek on 23.08.2024.
//

import SwiftUI

struct ProductListScrollView: View {
    @StateObject  var viewModel: ProductListViewModel
    let columns = [
           GridItem(.flexible()),
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.products, id: \.id) { product in
                    NavigationLink {
                        ProductDetailView(viewModel: ProductDetailViewModel(product: product))
                    } label: {
                        ProductItemView(product: product, viewModel: viewModel)
                            .foregroundStyle(Color.black)
                    }

                   
                }
            }
            .padding()
        }
    }
}

#Preview {
    ProductListScrollView(viewModel: ProductListViewModel(productService: ProductService()))
}
