//
//  ProductDetailViewController.swift
//  products
//
//  Created by Ecem Mine Ozyedierler on 8.11.2019.
//

import UIKit

class ProductDetailViewController: BaseViewController {
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var imageUrl: String? = ""
    var productName: String? = ""
    var productDescription: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()

    }
    
    func initView(){
        
        image.contentMode = .scaleToFill
        image.setImage(imageUrl: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        
        lblDescription.textColor = UIColor.black
        lblDescription.font = UIFont.systemFont(ofSize: 14)
        lblDescription.text = productDescription
        
        navItem.title = productName
        
    }
    
    
}

