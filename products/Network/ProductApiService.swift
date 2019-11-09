//
//  ProductApiService.swift
//  products
//
//  Created by Ecem Mine Ozyedierler on 7.11.2019.
//

import Foundation

class ProductAPIService: NSObject, Requestable {
    
    static let instance = ProductAPIService()
    
    public var products: [Product]?
    
    // Prepare the service
    
    func prepare(callback: @escaping([Product]?,Bool) -> Void) {
        
        callback(products!, false)
    }
    
    func fetchProducts(callback: @escaping Handler) {
         let responseType = "product"
        request(method: .get, url: Domain.baseUrl() + APIEndpoint.products, responseType: responseType) { (result) in
            
            callback(result)
        }
        
    }
    func fetchProductDetail(productId: String, callback: @escaping Handler ) {
        let responseType = "productDetail"
        request(method: .get, url: Domain.baseUrl() + productId + APIEndpoint.productDetail, responseType: responseType) { (result) in
            
            callback(result)
        }
        
    }
    
}

