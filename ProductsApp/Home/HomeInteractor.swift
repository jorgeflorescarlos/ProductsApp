//
//  HomeInteractor.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//  
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: HomeInteractorOutputProtocol?
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol?
    
}

extension HomeInteractor: HomeRemoteDataManagerOutputProtocol {
    func appendDataToPresenter(with products: [Product]) {
        presenter?.appendDataToView(products)
    }
    
    func sendDataToPresenter(with products: [Product]) {
        presenter?.pushDataToView(products)
    }
    
    
}
