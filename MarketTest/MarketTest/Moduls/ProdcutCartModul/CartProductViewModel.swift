import Foundation

protocol CartProductViewModelProtocol : ObservableObject {
    //var cartProducts : [CartProduct] {get}
    var cartList : [Cart] {get}
    var cartTotalPrice : String {get}
    var errorStata : Bool {get}
    func loadCartProduct() async
    var returnProductView : Bool {get}
    func didTappedDecreaseButton(id:Int) async
    func didTappedIncrementButton(id:Int) async
    func didTappedClearAllButton() async
    func decreaseOrClearType(cartProduct:Cart) -> String
}


class CartProductViewModel : CartProductViewModelProtocol {

 
    @Published var returnProductView: Bool = false
    
    
    
    //@Published var cartProducts: [CartProduct] = []
    @Published var cartTotalPrice : String = "0"
    @Published var cartList: [Cart] = []
    
    private let service : CartProductServiceProtocol
    var errorStata: Bool = false
    
    init(service: CartProductServiceProtocol) {
        self.service = service
    }
    
    func loadCartProduct() async {
        do{
            cartList = try await service.fetchCartProducts(userId: 1)
            calculateCartTotalPrice()
            if cartList.isEmpty {
                returnProductView = true
            }else{
                returnProductView = false
            }
            errorStata = false
        }catch{
            errorStata = true
           
        }
    }
    
    
    func didTappedDecreaseButton(id: Int) async {
        do{
            try await service.decreaseProductFromCart(cartId: id)
            await loadCartProduct()
        }catch{
            await loadCartProduct()
            
        }
    }
    
    func didTappedIncrementButton(id: Int) async {
        do{
            try await service.incrementProductFromCart(cartId: id)
            await loadCartProduct()
        }catch{
            await loadCartProduct()
        }
    }
    
    
    func didTappedClearAllButton() async {
        do{
            try await service.clearCartAll(userId: 1)
        }catch{
           errorStata = true
        }
    }
    
    func decreaseOrClearType(cartProduct: Cart) -> String {
        return cartProduct.quantity == 1 ? ImageTheme.trash.rawValue
        : ImageTheme.minus.rawValue
    }
    
    
    
    
    private func calculateCartTotalPrice()  {
     
        let totalCartValue = cartList.reduce(into: 0.0) { result, cartProduct in
            result += Double(cartProduct.quantity) * cartProduct.price
        }

      
        cartTotalPrice =  String(format: "%.2f", totalCartValue)
    }
    
    
    
    
    
    
    
    
}
