//
//  BaseViewController.swift
//  products
//
//  Created by ecem mine özyedierler on 7.11.2019.
//

import UIKit

class BaseViewController: UIViewController {
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startLoading(){
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopLoading(){
        
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func showAlert(text: String?){
        
        let alert = UIAlertController(title: "Warning", message: text, preferredStyle: UIAlertController.Style.alert)
                      let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                          exit(0)
                      })
                      alert.addAction(action)
                      self.present(alert, animated: true, completion: nil)
    }
    
}
    


