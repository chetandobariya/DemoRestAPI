//
//  BackendManager.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import AlamofireNetworkActivityIndicator
import ObjectMapper

/// Handles communication with backend
class BackendManager {
    
    static var defaultConfiguration: BackendConfiguration {
        
        #if CONFIGURATION_Debug

            return TestConfiguration()
        
        #elseif CONFIGURATION_Enterprise
        
            return LiveConfiguration()
        
        #else // CONFIGURATION_Appstore

            return LiveConfiguration()
        
        #endif
    }
    
    private let sessionManager: Alamofire.SessionManager = {
        
        NetworkActivityIndicatorManager.shared.isEnabled = true
        let manager = Alamofire.SessionManager()
        return manager
    }()
    
    private let syncQueue = DispatchQueue(label: "BackendManager.syncQueue", attributes: [])
    private var pendingRequests = [URLRequest: APIRequest]()
    
    deinit {
        self.cancelAllRequests()
    }
    
    class func encodedUrlRquest(for endpoint: APIRequestConvertible) throws -> URLRequest  {
        
        var urlRequest = try URLRequest(url: try endpoint.url(), method: endpoint.method, headers: endpoint.headers)
        urlRequest.cachePolicy = endpoint.config.cachePolicy
        urlRequest.timeoutInterval = endpoint.config.timeout
        urlRequest.httpShouldHandleCookies = false
        
        urlRequest.allHTTPHeaderFields = HTTPCookie.requestHeaderFields(with: HTTPCookieStorage.shared.cookies ?? [])
        
        return try endpoint.encoding.encode(urlRequest, with: endpoint.parameters)
    }
    
    @discardableResult
    func cancelAllRequests() -> [APIRequest] {
        
        let requests = self.pendingRequests
        requests.forEach
            { (request) in
                request.value.cancel()
        }
        return requests.map({ $0.value })
    }
    

    @discardableResult
    func requestObjects<EndPoint, ModelType>(from endPoint: EndPoint, progressHandler: @escaping (Progress) -> Void = { (_) in }, completion: @escaping (Result<[ModelType]>) -> Void) -> APIRequest? where EndPoint: ApiEndpoint<ModelType>, EndPoint: APIRequestConvertible, ModelType: Mappable {
        
        switch self.validatedRequest(endPoint: endPoint, progressHandler: progressHandler) {
            
        case .failure(let error):
            completion(.failure(error))
            return nil
            
        case .success(let apiRequest):
            apiRequest.dataRequest.responseArray(keyPath: endPoint.dataKeyPath, completionHandler:
                { (response: DataResponse<[ModelType]>) -> Void in
                    
                    switch response.result {
                        
                    case .failure(let error):
                        completion(.failure(error))
                        
                    case .success(let objects):
                        completion(.success(objects))
                    }
            })
            
            return apiRequest
        }
    }
    
    final func didReceive(response: DefaultDataResponse, for apiRequest: APIRequest) {
        self.removePendingRequest(apiRequest)
    }
    
    private final func validatedRequest(endPoint: APIRequestConvertible, progressHandler: @escaping (Progress) -> Void = { (_) in }) -> Result<APIRequest> {
        
        let requestResult = self.createRequest(endPoint: endPoint, progressHandler: progressHandler)
        switch requestResult {
            
        case .failure(let error):
            return .failure(error)
            
        case .success(let request):
            
            request.dataRequest.validate(endPoint.validationBlock)
            return .success(request)
        }
    }
    
    private final func createRequest(endPoint: APIRequestConvertible, progressHandler: @escaping (Progress) -> Void = { (_) in }) -> Result<APIRequest>
    {
        do {
            
            let encodedUrlRequest = try BackendManager.encodedUrlRquest(for: endPoint)
            
            let dataRequest = self.sessionManager.request(encodedUrlRequest)
            let apiRequest = APIRequest(endPoint: endPoint, request: dataRequest)
            
            dataRequest.response(completionHandler:
                { [unowned self] (response) in
                    self.didReceive(response: response, for: apiRequest)
            })
            dataRequest.downloadProgress(closure: progressHandler)
            
            self.syncQueue.sync {
                
                    if let request = dataRequest.request {
                        
                        self.pendingRequests[request] = apiRequest
                    }
            }
            
            return .success(apiRequest)
            
        } catch (let error) {
            return .failure(error)
        }
    }
    
    private func removePendingRequest(_ apiRequest: APIRequest) {
        
        self.syncQueue.sync {
            
            if let request = apiRequest.urlRequest {
                self.pendingRequests[request] = nil
            }
        }
    }
}

extension DataRequest: Equatable {
    
    public static func ==(lhs: DataRequest, rhs: DataRequest) -> Bool {
        return lhs.session == rhs.session
    }
}
