
import Foundation

struct Cart:Identifiable,Hashable,Decodable {
    let id: Int
    let imageurl:String
    let name: String
    let about_product: String
    let price: Double
    let quantity : Int
    let product_id:Int
    
    
    static let exampleCartProduct :  Cart = Cart(
        id: 0, imageurl: "https://ideacdn.net/idea/my/16/myassets/products/085/g.png?revision=1698847802",
        name: "Ürün 1",
        about_product: "Açıklama 1",
        price: 10.0,
        quantity: 1,product_id: 1)
}


