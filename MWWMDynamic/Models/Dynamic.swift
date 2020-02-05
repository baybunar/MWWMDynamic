//
//  Dynamic.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 20.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit

class Dynamic<T> {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
}
