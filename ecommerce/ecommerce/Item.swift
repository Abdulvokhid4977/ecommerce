//
//  Item.swift
//  ecommerce
//
//  Created by Abdulvokhid Abdukarimov on 01/10/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
