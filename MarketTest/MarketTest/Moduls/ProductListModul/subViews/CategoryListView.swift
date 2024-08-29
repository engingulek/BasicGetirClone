//
//  CategoryListView.swift
//  MarketTest
//
//  Created by Engin Gülek on 23.08.2024.
//

import SwiftUI

struct CategoryListView: View {
    let viewModel : ProductListViewModel
    var body: some View {
        
        //MARK: Category List
        VStack {
            VStack {
                ScrollView(.horizontal,showsIndicators: false) {
                    LazyHStack(alignment:.center,content: {
                        ForEach(viewModel.categories, id: \.self) { category in
                            Text(category.name).padding()
                                .foregroundStyle(Color.white)
                                .onTapGesture {
                                    Task {
                                       await viewModel.didSelectedBaseCategory(id: category.id)
                                    }
                                  
                                }
                        }
                    })
                }
            }
            .frame(height: 50)
            .background(Color.purple)
            
            //MARK: SubCategoyList
            VStack {
                ScrollView(.horizontal,showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.subCategories,id:\.self) { subCategory in
                            Text(subCategory.name)
                                .padding()
                        }
                    }
                }
            }
            .frame(height: 50)
        }
    }
}

#Preview {
    CategoryListView(viewModel: ProductListViewModel(productService: ProductService()))
}
