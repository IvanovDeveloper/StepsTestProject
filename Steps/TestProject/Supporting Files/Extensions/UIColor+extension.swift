//
//  UIImage+extension.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /// The main RGBA macros which will be use in app
    class func RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor.color_sRGB(r, g, b, a)
    }
    
    /// RGBA macros / short style.
    class func RGBA_Generic(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor(red:r/255.0, green:g/255.0, blue:b/255.0, alpha:a)
    }
    
    /// RGBA at P3 format macros / short style.
    class func RGBA_P3(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
        return UIColor.init(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    /// RGBA at sRGB format macros / short style.
    class func color_sRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        let colorSpace = CGColorSpace(name:CGColorSpace.sRGB)!
        let components : [CGFloat] = [red/255.0, green/255.0, blue/255.0, alpha]
        let color = CGColor(colorSpace: colorSpace, components: components)!
        return UIColor.init(cgColor: color)
    }
}
