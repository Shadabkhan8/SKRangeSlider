//
//  DraggableCircle.swift
//  SKRangeSlider
//
//  Created by Shadab khan on 22/05/25.
//

import SwiftUI

struct DraggableCircle: View {
    let isLeft: Bool
    let isLeftHandleDrag: Bool
    @Binding var isDragging: Bool
    @Binding var isActive: Bool
    @Binding var position: CGFloat
    let otherPosition: CGFloat
    let limit: CGFloat
    let dragEnded: () -> Void
    
    var body: some View {
        ZStack {
            Circle().frame(width: 25, height: 25).foregroundStyle(Color.blue)
            Circle().frame(width: 15, height: 15).foregroundStyle(!isLeftHandleDrag ? Color.blue : Color.white)
        }
        .offset(x: position + (isLeft ? 0 : -5))
        .gesture(
            DragGesture()
                .onChanged(onGestureChanged)
                .onEnded(onGestureEnded)
        )
        .simultaneousGesture(
            TapGesture()
                .onEnded {
                    isActive = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        isActive = false
                    }
                }
        )
    }
    
    private func onGestureChanged(value: DragGesture.Value) {
        isDragging = true
        
        if isLeft {
            let maximum = CGFloat.maximum(value.location.x, 0)
            position = CGFloat.minimum(maximum, otherPosition)
        } else {
            let maximum = CGFloat.maximum(value.location.x, otherPosition)
            position = CGFloat.minimum(maximum, limit)
        }
    }
    
    private func onGestureEnded(value: DragGesture.Value) {
        dragEnded()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        isDragging = false
        isActive = false
        }
    }
}
