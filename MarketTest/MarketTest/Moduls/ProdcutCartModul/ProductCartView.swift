//
//  ProductCartView.swift
//  MarketTest
//
//  Created by Engin Gülek on 22.08.2024.
//

import SwiftUI

struct ProductCartView: View {
    @StateObject private var viewModel = CartProductViewModel(service: CartProductService())
    @Environment(\.presentationMode) private var presentationMode
   
    var body: some View {
        NavigationView(content: {
            if viewModel.returnProductView {
                VStack {}.onAppear{
                    presentationMode.wrappedValue.dismiss()
                }
            }else{
                ZStack(alignment:.bottom,content: {
                    ScrollView {
                        LazyVStack(content: {
                            ForEach(viewModel.cartList,id:\.self) { cartProduct in
                                HStack {
                                    CartProductItemView(product: cartProduct)
                                    Spacer()
                                    HStack(spacing:0){
                                        
                                        Button(action: {
                                            Task{
                                                await viewModel.didTappedDecreaseButton(id: cartProduct.id)
                                            }
                                        }, label: {
                                            Image(
                                                systemName:viewModel.decreaseOrClearType(cartProduct: cartProduct)
                                            )
                                                .foregroundStyle(.purple)
                                                .fontWeight(.semibold)
                                        })
                                        .frame(width: 25,height: 25)
                                        .padding(6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 0)
                                                .fill(Color.white)
                                                .shadow(
                                                    color:.purple.opacity(0.7),
                                                    radius: 2
                                                )
                                            
                                        )
                                        
                                        Text("\(cartProduct.quantity)")
                                            .frame(width: 25,height: 25)
                                            .padding(6)
                                            .background(Color.purple)
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.white)
                                        
                                        Button(action: {
                                            Task{
                                                await viewModel.didTappedIncrementButton(id: cartProduct.id)
                                            }
                                        }, label: {
                                            Image(systemName: ImageTheme.plus.rawValue)
                                                .foregroundStyle(.purple)
                                                .fontWeight(.semibold)
                                            
                                        })
                                        .frame(width: 25,height: 25)
                                        .padding(6)
                                        .background(
                                            RoundedRectangle(cornerRadius: 0)
                                                .fill(Color.white)
                                                .shadow(
                                                    color:.purple.opacity(0.7),
                                                    radius: 2)
                                            
                                        )
                                    }
                                }
                            }
                        }).padding(.horizontal)
                    }
                    .navigationTitle(NavgationTitle.carts.rawValue)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                Task{
                                    await viewModel.didTappedClearAllButton()
                                }
                            }, label: {
                                Image(systemName: ImageTheme.trash.rawValue)
                                    .foregroundStyle(.purple)
                            })
                        }
                    })
                    ContiuneButton(totalPrice: viewModel.cartTotalPrice)
                })
            }
        }).task {
            await viewModel.loadCartProduct()
        }
    }
}


#Preview {
    ProductCartView()
}
