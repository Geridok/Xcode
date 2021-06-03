//
//  TextField.swift
//  Module14TaskManager
//
//  Created by Vladimir Mustafin on 31.05.2021.
//

import UIKit

class TextField: UITextField {
    let verticalInset: CGFloat = 10
    let horizontalInset: CGFloat = 10
    // placeholder position
    override func textRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.horizontalInset , dy: self.verticalInset)
    }

    // text position
    override func editingRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.horizontalInset , dy: self.verticalInset)
    }

    override func placeholderRect(forBounds: CGRect) -> CGRect {
        return forBounds.insetBy(dx: self.horizontalInset, dy: self.verticalInset)
    }
}
