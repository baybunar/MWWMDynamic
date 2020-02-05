//
//  NetworkService.swift
//  MWWMDynamic
//
//  Created by Can Baybunar on 13.06.2019.
//  Copyright © 2019 Baybunar. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetworkService {
    
    typealias ResponseHandler = (_ result: Response?, _ error: ErrorModel?) -> Void
    
    static let shared = NetworkService()
    
    private var manager: Alamofire.SessionManager = {
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default)
        
        return manager
    }()
    
    func callService(request: Request, resultHandler: @escaping ResponseHandler) {
        manager.request(request.url, method: request.method, parameters: request.parameters, encoding: request.method == .get ? URLEncoding.default : JSONEncoding.default, headers: request.headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                resultHandler(Response(result: true, json: JSON(data)), nil)
            case.failure(_):
                resultHandler(Response(result: false, json: nil), ErrorModel(errorCode: "", errorType: .general, errorMessage: ""))
            }
        }
    }

}
