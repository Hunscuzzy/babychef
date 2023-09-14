//
//  BcDatePicker.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 14/9/23.
//

import SwiftUI

struct BcDatePicker: View {
    var label: String
    @Binding var date: Date

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)

            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle()) // Vous pouvez également utiliser d'autres styles
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding([.top, .bottom], 5)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
        }
    }
}
