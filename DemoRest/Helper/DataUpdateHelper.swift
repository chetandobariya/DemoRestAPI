//
//  DataUpdateHelper.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import UIKit
import ObjectMapper

/// The DataUpdateHelper acts as an interface to the BackendManager providing app data updating functionality.

class DataUpdateHelper {
    
    static let shared = DataUpdateHelper()
    private let backendManager = BackendManager()
    
    
    func fetchRepositoriesData(completion: @escaping (Result<[Repositories]>) -> Void) {
        
        let endPoint = RepositoriesDataEndPoint()
        
        self.backendManager.requestObjects(from: endPoint, completion: { result in
            completion(result)
        })
        
    }
}
