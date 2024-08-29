import SwiftUI



struct ProductDetailView: View {
    @ObservedObject var viewModel: ProductDetailViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            ProductImage(imageUrl: viewModel.product.imageUrl)
                .frame(width: 150,height: 150)
            Text(viewModel.product.name)
                .font(.largeTitle)
            Text("\(viewModel.product.price, specifier: "%.2f") TL")
                .font(.title2)
            Text(viewModel.product.aboutProduct)
                .font(.body)
            Spacer()
            Button {
                Task {
                    await viewModel.addProductToCart()
                }
                
            } label: {
                Text(TextTheme.addCart.rawValue)
                    .foregroundStyle(Color(hex: ColorTheme.secondaryColor.rawValue) ?? Color.white)
                    .fontWeight(.semibold)
                    .font(.title2)
                    .padding(.vertical)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(Color(hex: ColorTheme.primaryColor.rawValue))
                    .cornerRadius(10)
            }

        }
        .padding()
        .navigationTitle(viewModel.product.name)
        
    }
}


#Preview {
    ProductDetailView(viewModel: ProductDetailViewModel(product: Product.exampleProduct))
}
