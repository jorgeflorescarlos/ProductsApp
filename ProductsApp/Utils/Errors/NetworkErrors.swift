//
//  ApiError.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//

import Foundation

struct NetworkErrors {
    enum APIError {
        case failedToGetData
        case failedToManageLocalData
    }
}

extension NetworkErrors.APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToGetData:
            return NSLocalizedString("Ocurrió un error al consultar el servicio. ¿Quieres intentar nuevamente?", comment: "Request failed to get data")
            
        case .failedToManageLocalData:
            return NSLocalizedString("Hubo un problema al guardar/borrar este show de TV. ¿Quieres intentar nuevamente?", comment: "Request failed to get data")
        }
    }
}

