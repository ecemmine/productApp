//
//  AppUrl.swift
//  products
//
//  Created by Ecem Mine Ozyedierler on 7.11.2019.
//

import Foundation

struct Domain {
    static let dev = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart/"
}
extension Domain {
    static func baseUrl() -> String {
        return Domain.dev
    }
}

struct APIEndpoint {
    static let products = "list"
    static let productDetail = "/detail"
}


enum HTTPHeaderField: String {
    case authentication  = "Authorization"
    case contentType     = "Content-Type"
    case acceptType      = "Accept"
    case acceptEncoding  = "Accept-Encoding"
    case acceptLangauge  = "Accept-Language"
}

enum ContentType: String {
    case json            = "application/json"
    case multipart       = "multipart/form-data"
    case ENUS            = "en-us"
}

