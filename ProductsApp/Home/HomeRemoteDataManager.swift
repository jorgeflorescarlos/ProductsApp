//
//  HomeRemoteDataManager.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//  
//

import Foundation

class HomeRemoteDataManager:HomeRemoteDataManagerInputProtocol {
    
    var urlParams = ""
    var paginationNumber = 0
    
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol?
    
    func getProducts(with searchTerm: String, page: Int = 0) {
        paginationNumber = page
        urlParams = "?search-string=\(searchTerm)&page-number=\(page)"
        self.getProducts()
    }
    
    func getProducts() {
        let url = "\(Config.urlBase)\(urlParams)"
        
        NetworkDataManager.instance.get(withUrl: url) { [weak self] (result: Result<ProductsResponse, Error>) in
            print(url)
            switch result {
            case .success(let response):
                var products : [Product] = []
                products = response.plpResults.records.compactMap { record in
                    let product = Product(
                        name: record.productDisplayName,
                        price: record.listPrice,
                        promoPrice: record.promoPrice,
                        maximumListPrice: record.maximumListPrice,
                        maximumPromoPrice: record.maximumPromoPrice,
                        category: record.category,
                        thumbnail: record.smImage,
                        coverImage: record.lgImage,
                        variantsColor: record.variantsColor)
                    return product
                }
                DispatchQueue.main.async {
                    if self?.paginationNumber == 0 {
                        self?.remoteRequestHandler?.sendDataToPresenter(with: products)
                    } else {
                        self?.remoteRequestHandler?.appendDataToPresenter(with: products)
                    }
                   
                }
                
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
