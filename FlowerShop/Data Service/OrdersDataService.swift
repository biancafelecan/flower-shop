//
//  OrdersDataService.swift
//  FlowerShop
//
//  Created by Bianca Felecan on 2/17/19.
//  Copyright © 2019 BF. All rights reserved.
//

import Foundation
import Alamofire

struct OrdersDataService {

    private static let urlString = "https://demo9079052.mockable.io/"
    
    static func fetchOrders(completion: @escaping (_ orders: [Order], _ error: Error?) -> ()) {
        guard let url = URL(string: urlString) else {
            completion([], nil)
            return
        }
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let ordersArray = value as? [[String: Any]] else {
                    completion([], nil)
                    return
                }
                let orders: [Order] = ordersArray.compactMap({
                    return Order(representation: $0)
                })
                completion(orders, nil)
            case .failure(let error):
                completion([], error)
            }
        }
    }
}
