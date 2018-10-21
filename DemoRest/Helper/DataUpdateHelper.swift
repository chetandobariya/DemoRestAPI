//
//  DataUpdateHelper.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import ObjectMapper
import ReachabilitySwift

/// The DataUpdateHelper acts as an interface to the BackendManager providing app data updating functionality.

class DataUpdateHelper {
    
    static let shared = DataUpdateHelper()
    private let backendManager = BackendManager()
    
    private let reachabilityHelper: Reachability? = {
        
        var reachabilityHelper: Reachability? = nil
        
        if let url = try? BaseEndpoint().url(),
            let reachability = Reachability(hostname: url.absoluteString) {
            
            return reachability
        }
        
        return nil
    }()

    private var updateRepositoriesIfReachable: (() -> Void)? = nil

    init() {
        self.setupReachabilityObserver()
    }
    
    private func setupReachabilityObserver() {
        
        self.reachabilityHelper?.whenReachable = { [weak self] (_) in
            self?.updateRepositoriesIfReachable?()
        }
        
        do {
            try self.reachabilityHelper?.startNotifier()
            
        } catch (let error) {
            
            print("\(#function) \(error.localizedDescription)")
        }
    }

    
    func fetchRepositoriesData(completion: @escaping (Result<[Repositories]>) -> Void) {
        
        let endPoint = RepositoriesDataEndPoint()
        
        guard let url = try? endPoint.url(),
              let reachability = Reachability(hostname: url.absoluteString) else {
                return
        }
        
        self.backendManager.requestObjects(from: endPoint, completion: { [weak self]  result in
            
            if !reachability.isReachable {
                
                self?.updateRepositoriesIfReachable = {
                    
                    self?.fetchRepositoriesData(completion: completion)
                    self?.updateRepositoriesIfReachable = nil
                }
                
            } else {
                completion(result)
            }
        })
        
    }
}
