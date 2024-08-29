//
//  CountiuneButton.swift
//  MarketTest
//
//  Created by Engin Gülek on 29.08.2024.
//

import Foundation
import SwiftUI


 struct ContiuneButton : View {
    let totalPrice : String
    var body: some View {
        VStack(alignment:.center) {
            
            HStack(spacing:0) {
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text(TextTheme.contiune.rawValue)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .frame(width:220,height: 58)
                        .background(Color(hex: ColorTheme.primaryColor.rawValue))
                    
                })
                Text(totalPrice)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundStyle(Color.purple)
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .shadow(
                                color:.purple.opacity(0.7),
                                radius: 2)
                        
                    )
                Spacer()
            }
            
        }.background(Color.white)
    }
}
