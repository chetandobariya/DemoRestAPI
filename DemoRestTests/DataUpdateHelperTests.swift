//
//  DataUpdateHelperTests.swift
//  DemoRestTests
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import UIKit
import XCTest
@testable import DemoRest

class DataUpdateHelperTests: XCTestCase {
    
    
    func checkRepositoryItem(_ repositoryItem: Repositories) {
        
        XCTAssertTrue(repositoryItem.name?.isEmpty == false, "item name should not be empty")
        XCTAssertTrue(repositoryItem.name?.isEmpty == false || repositoryItem.owner?.login?.isEmpty == false, "item \(repositoryItem) should either have an url or owner")
        
        if let url = repositoryItem.owner?.avatarUrl {
            
            XCTAssertTrue(url.scheme == "https", "item \(repositoryItem) should provide secure url scheme (\(url))")
        }
    }
    
    func testRepositoryData() {
        
        let responseExpectation = self.expectation(description: "did receive response")
        
        DataUpdateHelper.shared.fetchRepositoriesData { (result) in
            
            responseExpectation.fulfill()
            
            
            var repositories  = [Repositories]()
            if case .success(let newRepositories) = result {
                
                repositories = newRepositories
            }
            
            XCTAssertFalse(repositories.isEmpty, "failed creating objects from response")
            
            for repository in repositories {
                
                self.checkRepositoryItem(repository)
            }
            
            var error: Error? = nil
            if case .failure(let responseError) = result {
                
                error = responseError
            }
            
            XCTAssertNil(error, error!.localizedDescription)
        }
        
        self.waitForExpectations(timeout: 5.0) { (optionalError) in
            
            if let error = optionalError {
                
                print(error.localizedDescription)
            }
        }
    }
    
}
