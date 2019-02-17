//
//  OrderDetailsViewController.swift
//  FlowerShop
//
//  Created by Bianca Felecan on 2/17/19.
//  Copyright © 2019 BF. All rights reserved.
//

import UIKit
import MapKit
import Masonry
import CoreLocation

class LocationAnnotation: NSObject, MKAnnotation {
    var location: CLLocation
    
    var coordinate: CLLocationCoordinate2D {
        return location.coordinate
    }
    
    init(location: CLLocation) {
        self.location = location
    }
}

protocol OrderDetailsViewControllerDelegate: class {
    // Add delegate methods if needed
}

class OrderDetailsViewController: UIViewController {
    
    // MARK: Types
    
    struct Model {
        let id: String
        let description: String
        let price: String
        let recipient: String
    }

    // MARK: Properties
    
    var order: Order?
    weak var delegate: OrderDetailsViewControllerDelegate?
    
    // MARK: Outlets
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var recipientLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.loadData()
    }
    
    // MARK: Private Methods
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.title = "Order Details"
        
        let font = UIFont.preferredFont(forTextStyle: .body)
        self.idLabel.font = font
        self.descriptionLabel.font = font
        self.priceLabel.font = font
        self.recipientLabel.font = font
        self.locationLabel.font = font
    }
    
    private func loadData() {
        guard let order = self.order else {
            return
        }
        let model = OrdersFormatter.orderDetailsModel(from: order)
        self.idLabel.text = model.id
        self.descriptionLabel.text = model.description
        self.priceLabel.text = model.price
        self.recipientLabel.text = model.recipient
        
        if let location = order.location {
            self.mapView.isHidden = false
            self.locationLabel.isHidden = false
            let annotation = LocationAnnotation(location: location)
            self.mapView.addAnnotation(annotation)
            if let meters = CLLocationDistance(exactly: 500) {
                let region = MKCoordinateRegion(center: location.coordinate,
                                                latitudinalMeters: meters,
                                                longitudinalMeters: meters)
                mapView.setRegion(mapView.regionThatFits(region), animated: true)
            }
        } else {
            self.mapView.isHidden = true
            self.locationLabel.isHidden = true
        }
    }
}
