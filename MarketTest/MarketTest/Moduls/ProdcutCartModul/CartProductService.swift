import Foundation


protocol CartProductServiceProtocol {
    func fetchCartProducts(userId:Int) async throws -> [Cart]
    func decreaseProductFromCart(cartId:Int) async throws
    func  incrementProductFromCart(cartId:Int) async throws
    func clearCartAll(userId:Int) async throws
   
}



class CartProductService : CartProductServiceProtocol {

    
    private let networkManager : NetworkManagerProtocol = NetworkManager()
    
    /// This function fetchs cart products for database
    /// - Parameter userId: id of use for cart Productss
    /// - Returns: [Carts]
    func fetchCartProducts(userId: Int) async throws -> [Cart] {
        do{
            let response = try await networkManager.fetch(
                target: .cartProductByUser(userId),
                responseClass: [Cart].self)
            return response
        }catch{
            throw error
        }
        
    }
    
    /// When decrease buttom was clicked, qıantiy of product on cart decreases
    /// - Parameter cartId: id for cart product
    func decreaseProductFromCart(cartId: Int) async throws {
        do {
            _ = try await networkManager.fetch(target: .decreaseProduct(cartId), responseClass: String?.self)
        }catch {
            throw error
        }
    }
    
    /// When increment buttom was clicked, qıantiy of product on cart increments
    /// - Parameter cartId: id for cart product
    func incrementProductFromCart(cartId: Int) async throws {
        do {
            _ = try await networkManager.fetch(target: .incrementProduct(cartId), responseClass: String?.self)
        }catch {
            throw error
        }
    }
    
    
    /// When trash buttom on navgaton  was clicked, all product on cart
    /// - Parameter userId: id of user
    func clearCartAll(userId: Int) async throws {
        do {
            _ = try await networkManager.fetch(target: .clearCartAll(userId), responseClass: String?.self)
        }catch{
            throw error
        }
    }
}
