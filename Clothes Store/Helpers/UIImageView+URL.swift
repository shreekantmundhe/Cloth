//
//  UIImageView+URL.swift
//  Clothes Store
//
//  Created by Shrikant Mundhe on 03/11/2022.
//  Copyright © 2022 RichieHope. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
