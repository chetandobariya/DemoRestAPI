//
//  SequenceType+FindFirst.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import Foundation

extension Sequence {
    /**
     returns the first element matching the given type,
     otherwise returns nil if no element matches
     */
    func findFirst<T>(ofType type: T.Type) -> T? {
        
        return self.first(where: { $0 is T }) as? T
    }
    
    /**
     returns all elements matching the given type,
     otherwise returns an empty array if no element matches
     */
    func filter<T>(by type: T.Type) -> [T] {
        
        return self.filter({ $0 is T }) as! [T]
    }
}
