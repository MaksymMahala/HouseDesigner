//
//  CustomRoundedShape.swift
//  HouseDesigner
//
//  Created by Max on 10.03.2025.
//

import SwiftUI

struct CustomRoundedShape: Shape {
    var cornerRadius: CGFloat
    var roundLeftCorners: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()

        if roundLeftCorners {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(180),
                        endAngle: .degrees(270),
                        clockwise: false)

            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(90),
                        endAngle: .degrees(180),
                        clockwise: false)

        } else {
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
                   path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
                   
                   path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                               radius: cornerRadius,
                               startAngle: .degrees(270),
                               endAngle: .degrees(360),
                               clockwise: false)

                   path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
                   
                   path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                               radius: cornerRadius,
                               startAngle: .degrees(0),
                               endAngle: .degrees(90),
                               clockwise: false)

                   path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

                   path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        }

        path.closeSubpath()
        return path
    }
}
