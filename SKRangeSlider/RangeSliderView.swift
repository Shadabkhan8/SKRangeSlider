//
//  RangeSliderView.swift
//  SKRangeSlider
//
//  Created by Shadab khan on 22/05/25.
//

import SwiftUI

public struct RangeSliderView: View {
    @Binding var width: CGFloat
    @Binding var widthTow: CGFloat
    let maxValue: CGFloat
    let minValue: CGFloat
    @Binding var totalScreen: CGFloat
    
    let offsetValue: CGFloat = 40
    @State private var isDraggingLeft: Bool = false
    @State private var isDraggingRight: Bool = false
    @State private var isLeftActive: Bool = false
    @State private var isRightActive: Bool = false
    let isLeftHandleDrag: Bool
    let type: SliderType
    let dragEnded: () -> Void
    
    public init(
        width: Binding<CGFloat>,
        widthTow: Binding<CGFloat>,
        maxValue: CGFloat,
        minValue: CGFloat,
        totalScreen: Binding<CGFloat>,
        isLeftHandleDrag: Bool,
        type: SliderType,
        dragEnded: @escaping () -> Void
    ) {
        self._width = width
        self._widthTow = widthTow
        self.maxValue = maxValue
        self.minValue = minValue
        self._totalScreen = totalScreen
        self.isLeftHandleDrag = isLeftHandleDrag
        self.type = type
        self.dragEnded = dragEnded
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 30) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10).foregroundStyle(.gray)
                        .opacity(0.3)
                        .frame(height: 6)
                        .padding(.horizontal, 6)
                    Rectangle().foregroundStyle(Color.blue)
                        .frame(width: widthTow - width, height: 6)
                        .offset(x: width + 20)
                    
                    HStack(spacing: 0) {
                        
                        DraggableCircle(
                            isLeft: true,
                            isLeftHandleDrag: isLeftHandleDrag,
                            isDragging: $isDraggingLeft,
                            isActive: $isLeftActive,       // <-- pass isActive binding
                            position: $width,
                            otherPosition: widthTow,
                            limit: totalScreen,
                            dragEnded: {
                                self.dragEnded()
                            }
                        )
                        .disabled(!isLeftHandleDrag)

                        DraggableCircle(
                            isLeft: false,
                            isLeftHandleDrag: true,
                            isDragging: $isDraggingRight,
                            isActive: $isRightActive,      // <-- pass isActive binding
                            position: $widthTow,
                            otherPosition: width,
                            limit: totalScreen,
                            dragEnded: {
                                self.dragEnded()
                            }
                        )
                        
                    }
                    
                    if isDraggingLeft || isLeftActive {
                        ValueBox(
                            isDragging: isDraggingLeft,
                            value: self.map(value: self.width, from: 0...self.totalScreen, to: minValue...maxValue),
                            position: width,
                            xoffset: -18,
                            type: type
                        )
                    }
                    if isDraggingRight || isRightActive {
                        ValueBox(
                            isDragging: isDraggingRight,
                            value: self.map(value: self.widthTow, from: 0...self.totalScreen, to: minValue...maxValue),
                            position: widthTow,
                            xoffset: 0,
                            type: type
                        )
                    }
                    
                }
                
            }
            .frame(width: geometry.size.width)
            .frame(height: 30)
            .onAppear {
                if totalScreen == 0 {
                    totalScreen = geometry.size.width - offsetValue
                    widthTow = totalScreen
                    width = map(value: width, from: 0...maxValue, to: 0...totalScreen)
                }
            }
        }
    }
    
    func map(value: CGFloat, from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let inputRange = from.upperBound - from.lowerBound
        guard inputRange != 0 else { return 0 }
        let outputRange = to.upperBound - to.lowerBound
        return (value - from.lowerBound) / inputRange * outputRange + to.lowerBound
        
    }
}
