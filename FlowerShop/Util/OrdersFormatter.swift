//
//  OrdersFormatter.swift
//  FlowerShop
//
//  Created by Bianca Felecan on 2/17/19.
//  Copyright © 2019 BF. All rights reserved.
//

/// Contains static methods that map an Order object to the view models
struct OrdersFormatter {
    static func orderCellModel(from order: Order) -> OrderTableViewCell.Model {
        return OrderTableViewCell.Model(orderType: formattedDescription(order.description),
                                        price: formattedPrice(order.price),
                                        recipient: formattedRecipient(recipient: order.recipient))
    }
    
    static func orderDetailsModel(from order: Order) -> OrderDetailsViewController.Model {
        return OrderDetailsViewController.Model(id: "Id: \(order.id)",
            description: "Description: \(formattedDescription(order.description))",
            price: "Price: \(formattedPrice(order.price))",
            recipient: formattedRecipient(recipient: order.recipient))
    }
    
    private static func formattedPrice(_ value: Int?) -> String {
        if let price = value {
            return "\(price)$"
        } else {
            return "--$"
        }
    }
    
    private static func formattedRecipient(recipient: String?) -> String {
        if let recipientString = recipient {
            return "Deliver to: \(recipientString)"
        } else {
            return "No recipient info"
        }
    }
    
    private static func formattedDescription(_ description: String?) -> String {
        return description ?? "No description"
    }
}
