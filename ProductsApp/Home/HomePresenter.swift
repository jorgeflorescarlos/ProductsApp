//
//  HomePresenter.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//  
//

import Foundation

class HomePresenter  {
    
    // MARK: Properties
    weak var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var wireFrame: HomeWireFrameProtocol?
    
}

extension HomePresenter: HomePresenterProtocol {
    
    func viewDidLoad() {
        view?.setTitle("Products")
        interactor?.remoteDatamanager?.getProducts()
    }
    
    func searchProduct(with term: String, page: Int) {
        if term.count > 0 {
            self.interactor?.remoteDatamanager?.getProducts(with: term, page: page)
        }
       
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func appendDataToView(_ products: [Product]) {
        view?.pushAditionalDataToView(with: products)
    }
    
    func pushDataToView(_ products: [Product]) {
        view?.pushInitialDataToView(with: products)
    }
}
