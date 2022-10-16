//
//  TrendingModel.swift
//  SunGlass
//
//  Created by Zardasht on 10/8/22.
//

import Foundation

struct TrendingModel  {
    
    let title:String
    let image:String
    let price:Double
    let descriptons:String

    
}

enum TrendingModels {
    case trendingView(TrendingModel)
    
}
