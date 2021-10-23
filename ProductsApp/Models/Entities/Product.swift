//
//  Product.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//

import Foundation

struct Product {
    let name: String
    let price, promoPrice, maximumListPrice, maximumPromoPrice: Double?
    let category: String
    let thumbnail, coverImage: String?
    let variantsColor: [VariantColor?]
}
