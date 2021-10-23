//
//  PLPResultsResponse.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//

import Foundation

    // MARK: - PlpResults
struct PlpResultsResponse: Codable {
    let label: String
//    let plpState: PlpState
//    let sortOptions: [SortOption]
//    let refinementGroups: [RefinementGroup]
    let records: [RecordResponse]
//    let navigation: Navigation
}
