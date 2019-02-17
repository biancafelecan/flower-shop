//
//  Array.swift
//  FlowerShop
//
//  Created by Bianca Felecan on 2/17/19.
//  Copyright © 2019 BF. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
