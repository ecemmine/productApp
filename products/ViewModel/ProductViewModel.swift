//
//  ProductViewModel.swift
//  products
//
//  Created by Ecem Mine Ozyedierler on 7.11.2019.
//

import UIKit
import CoreData


open class ProductViewModel {
    
    //MARK: - Internal Properties

    var loading: Dynamic<Bool> = Dynamic(false)

    fileprivate var getProductsSuccessClosure: ((_ products : [Product]?) -> Void)?
    fileprivate var getProductsFailureClosure: ((String?) -> Void)?
    
    fileprivate var getProductDetailSuccessClosure: ((_ product : ProductDetailResponseModel?) -> Void)?
    fileprivate var getProductDetailFailureClosure: ((String?) -> Void)?
    
    
    func fetchProductList(success: @escaping (_ products : [Product]?) -> Void, failure: @escaping (String?) -> Void) {
    
        loading.value = true
        getProductsSuccessClosure = success
        getProductsFailureClosure = failure
        
        //Check internet connection. If it is okey make service call, else get cashed products. If there isn't cashed product, show alertdialog.
        if Reachability.isConnectedToNetwork() {
            
            ProductAPIService.instance.fetchProducts { result in
                
                switch result {
                
                case .success(let data):
                    self.loading.value = false
                    let mappedModel = try? JSONDecoder().decode(ProductResponseModel.self, from: data) as ProductResponseModel
                    
                    //If service response is empty, get cashed products. If there isn't cashed product, show alertdialog.
                    let products = mappedModel?.products
                    if  products != nil && products!.count > 0 {
                        
                        self.getProductsSuccessClosure?(products)
                        self.deleteData()
                        self.createData(products: products!)
                       
                    }else{
                        let productList = self.retrieveData()
                        if productList != nil  && productList!.count > 0{
                            self.getProductsSuccessClosure?(productList)
                        }else{
                            self.getProductsFailureClosure?("No product found")
                        }
                    }
                    break
                case .failure(let error):
                    
                    //If the service gets error, shows alertdialog
                    self.loading.value = false
                    self.getProductsFailureClosure?(error.description)
                }
            }
            
        }else {
            //If there isn't internet connection, get cashed products. If there isn't cashed product, show alertdialog.
            loading.value = false
            let productList = self.retrieveData()
            if productList != nil  && productList!.count > 0{
                self.getProductsSuccessClosure?(productList)
            }else{
                self.getProductsFailureClosure?("No product found")
            }
        }
        
        
    }
    
    func fetchProductDetail(productId: String , success: @escaping (_ product : ProductDetailResponseModel?) -> Void, failure: @escaping (String?) -> Void) {
        
        loading.value = true
        
        getProductDetailSuccessClosure = success
        getProductDetailFailureClosure = failure
        
        //Check internet connection. If connection is okey make servise call, else show alertdialog
        if Reachability.isConnectedToNetwork() {
            
            ProductAPIService.instance.fetchProductDetail(productId: productId , callback: {result in
                
                switch result {
            
                case .success(let data):
                    self.loading.value = false
                    let mappedModel = try? JSONDecoder().decode(ProductDetailResponseModel.self, from: data) as ProductDetailResponseModel
                    
                    let product = mappedModel
                    if  let item = product{
                        self.getProductDetailSuccessClosure?(item)
                    }else{
                      self.getProductDetailFailureClosure?("No product found")
                    }
                    break
                case .failure(let error):
                    
                    self.loading.value = false
                    self.getProductDetailFailureClosure?(error.description)
                }
            })
            
        }else{
                self.getProductDetailFailureClosure?("Please check internet connection.")
        }
        
    }
    
    func createData(products : [Product]){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let productEntity = NSEntityDescription.entity(forEntityName: "ProductObject", in: managedContext)!
        
        for productItem in products{
            
            let product = NSManagedObject(entity: productEntity, insertInto: managedContext)
            product.setValue(productItem.product_id, forKeyPath: "product_id")
            product.setValue(productItem.name, forKey: "name")
            product.setValue(productItem.price, forKey: "price")
            product.setValue(productItem.image, forKey: "image")
            
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func retrieveData() ->  [Product]? {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductObject")
        
         var productList = [Product]()
        do {
            let result = try managedContext?.fetch(fetchRequest)
            var counter = 0
            for data in result as! [NSManagedObject] {
                
                let product_id = data.value(forKey: "product_id") as? String
                let name = data.value(forKey: "name") as? String
                let price = data.value(forKey: "price") as? Int
                let image = data.value(forKey: "image") as? String
                
                let product: Product = try Product(id: product_id, productName: name, productPrice: price, productImage: image)
                productList.insert(product, at: counter)
                counter = counter + 1
            }
            
        } catch {
             print(error)
        }
        return productList
    }
    
    func deleteData(){
        
        let productList: [Product]? = retrieveData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductObject")
        
        if productList?.count ?? 0 > 0 {
            do{
                for product in productList!{
                    
                    fetchRequest.predicate = NSPredicate(format: "product_id = %@", product.product_id!)
                    let test = try managedContext.fetch(fetchRequest)
                    
                    let objectToDelete = test[0] as! NSManagedObject
                    managedContext.delete(objectToDelete)
                    
                    do{
                        try managedContext.save()
                    }
                    catch
                    {
                        print(error)
                    }
                    
                }
            }catch{
                print(error)
            }
        }
       
    }
    
}
