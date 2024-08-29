import Foundation
protocol ProductListViewModelProtocol: ObservableObject {
    var products: [Product] { get }
    var categories : [Category] {get}
    var subCategories : [SubCategory] {get}
    var errorStata : Bool {get}
    var cartTotalPrice : String {get}
    var selectedSubCategoryId :  Int {get}
    var selectedBaseCategoryId : Int {get}
    var progressViewAction:Bool {get}
    func loads() async
    func didSelectedBaseCategory(id:Int) async
    func didSelectedSubCategory(id:Int) async
    func subCategoryColorTheme(id:Int) -> (textColor:String,backColor:String)
    func addButtonTapped(product_id:Int) async
    func didTappedDecreaseButtonTapped(id:Int) async
    
}

class ProductListViewModel {
    
    
    @Published var categories: [Category] = []
    @Published var subCategories : [SubCategory] = []
    @Published var selectedSubCategoryId : Int = 1
    @Published var progressViewAction : Bool = false
    @Published var selectedBaseCategoryId: Int = 1
    @Published var products: [Product] = []
    @Published var errorStata: Bool = false
    @Published var cartTotalPrice : String = "0"
    
    private let productService: ProductServiceProtocol
    private var cartProducts : [Cart] = []
    
    init(productService: ProductServiceProtocol) {
        self.productService = productService
    }
    
    private  func loadProducts(subCategoryId:Int) async  {
        progressViewAction = true
        do{
            products = []
            let productsList =  try await productService.fetchProducts(subCategoryId: subCategoryId)
            cartProducts = try await productService.fetchCartProducts(userId: 1)
            
            productsList.forEach { product in
                if let matchindCartProduct = cartProducts.first(where: { $0.product_id == product.id }){
                    var changedProduct = product
                    changedProduct.piece = matchindCartProduct.quantity
                    products.append(changedProduct)
                }else{
                    products.append(product)
                }
            }
            calculateCartTotalPrice()
            
            errorStata = false
            progressViewAction = false
        }catch{
            errorStata = true
            progressViewAction = false
        }
        
    }
    
    
    
    private  func loadCategories() async {
        do{
            categories = try await productService.fetchCategories()
            subCategories = categories[0].subCategories
            errorStata = false
        }catch{
            
            errorStata = true
        }
    }
    
    private func calculateCartTotalPrice()  {
        let totalCartValue = cartProducts.reduce(into: 0) { (result, product) in
            result += (product.price * Double(product.quantity))
        }
        cartTotalPrice =  String(format: "%.2f", totalCartValue)
    }
    
}


extension ProductListViewModel : ProductListViewModelProtocol {
    func loads() async {
        await loadProducts(subCategoryId: selectedSubCategoryId)
        await loadCategories()
        
        
    }
    
    func didSelectedBaseCategory(id: Int) async {
        let categoryId = id - 1
        selectedSubCategoryId = categories[categoryId].subCategories[0].id
        selectedBaseCategoryId = id
        subCategories = categories[categoryId].subCategories
        await loadProducts(subCategoryId: selectedSubCategoryId)
    }
    
    func didSelectedSubCategory(id:Int) async  {
        selectedSubCategoryId = id
        await loadProducts(subCategoryId: id)
        
    }
    
    func subCategoryColorTheme(id:Int) -> (textColor:String,backColor:String) {
        var textColor :String
        var backColor : String
        
        if id == selectedSubCategoryId {
            textColor =  ColorTheme.secondaryColor.rawValue
            backColor = ColorTheme.primaryColor.rawValue
        }else{
            textColor =  ColorTheme.primaryColor.rawValue
            backColor = ColorTheme.secondaryColor.rawValue
        }
        return (textColor,backColor)
    }
    
    
    func addButtonTapped(product_id: Int) async {
        do{
            let cartProductParameter : [String:Any] = ["user_id":1,"product_id":product_id]
            try await productService.addProductToCart(parameter: cartProductParameter)
            await loadProducts(subCategoryId: selectedSubCategoryId)
        }catch{
            await loadProducts(subCategoryId: selectedSubCategoryId)
        }
    }
    
    func didTappedDecreaseButtonTapped(id: Int) async {
        do {
            guard  let cart = cartProducts.filter({ $0.product_id == id }).first else {
                return
            }
            
            try await productService.decreaseProductFromCart(cartId: cart.id)
            await loadProducts(subCategoryId: selectedSubCategoryId)
        }catch{
            await loadProducts(subCategoryId: selectedSubCategoryId)
        }
    }
}
