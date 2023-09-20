//
//  BcToggleButton.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 14/9/23.
//

import SwiftUI

struct BcToggleButton: View {
    var label: String
    @Binding var value: String
    var values: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            
            Picker("", selection: $value) {
                ForEach(values, id: \.self) { val in
                    Text("\(val)").tag(val)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
        }
    }
}
