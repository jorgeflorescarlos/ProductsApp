//
//  RecordsResponse.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//

import Foundation

    // MARK: - Record
struct RecordResponse: Codable {
//    let productID, skuRepositoryID: String
    let productDisplayName: String
    let listPrice, promoPrice, maximumListPrice, maximumPromoPrice: Double?
    let category: String
    let smImage, lgImage, xlImage: String?
    let variantsColor: [VariantColor?]
}
