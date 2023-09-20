//
//  BcButton.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 20/9/23.
//

import SwiftUI

struct BcButton: View {
    var label: String
    var action: () -> Void
    var fullWidth: Bool?

    var body: some View {
        Button(action: action) {
            Text(label)
                .fontWeight(.medium)
                .foregroundColor(Color.gray)
                .padding(30)
                .frame(maxWidth: fullWidth == true ? .infinity : nil)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 64, style: .continuous)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                        
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.offWhite)
                    }
                )
        }
    }
}

struct BcButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BcButton(label: "Normal Button", action: {})
            BcButton(label: "Full Width Button", action: {}, fullWidth: true)
        }
    }
}
