//
//  UIViewController+Extensions.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 17/02/23.
//

import UIKit

extension UIViewController {
    
    func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
