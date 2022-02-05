//
//  Protocols.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 05.02.2022.
//

import Foundation
import UIKit

protocol ReusableCell {
    static var identifier: String {get}
}


extension ReusableCell where Self: UICollectionViewCell  {
    
    static func registerClass(into collection: UICollectionView) {
        print("my identifier is \(identifier)")
        collection.register(self, forCellWithReuseIdentifier: identifier)
    }
    
}
