//
//  StepperIndicator.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 14/9/23.
//

import SwiftUI

struct StepperIndicator: View {
    @Binding var currentStep: Int
    let totalSteps: Int
    let title: String
    
    var body: some View {
        VStack(alignment: .listRowSeparatorLeading) {
            HStack {
                Spacer()
                ForEach(1...totalSteps, id: \.self) { step in
                    ZStack {
                        Circle()
                            .stroke(step == currentStep ? Color.blue : Color.gray, lineWidth: 2)
                            .frame(width: 20, height: 20)
                        
                        if step == currentStep {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 16, height: 16)
                        }
                        
                        Text("\(step)")
                            .font(.footnote)
                            .foregroundColor(step == currentStep ? .white : .gray)
                    }
                    Spacer()
                }
            }
        }
    }
}
