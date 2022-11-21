//
//  DetailViewContainerViewController.swift
//  Clothes Store
//
//  Created by Richard Hope on 01/05/2021.
//  Copyright © 2021 Deloitte. All rights reserved.
//

import UIKit

class DetailViewContainerViewController: UIViewController{


    //Views
    var backButton : UIBarButtonItem!
    @IBOutlet var wishListButton: UIButton!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var addedToWishlistLabel: UILabel!
    @IBOutlet var addedToBasketLabel: UILabel!

    //Variables
    var product : Product!
    weak var wishListDelegate: WhishListProducts?
    weak var addToCartDelegate: AddToCartProducts?
    var onProductDetailsDismiss : ((Bool) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpButtons()
    }
    
    func setUpButtons(){

        wishListButton.dropShadow(radius: 8, opacity: 0.2, color: .black)
        addToCartButton.dropShadow(radius: 8, opacity: 0.4, color: UIColor.primaryColour)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier.detailContainer(){
            let dest = segue.destination as! ProductDetailTableViewController
            dest.product = product
        }
    }


    // MARK: - Actions
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        onProductDetailsDismiss!(true)
    }

    @IBAction func addToCartAction(_ sender: Any) {
        Haptic.feedBack()
        addToCartDelegate?.setAddToCartProduct(product)
       

    }

    @IBAction func addToWishListAction(_ sender: Any) {
        Haptic.feedBack()
        wishListDelegate?.setWishListProduct(product)
    }
}
