//
//  ColorConstants.swift
//  MarvelCharacters
//
//  Created by Patricia Zambrano on 29/09/21.
//

import Foundation
import UIKit

enum AssetColor {
   case red
}

extension UIColor {
    static func getColorApp(name: AssetColor) -> UIColor? {
        switch name {
        case .red:
            return UIColor(named: "RedMarvel")
        }
    }
}
