//
//  ProductResponseModel.swift
//  products
//
//  Created by Ecem Mine Ozyedierler on 7.11.2019.
//

import Foundation
import UIKit

open class ProductResponseModel : Codable {
    
    let products : [Product]?
    
    enum CodingKeys: String, CodingKey {
        
        case products = "products"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent([Product].self, forKey: .products)
    }
    
}

open class Product : Codable {
    let product_id : String?
    let name : String?
    let price : Int?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case product_id = "product_id"
        case name = "name"
        case price = "price"
        case image = "image"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
    required public init(id: String?, productName: String?, productPrice: Int?, productImage: String?) throws{
    
        product_id = id
        name = productName
        price = productPrice
        image = productImage
    }
    
}
