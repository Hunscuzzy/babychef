//
//  CustomRoundedRectangle.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 28/8/23.
//

import SwiftUI

struct RoundedCorners: View {
    var color: Color = .black
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, height/2), width/2)
                let tl = min(min(self.tl, height/2), width/2)
                let bl = min(min(self.bl, height/2), width/2)
                let br = min(min(self.br, height/2), width/2)

                path.move(to: CGPoint(x: width / 2.0, y: 0))
                path.addLine(to: CGPoint(x: width - tr, y: 0))
                path.addArc(center: CGPoint(x: width - tr, y: tr), radius: tr,
                            startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

                path.addLine(to: CGPoint(x: width, y: height - br))
                path.addArc(center: CGPoint(x: width - br, y: height - br), radius: br,
                            startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

                path.addLine(to: CGPoint(x: bl, y: height))
                path.addArc(center: CGPoint(x: bl, y: height - bl), radius: bl,
                            startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                            startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}
