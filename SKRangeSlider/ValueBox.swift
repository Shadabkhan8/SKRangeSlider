//
//  ValueBox.swift
//  SKRangeSlider
//
//  Created by Shadab khan on 22/05/25.
//

import SwiftUI

struct ValueBox: View {
    let isDragging: Bool
    let value: CGFloat
    let position: CGFloat
    let xoffset: CGFloat
    let type: SliderType
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .frame(width: 60, height: 30)
                .foregroundStyle(Color.blue)
            
            Triangle().frame(width: 30, height: 15)
                .foregroundStyle(Color.blue)
                .offset(x: 0, y: 15)
            Text(formattedValue)
                .foregroundStyle(.white)
                .padding(.horizontal)
        }
        .scaleEffect(1)
        .offset(x: position + xoffset , y: -40)
    }
    
    var formattedValue: String {
        if type == .price {
            return "\(Int(value))"
        } else if type == .distance {
            return String(format: "%.2f", value)
        }
        return ""
    }
}
