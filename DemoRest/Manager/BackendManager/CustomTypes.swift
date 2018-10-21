//
//  CustomTypes.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

enum Result<ResultType> {
    
    case success(ResultType)
    case failure(Error)
}

enum APIRequestError: Error {
    
    case validationFailed(url: URL?, errorDescription: String)
    case invalidUrl(errorDescription: String)
}

enum RequestJSONError: Error {
    
    case parsingFailed
    case mappingFailed
}

enum RequestImageError: Error {
    
    case invalidImageData
    case invalidDataResponse
}
