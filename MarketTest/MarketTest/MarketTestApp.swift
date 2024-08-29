//
//  MarketTestApp.swift
//  MarketTest
//
//  Created by Engin Gülek on 17.08.2024.
//

import SwiftUI

@main
struct MarketTestApp: App {
    var body: some Scene {
        WindowGroup {
            ProductListView(viewModel: ProductListViewModel(productService: ProductService()))
        }
    }
}
