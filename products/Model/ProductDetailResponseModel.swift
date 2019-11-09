//
//  ProductDetailResponseModel.swift
//  products
//
//  Created by Ecem Mine Ozyedierler on 8.11.2019.
//

import Foundation
import UIKit

open class ProductDetailResponseModel : Codable {
    let product_id : String?
    let name : String?
    let price : Int?
    let image : String?
    let description : String?
    
    enum CodingKeys: String, CodingKey {
        
        case product_id = "product_id"
        case name = "name"
        case price = "price"
        case image = "image"
        case description = "description"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
    
}
