//
//  ApiController.swift
//  SunGlass
//
//  Created by Zardasht on 10/8/22.
//

import Foundation
import RxSwift
import RxCocoa


struct Api {

    func makeRequest() -> Observable<Data> {
        let baseURL = "https://www.starbucks.com/bff/ordering/menu"
//        let baseURl = "https://api.sampleapis.com/coffee/hot"
        let url = URL(string: baseURL)
        var request = URLRequest(url: url!)
        let session = URLSession.shared
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return session.rx.data(request: request)
    }
    
    func makeRequestBucks() -> Observable<Data> {
        let baseURL = "https://0k1qvj.a.searchspring.io/api/search/search.json?userId=bb3cce5c-9f46-4201-a959-a7a32df040e7&domain=https%3A%2F%2Fwww.vervecoffee.com%2Fcollections%2Fall-coffee%3Fppage%3D2%23%2Fview%3Aproducts&siteId=0k1qvj&page=2&bgfilter.collection_handle=all-coffee&redirectResponse=full&resultsFormat=native"
        
        let url = URL(string: baseURL)
        var request = URLRequest(url: url!)
        let session = URLSession.shared
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return session.rx.data(request: request)
    }
    
}

