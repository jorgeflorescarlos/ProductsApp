//
//  ProductTableViewCell.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {

    static let identifier = "ProductTableViewCell"
    
    var leadingCounter = 0.0
    
    let productImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
        return img
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let discountLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.numberOfLines = 0
        return label
    }()
    
    var containerView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true // this will make sure its children do not go out of the boundary
      return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(productImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(discountLabel)
        self.contentView.addSubview(containerView)
        setupConstraints()
    }
    
    func setupConstraints(){
        productImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        productImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        productImageView.widthAnchor.constraint(equalToConstant:120).isActive = true
        productImageView.heightAnchor.constraint(equalToConstant:120).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.productImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:180).isActive = true
        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        discountLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor, constant: 20).isActive = true
        discountLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        discountLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
    }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func configure(with product: Product) {
        if let urlString = product.thumbnail, let url = URL(string: urlString) {
            productImageView.sd_setImage(with: url, completed: nil)
        }
        nameLabel.text = product.name
        if let price = product.price, price != 9999.0 {
            priceLabel.text = "$\(price)"
        } else if let price = product.maximumPromoPrice {
            priceLabel.text = "$\(price)"
        }
       
        
        if let discountPrice = product.promoPrice, discountPrice > 0 {
            discountLabel.text = "$\(discountPrice)"
            strikeThroughText(for: priceLabel)
        } else if let discountPrice = product.maximumPromoPrice, discountPrice > 0 {
            discountLabel.text = "$\(discountPrice)"
            strikeThroughText(for: priceLabel)
        }
        
        for color in product.variantsColor {
            if let hexColor = color?.colorHex, hexColor.count > 6 {
                addRingView(with: hexColor)
                leadingCounter += 28.0
            }
            
        }
        
    }
    func strikeThroughText(for label: UILabel) {
        label.attributedText = label.text?.strikeThrough()
    }
    func addRingView(with color: String){
        let ring = ColorViewRing()
        ring.configureBackground(hex: color)
        containerView.addSubview(ring)
        ring.translatesAutoresizingMaskIntoConstraints = false
        ring.topAnchor.constraint(equalTo:self.discountLabel.bottomAnchor, constant: 10).isActive = true
        ring.heightAnchor.constraint(equalToConstant: 22).isActive = true
        ring.widthAnchor.constraint(equalToConstant: 22).isActive = true
        ring.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant: leadingCounter).isActive = true
        
    }
    
    override func prepareForReuse() {
        leadingCounter = 0
    }

}
