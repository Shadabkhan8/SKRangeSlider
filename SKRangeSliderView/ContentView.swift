//
//  ContentView.swift
//  SKRangeSliderView
//
//  Created by Shadab khan on 22/05/25.
//

import SwiftUI
import SKRangeSlider

struct ContentView: View {
    @State private var lowerValuePosition: CGFloat = 0
    @State private var upperValuePosition: CGFloat = 0
    @State private var totalWidth: CGFloat = 0
    
    let minSliderValue: CGFloat = 1000
    let maxSliderValue: CGFloat = 10000
    
    var body: some View {
        VStack(spacing: 40) {
            
            Text("Selected Range")
                .font(.headline)
            
            HStack {
                Text("Min: \(mappedValue(lowerValuePosition))")
                Spacer()
                Text("Max: \(mappedValue(upperValuePosition))")
            }
            .padding(.horizontal)

            RangeSliderView(
                width: $lowerValuePosition,
                widthTow: $upperValuePosition,
                maxValue: maxSliderValue, minValue: minSliderValue,
                totalScreen: $totalWidth,
                isLeftHandleDrag: true,
                type: .price,
                dragEnded: {
                    print("Drag ended at range: \(mappedValue(lowerValuePosition)) - \(mappedValue(upperValuePosition))")
                }
            )
            .padding(.horizontal)
            
        }
        .padding()
    }
    
    private func mappedValue(_ width: CGFloat) -> Int {
        guard totalWidth > 0 else { return 0 }
        let mapped = (width / totalWidth) * (maxSliderValue - minSliderValue) + minSliderValue
        return Int(mapped)
    }
}

#Preview {
    ContentView()
}
