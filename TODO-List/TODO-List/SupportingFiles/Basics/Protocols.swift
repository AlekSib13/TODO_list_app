//
//  Protocols.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 05.02.2022.
//

import Foundation
import UIKit

protocol ReusableCollectionCell {
    static var identifier: String {get}
}


extension ReusableCollectionCell where Self: UICollectionViewCell  {
    
    static func registerClass(into collection: UICollectionView) {
        collection.register(self, forCellWithReuseIdentifier: identifier)
    }
    
    static func load(into collection: UICollectionView, for indexPath: IndexPath) -> Self {
        collection.dequeueReusableCell(withReuseIdentifier: self.identifier, for: indexPath) as! Self
    }
}


protocol ReusableTableCell {
    static var identifier: String {get}
}

extension ReusableTableCell where Self: UITableViewCell {
    
    static func registerClass(into table: UITableView) {
        table.register(self, forCellReuseIdentifier: identifier)
    }
    
    static func load(into table: UITableView, for indexPath: IndexPath) -> Self {
        table.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! Self
    }
    
}
