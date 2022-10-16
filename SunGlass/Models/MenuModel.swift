
import Foundation

struct WelcomeElement: Codable {
    let title, description: String
    let ingredients: [String]
    let image: String
    let id: Int

   
}

typealias Welcome = [WelcomeElement]


//
//struct MenuManager:Decodable {
//
//    let menus: [Menu]
//
//}
//
//struct Menu:Decodable {
//
//    let name:String
//    let children: [Children]
//}
//
//struct Children:Decodable {
//
//    let name:String
//    let children: [Childrens]
//}
//
//struct Childrens:Decodable  {
//
//    let name:String
//    let products: [Products]
//}
//
//struct Products:Decodable {
//    let name:String
//    let assets: MasterImage
//}
//struct MasterImage:Decodable {
//    let masterImage: URI
//}
//struct URI:Decodable {
//    let uri:String?
//}
//
