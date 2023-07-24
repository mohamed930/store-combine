//
//  UIButton.swift
//  store
//
//  Created by Mohamed Ali on 24/07/2023.
//

import UIKit

extension UIButton {
    func setButtonDisabled(_ status: Bool) {
        if status {
            self.layer.backgroundColor = images.yelloColor.color.cgColor
        }
        else {
            self.layer.backgroundColor = images.buttonDisabled.color.cgColor
        }
        
        self.isEnabled = status
    }
}
