//
//  ColorViewRing.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//

import UIKit

class ColorViewRing: UIView {
    
    func configureBackground (hex: String){
        backgroundColor = UIColor(hex: hex)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            layer.borderColor = UIColor.label.cgColor
        } else {
            layer.borderColor = UIColor.black.cgColor
        }
    }
    
}
