//
//  OrdersTableViewController.swift
//  FlowerShop
//
//  Created by Bianca Felecan on 2/17/19.
//  Copyright © 2019 BF. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    // MARK: Types
    
    private struct Constants {
        static let estimatedRowHeight = CGFloat(100)
        static let reuseIdentifier = "OrderCell"
    }

    // MARK: Outlets
    
    @IBOutlet weak var headerLabel: UILabel!
    
    // MARK: - Properties
    
    private(set) var orders: [Order] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.loadData()
    }
    
    // MARK: Private Methods
    
    func setupUI() {
        self.navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 20),
                                                                        .foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .mainColor
        
        self.title = "All Orders"
        self.view.backgroundColor = .white
        
        self.headerLabel.text = "View and manage your orders. Select an order to view more details."
        self.headerLabel.font = UIFont.systemFont(ofSize: 20)
        
        self.tableView.estimatedRowHeight = Constants.estimatedRowHeight
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(didTriggerRefresh), for: .valueChanged)
    }
    
    private func loadData(forcedRefresh: Bool = false) {
        if !forcedRefresh {
            self.refreshControl?.beginRefreshing()
        }
        OrdersDataService.fetchOrders { (orders, error) in
            func reload() {
                self.orders = orders
                // TODO: Handle error
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
            if Thread.isMainThread {
                reload()
            } else {
                DispatchQueue.main.async {
                    reload()
                }
            }
        }
    }
    
    @objc private func didTriggerRefresh() {
        self.loadData(forcedRefresh: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let orderCell = cell as? OrderTableViewCell, let order = self.orders[safe: indexPath.row] else {
            return cell
        }
        
        let viewModel = OrdersFormatter.orderCellModel(from: order)
        orderCell.load(from: viewModel)
        orderCell.contentView.backgroundColor = .white
        orderCell.selectionStyle = .none
        
        return orderCell
    }
    
    // MARK: Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let order = self.orders[safe: indexPath.row],
            let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(
                withIdentifier: String(describing: OrderDetailsViewController.self)) as? OrderDetailsViewController else {
            return
        }
        detailVC.order = order
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

}
