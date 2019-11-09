//
//  ProductCell.swift
//  products
//
//  Created by Ecem Mine Ozyedierler on 7.11.2019.
//

import UIKit

class ProductCell: UICollectionViewCell{
   
    @IBOutlet weak  var mainView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        priceLabel.textColor = UIColor.black
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        image.contentMode = .scaleToFill
    }
    
    func configureWith(_ productItem: Product?){
        if let product = productItem {
            
            titleLabel.text = product.name ?? ""
            priceLabel.text = "\(product.price ?? 0)"
            image.setImage(imageUrl: product.image, placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    
}
