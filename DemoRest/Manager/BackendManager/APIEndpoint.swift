//
//  APIEndpoint.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import Foundation
import ObjectMapper

class ApiEndpoint<T: Mappable> {
    
    var config: BackendConfiguration {
        return BackendManager.defaultConfiguration
    }
}
