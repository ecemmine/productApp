//
//  Dynamic.swift
//  products
//
//  Created by ecem mine özyedierler on 7.11.2019.
//

import Foundation

class Dynamic<T>{
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?){
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?){
        self.listener = listener
        listener?(value)
    }
    
    var value: T{
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T){
        value = v
    }
}
