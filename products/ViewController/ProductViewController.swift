//
//  ProductViewController.swift
//  products
//
//  Created by Ecem Mine Ozyedierler on 7.11.2019.
//

import UIKit

class ProductViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = ProductViewModel()
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       bindViewModel()
       fetchProductList()
    }
    
    fileprivate func bindViewModel() {
    //Observe loading and show startLoading if it is true, stop loading if it is false.
        viewModel.loading.bind { [weak self] (loading) in
           if loading{
                self?.startLoading()
           }else{
             self?.stopLoading()
             self?.prepareCollectionView()
        }
      }
    }
    
    func prepareCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        let cell = UINib(nibName: "ProductCell", bundle: nil)
        collectionView.register(cell,forCellWithReuseIdentifier: "ProductCell")
    }
    
    func fetchProductList() {
        
        viewModel.fetchProductList(success: { [weak self] (data) in
            if let data = data {
                self?.products = data
                self?.prepareCollectionView()
            }
            
        }) { [weak self] (text) in
            self?.showAlert(text: text)
        }
    }
    
    func getProductDetailData(_ item: Product){
      
        viewModel.fetchProductDetail(productId: item.product_id!, success: { [weak self] (data) in
            if let data = data {
                self?.openProductDetail(product: data)
            }
            
        }) { [weak self] (text) in
            self?.showAlert(text: text)
        }
    }
    
    func openProductDetail(product: ProductDetailResponseModel){
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetail") as? ProductDetailViewController {
            if let navigator = navigationController {
                viewController.productName = product.name
                viewController.imageUrl = product.image
                viewController.productDescription = product.description
                navigator.pushViewController(viewController, animated: true)
            }
        }
        
    }
    
}

extension ProductViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        cell.configureWith(products[indexPath.row])
        return cell
    }
    
}

extension ProductViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let item = products[indexPath.row]
        if let dataModel = item as? Product {
            getProductDetailData(dataModel)
        }
    }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let padding: CGFloat = 10
    let collectionCellSize = collectionView.frame.size.width - padding

    return CGSize(width: collectionCellSize/2, height: collectionCellSize/2)

   }

}


