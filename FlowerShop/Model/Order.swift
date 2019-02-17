//
//  Order.swift
//  FlowerShop
//
//  Created by Bianca Felecan on 2/17/19.
//  Copyright © 2019 BF. All rights reserved.
//

import UIKit
import CoreLocation

class Order {
    // TODO: Should use Codable to avoid declaring Keys and manually loading the properties
    
    // MARK: Keys
    
    private struct Keys {
        static let id = "id"
        static let description = "description"
        static let price = "price"
        static let recipient = "recipient"
        static let location = "location"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    let id: Int
    let description: String?
    let price: Int?
    let recipient: String?
    let location: CLLocation?
    
    init?(representation: [String: Any]) {
        guard let id = representation[Keys.id] as? Int else {
            return nil
        }
        self.id = id
        self.description = representation[Keys.description] as? String
        self.price = representation[Keys.price] as? Int
        self.recipient = representation[Keys.recipient] as? String
        if let locationDict = representation[Keys.location] as? [String: Any],
            let latitude = locationDict[Keys.latitude] as? Double,
            let longitude = locationDict[Keys.longitude] as? Double {
            self.location = CLLocation(latitude: latitude, longitude: longitude)
        } else {
            self.location = nil
        }
    }
}
