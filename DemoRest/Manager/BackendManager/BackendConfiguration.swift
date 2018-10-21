//
//  BackendConfiguration.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import Foundation

protocol BackendConfiguration {
    
    func baseUrl() throws -> URL
    var timeout: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension BackendConfiguration {
    
    var timeout: TimeInterval {
        
        return 10.0
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        
        return .useProtocolCachePolicy
    }
}

struct LiveConfiguration: BackendConfiguration {
    
    func baseUrl() throws -> URL {
        
        if let url = URL(string: "https://api.github.com/") {
            return url
        }
        
        throw APIRequestError.invalidUrl(errorDescription: String(describing: self))
    }
}

struct TestConfiguration: BackendConfiguration {
    
    func baseUrl() throws -> URL {
        
        if let url = URL(string: "https://api.github.com/") {
            return url
        }
        
        throw APIRequestError.invalidUrl(errorDescription: String(describing: self))
    }
}


