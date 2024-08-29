//
//  ProductItemView.swift
//  MarketTest
//
//  Created by Engin Gülek on 17.08.2024.
//

import SwiftUI

struct ProductItemView: View {
    let product:Product
    @StateObject  var viewModel: ProductListViewModel
    var body: some View {
        ZStack(
            alignment: .topTrailing, content: {
               
                productImageItemView(product: product)
                if product.piece == 0 || product.piece == nil{
                    Button(action: {
                        Task{
                           await viewModel.addButtonTapped(product_id:product.id)
                        }
                    }, label: {
                        Image(systemName: ImageTheme.plus.rawValue)
                            .foregroundStyle(.purple)
                            .fontWeight(.semibold)
                            
                    })
                    .frame(width: 15,height: 15)
                   
                    .padding(6)
                    
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .shadow(
                                color:.purple.opacity(0.7),
                                radius: 2)
                            
                    )
                }else{
                    VStack(spacing:0){
                        Button(action: {
                            Task{
                               await viewModel.addButtonTapped(product_id:product.id)
                            }
                        }, label: {
                            Image(systemName: ImageTheme.plus.rawValue)
                                .foregroundStyle(.purple)
                                .fontWeight(.semibold)
                                
                        })
                        .frame(width: 15,height: 15)
                       
                        .padding(6)
                        
                        .background(
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.white)
                                .shadow(
                                    color:.purple.opacity(0.7),
                                    radius: 2)
                                
                        )
                        Text("\(product.piece ?? 0)")
                            .frame(width: 15,height: 20)
                            .padding(6)
                            .background(Color.purple)
                            .font(.footnote)
                            .foregroundStyle(.white)
                         
                           
                        Button(action: {
                            Task{
                                await viewModel.didTappedDecreaseButtonTapped(id:product.id)
                            }
                        }, label: {
                            Image(systemName: ImageTheme.minus.rawValue)
                                .foregroundStyle(.purple)
                                .fontWeight(.semibold)
                        })
                        .frame(width: 15,height: 15)
                        .padding(6)
                        .background(
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.white) // Arka plan rengi
                                .shadow(
                                    color:.purple.opacity(0.7),
                                    radius: 2) // Gölge eklemek isterseniz
                                
                        )
                    }
                }
        })
    }
    
    
}





private struct productImageItemView : View {
    let product:Product
    
    var body: some View {
        VStack(alignment:.leading) {
            ProductImage(imageUrl: product.imageUrl)
                .frame(width: 100,height: 120)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                                       product.piece == 0 ? Color.gray.opacity(0.5) : Color.purple,
                                       style: StrokeStyle(lineWidth: 1)
                                   )
                )
            Text("₺\(String(format: "%.2f", product.price))")
                .font(.callout)
                .foregroundStyle(.purple)
                .fontWeight(.semibold)
            Text("\(product.name)")
                .font(.caption2)
                .fontWeight(.semibold)
            Text(product.aboutProduct)
                .font(.footnote)
                .fontWeight(.light)
        }
    }
}


#Preview {
    ProductItemView(product: Product.exampleProduct, viewModel: ProductListViewModel(productService: ProductService()))
}
