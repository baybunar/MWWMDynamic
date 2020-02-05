//
//  Request.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 17.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import Alamofire

struct Request {
    let url: String
    let method: HTTPMethod
    let parameters: Parameters?
    let headers: HTTPHeaders?
    
    init(url: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
    
}
