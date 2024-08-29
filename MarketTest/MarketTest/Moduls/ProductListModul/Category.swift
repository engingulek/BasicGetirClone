

import Foundation

struct Category : Identifiable,Hashable,Decodable {
    let id : Int
    let name : String
    let subCategories : [SubCategory]
}


struct SubCategory : Identifiable,Hashable,Decodable{
    let id : Int
    let name : String
}
