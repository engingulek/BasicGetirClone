//
//  ToolbarIten.swift
//  MarketTest
//
//  Created by Engin Gülek on 29.08.2024.
//

import Foundation
import SwiftUI


struct ToolbarItemView : View {
    let totalPiece : String
    var body: some View {
        HStack {
            Image(systemName: ImageTheme.basket.rawValue)
                .foregroundStyle(.purple)
            
            Text("\(totalPiece)")
                .foregroundStyle(.purple)
                .font(.headline)
                .fontWeight(.semibold)
        }
        .padding(.horizontal,15)
        .padding(.vertical,5)
        .background(Color.white)
        .cornerRadius(10)
    }
}
