//
//  Response.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 17.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Response {
    var result: Bool
    var json: JSON?
    
    init(result: Bool, json: JSON?) {
        self.result = result
        self.json = json
    }
    
}
