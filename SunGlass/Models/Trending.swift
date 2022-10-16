//
//  Trending.swift
//  SunGlass
//
//  Created by Zardasht on 10/9/22.
//

import Foundation

struct StarBucks:Decodable {
    let results: [Result]
}
struct Result:Decodable {
    
    let brand:String
    let imageUrl:String
    let name:String
    let price:String
    let ss_available:String
    
}





struct StarBucks1:Decodable {

    let menus: [Menu]

}

struct Menu:Decodable {

    let name:String
    let children: [Children]
}

struct Children:Decodable {

    let name:String
    let children: [Childrens]
}

struct Childrens:Decodable  {

    let name:String
    let products: [Products]
}

struct Products:Decodable {
    let name:String
    let assets: MasterImage
}
struct MasterImage:Decodable {
    let masterImage: URI
}
struct URI:Decodable {
    let uri:String?
    
    
}
