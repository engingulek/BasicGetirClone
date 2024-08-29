import SwiftUI
struct ProductListView: View {
    @StateObject  var viewModel: ProductListViewModel
    var body: some View {
        VStack {
            if viewModel.progressViewAction {
                ProgressView("Yükleniyor...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }else{
                if viewModel.errorStata {
                    Text("Error")
                    
                }else {
                    NavigationView(content: {
                        //MARK: Category List
                        VStack(content: {
                            /// Base Category List
                            VStack {
                                ScrollView(.horizontal,showsIndicators: false) {
                                    LazyHStack(alignment:.center,content: {
                                        ForEach(viewModel.categories, id: \.self) { category in
                                            ZStack(alignment:.bottom) {
                                                Text(category.name).padding()
                                                    .foregroundStyle(Color.white)
                                                    .fontWeight(.semibold)
                                                    .onTapGesture {
                                                        Task {
                                                           await viewModel.didSelectedBaseCategory(id: category.id)
                                                        }
                                                    }
                                                viewModel.selectedBaseCategoryId == category.id ?
                                                Rectangle()
                                                    .fill(Color.yellow)
                                                    .frame(height: 2): nil
                                            }.padding()
                                        }
                                    })
                                }
                            }
                            .frame(height: 60)
                            .background(Color(hex: ColorTheme.primaryColor.rawValue)?.opacity(0.8))
                            

                            /// SubCategoyList
                            VStack {
                                ScrollView(.horizontal,showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(viewModel.subCategories,id:\.self) { subCategory in
                                            let color = viewModel.subCategoryColorTheme(id: subCategory.id)
                                            Text(subCategory.name)
                                                .padding()
                                                .background(
                                                    Color(hex: color.backColor))
                                                .foregroundColor( Color(hex: color.textColor))
                                                .fontWeight(.semibold)
                                                .cornerRadius(10)
                                                .padding()
                                                .onTapGesture {
                                                    Task {
                                                      await  viewModel.didSelectedSubCategory(id: subCategory.id)
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                            .frame(height: 50)
                            
                            //Product List
                            ProductListScrollView(viewModel: viewModel)
                        })
                        
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbarBackground(Color(hex: ColorTheme.primaryColor.rawValue) ?? Color.purple, for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.light, for: .navigationBar)
                        
                        .toolbar(content: {
                            if viewModel.cartTotalPrice != "0.00" {
                                ToolbarItem(placement:.topBarTrailing) {
                                    NavigationLink {
                                        ProductCartView()
                                    } label: {
                                        ToolbarItemView(totalPiece: viewModel.cartTotalPrice)
                                    }
                                }
                            }
                           
                        })
                        .toolbar(content: {
                            ToolbarItem(placement:.principal) {
                                Text(NavgationTitle.products.rawValue)
                                    .foregroundStyle(Color.white)
                            }
                        })
                    })
                }
            }
        
        }.task {
            await viewModel.loads()
        }
    }
}

#Preview {
    ProductListView(viewModel: ProductListViewModel(productService: ProductService()))
}




