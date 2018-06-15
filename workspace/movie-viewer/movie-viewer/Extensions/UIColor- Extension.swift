//
//  UIColor- Extension.swift
//  movie-viewer
//
//  Created by Dreb Rodriguez on 14/06/2018.
//  Copyright © 2018 Dreb Rodriguez. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    struct Custom {
        static let freeSpeechBlue = UIColor.rgb(63, 81, 181)
        static let edgarWhite = UIColor.rgb(238, 238, 238)
    }
}
