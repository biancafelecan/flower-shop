//
//  OrderTableViewCell.swift
//  FlowerShop
//
//  Created by Bianca Felecan on 2/17/19.
//  Copyright © 2019 BF. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    // MARK: Types
    
    private struct Constants {
        static let cornerRadius = CGFloat(5)
    }
    
    struct Model {
        let orderType: String
        let price: String
        let recipient: String
    }
    
    // MARK: Outlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var orderTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deliverToLabel: UILabel!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.accessoryType = .disclosureIndicator
        
        self.containerView.layer.cornerRadius = Constants.cornerRadius
        self.containerView.layer.masksToBounds = true
        self.containerView.backgroundColor = .secondaryColor
        
        self.orderTypeLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.orderTypeLabel.textColor = .textColor
        self.priceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.priceLabel.textColor = .textColor
        self.deliverToLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.deliverToLabel.textColor = .textColor
    }

    // MARK: Public methods
    
    func load(from model: Model) {
        self.orderTypeLabel.text = model.orderType
        self.priceLabel.text = model.price
        self.deliverToLabel.text = model.recipient
    }

}
