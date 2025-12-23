//
//  Item.swift
//  CounterApp
//
//  Created by Collins Roy on 23/12/25.
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
