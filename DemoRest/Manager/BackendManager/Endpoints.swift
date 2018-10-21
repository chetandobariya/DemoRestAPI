//
//  Endpoints.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import Foundation
import Alamofire

class BaseEndpoint: APIRequestConvertible {
    
    var config: BackendConfiguration {
        
        return BackendManager.defaultConfiguration
    }
    
    var encoding: ParameterEncoding {
        
        return URLEncoding.default
    }
    
    var headers: HTTPHeaders? {
        
        return nil
    }
    
    var parameters: Parameters? {
        
        return nil
    }
    
    var method: HTTPMethod {
        
        return .get
    }
    
    func url() throws -> URL {
        
        return try self.config.baseUrl()
    }
}

class RepositoriesDataEndPoint: ApiEndpoint<Repositories>, APIRequestConvertible {
    
    var encoding: ParameterEncoding {

        return JSONEncoding.default
    }

    func url() throws -> URL {
        
        return try self.config.baseUrl().appendingPathComponent("repositories")
    }
}


