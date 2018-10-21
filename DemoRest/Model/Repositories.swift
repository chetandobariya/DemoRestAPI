//
//  Repositories.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import Foundation
import ObjectMapper

struct Repositories {
    
    enum JSONKeys: String {
        
        case owner
        case name
        case id
        case fullName = "full_name"
        case description
        case fork
        
    }
    
    private (set) var owner: Owner?
    private (set) var name: String?
    private (set) var description: String?
    private (set) var fullName: String?
    private (set) var id: Int?
    private (set) var fork: Bool?
    
}

extension Repositories: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        self.owner <- map[JSONKeys.owner.rawValue]
        self.id <- map[JSONKeys.id.rawValue]
        self.name <- map[JSONKeys.name.rawValue]
        self.fullName <- map[JSONKeys.fullName.rawValue]
        self.description <- map[JSONKeys.description.rawValue]
        self.fork <- map[JSONKeys.fork.rawValue]
        
    }
}
