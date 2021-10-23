//
//  ProductsResponse.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//

import Foundation

    // MARK: - Products
struct ProductsResponse: Codable {
//    let status: Status
    let pageType: String
    let plpResults: PlpResultsResponse
}
