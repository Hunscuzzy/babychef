//
//  BcTextField.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 14/9/23.
//

import SwiftUI

struct BcTextField: View {
    var label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
            TextField("Entrez \(label.lowercased())", text: $text)
                .padding(10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
    }
}
