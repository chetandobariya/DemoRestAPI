//
//  UITableView+Custom.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import UIKit

extension UITableView {
    
    open func registerNib<T: UITableViewCell>(cellType: T.Type, reuseIdentifier: String? = nil) {
        
        let cellClassName = String(describing: cellType)
        let cellNib = UINib(nibName: cellClassName, bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: reuseIdentifier ?? cellClassName)
    }
    
    open func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type, reuseIdentifier: String? = nil, for indexPath: IndexPath) -> T {
        
        let cellClassName = String(describing: cellType)
        return self.dequeueReusableCell(withIdentifier: reuseIdentifier ?? cellClassName, for: indexPath) as! T
    }
    
    internal func getFirstVisibleCell<T>(of cellType: T) -> T? {
        
        let visibleCells = self.visibleCells
        let cells = visibleCells.filter( { $0 is T } )
        if cells.isEmpty { return nil }
        return cells.first as? T
    }
}
