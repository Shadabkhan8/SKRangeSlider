//
//  Triangle.swift
//  SKRangeSlider
//
//  Created by Shadab khan on 22/05/25.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + 1, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - 1, y: rect.minY))
        
        return path
    }
}
