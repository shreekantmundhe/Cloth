//
//  WishlistViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit


protocol BuyCellButtonTapped: class {
    func addProductToBasket(_ sender: SavedViewTableViewCell)
}

class WishlistViewController: UIViewController, BuyCellButtonTapped {

    //Views
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noProductsLabel: UILabel!

    //Variables
    var wishListProduct : [Product] = []
    private var detailsVS: DetailViewContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        let tabBar = tabBarController as! TabBarController
        wishListProduct = tabBar.wishListItem
        self.tableView.reloadData()
    }
    
    // MARK: - Actions
    func addProductToBasket(_ sender: SavedViewTableViewCell) {
        Haptic.feedBack()

    }
}

extension WishlistViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction.init(style:.destructive, title: "Remove", handler: { (action, view, completion) in
            self.wishListProduct.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
            Haptic.feedBack()
        })
        
        deleteAction.backgroundColor = UIColor.primaryColour

        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
    }
}

extension WishlistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wishListProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell", for: indexPath) as? SavedViewTableViewCell else { fatalError("xib does not exists") }
        noProductsLabel.isHidden = true
        
        guard let product = wishListProduct[indexPath.row] ?? nil else {
            return cell
        }
        cell.configureWithProduct(product: product)
        //cell.productPrice.text = "1010"
       // let product = products[indexPath.row]
        //cell.configureWithProduct(product: product)
        return cell
    }
}

