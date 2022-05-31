//
//  UIColor.swift
//  homeWork_1
//
//  Created by Аня on 31.05.2022.
//  Copyright © 2022 Марат Нургалиев. All rights reserved.
//

import UIKit

// MARK: - Color Store

extension UIColor {
    
    private static var colorsCache: [String: UIColor] = [:]
    public static func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, a: CGFloat) -> UIColor {
        
        let key = "\(r)\(g)\(b)\(a)"
        if let cachedColor = self.colorsCache[key] {
            return cachedColor
            
        }
        self.clearColorsCacheIfNeeded()
        let color = UIColor(red: r, green: g, blue: b, alpha:a)
        
        self.colorsCache[key] = color
        return color
    }
    private static func clearColorsCacheIfNeeded() {
        let maxObjectsCount = 100
        guard self.colorsCache.count >= maxObjectsCount else { return } colorsCache = [:]
    }
    
}

