//
//  HomeProtocols.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//  
//

import Foundation
import UIKit

protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    
    func setTitle(_ title: String)
    func pushInitialDataToView(with products: [Product])
    func pushAditionalDataToView(with products: [Product])
}

protocol HomeWireFrameProtocol: AnyObject {
    static func createHomeModule() -> UIViewController
}

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var wireFrame: HomeWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func searchProduct(with term: String, page: Int)
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func pushDataToView(_ products :[Product])
    func appendDataToView(_ products :[Product])
}

protocol HomeInteractorInputProtocol: AnyObject {
    var presenter: HomeInteractorOutputProtocol? { get set }
    var remoteDatamanager: HomeRemoteDataManagerInputProtocol? { get set }
    
}

protocol HomeRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: HomeRemoteDataManagerOutputProtocol? { get set }
    func getProducts()
    func getProducts(with searchTerm: String, page: Int)
}

protocol HomeRemoteDataManagerOutputProtocol: AnyObject {
    func sendDataToPresenter(with products: [Product])
    func appendDataToPresenter(with products: [Product])
}
