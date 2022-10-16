//
//  PopularModel.swift
//  SunGlass
//
//  Created by Zardasht on 10/8/22.
//

import Foundation

struct PopularModel {
    
    let title:String
    let image:String
    let price:Double
    let descriptons:String

}

enum PopularModels {
    
    case popularView(PopularModel)
    
}
