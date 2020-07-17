//
//  Product.swift
//  Market List
//
//  Created by Arsalan Iravani on 17.07.2020.
//

import Foundation
import Firebase

enum Metrics: String, Codable {
    case kg, litr, pieces
}

struct Product: Codable, Equatable, Hashable {
    var id: String?
    var name: String?
    var category: String?
    var price: Double?
    var metric: Metrics?
    var amount: Double?
    var isBought: Bool? = false
    var numberOfSelectedTimes: Int?

    init(name: String?, category: String? = nil) {
        self.name = name
        self.category = category
        self.isBought = false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name ? true : false
    }

    mutating func increaseAmount(by step: Double = 1) {
        if amount == nil {
            amount = 2
        } else {
            amount! += step
        }



    }
}
