//
//  ColorPallete.swift
//  Transitions&Interactions
//
//  Created by Владимир Мустафин on 26.04.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

public enum CollorPallete: Int {
    case red = 0, green, blue
    
    var rgb: UIColor {
        switch self.rawValue {
        case 0:
            return UIColor.red
        case 1:
            return UIColor.green
        case 2:
            return UIColor.blue
        default:
            break
        }
        return UIColor.black
    }

    var selectedDescription: String {
           switch self.rawValue {
           case 0:
               return "Red is selected"
           case 1:
               return "Green is selected"
           case 2:
               return "Blue is selected"
           default:
               break
           }
        return ""
    }

//    var name: String {
//           // return appropriate value
//    }
}
