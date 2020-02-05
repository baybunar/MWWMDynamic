//
//  ErrorModel.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 17.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit
import SwiftyJSON

class ErrorModel {
    
    var errorCode: String!
    var errorType: ErrorType!
    var errorMessage: String!
    
    init(errorCode: String, errorType: ErrorType, errorMessage: String) {
        self.errorCode = errorCode
        self.errorType = errorType
        self.errorMessage = errorMessage
    }
}

enum ErrorType: Int8 {
    case unknown = 0
    case general = 1
    case warning = 2
    case error = 3
    
}
