//
//  Color+Extension.swift
//  MarketTest
//
//  Created by Engin Gülek on 23.08.2024.
//

import Foundation
import SwiftUI


extension Color {
    public init?(hex: String) {
         var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
         hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
         var rgb: UInt64 = 0
         guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
             return nil
         }
         self.init(
             red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
             green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
             blue: CGFloat(rgb & 0x0000FF) / 255.0
             
         )
     }
}
