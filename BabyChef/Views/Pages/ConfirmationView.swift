//
//  SwiftUIView.swift
//  BabyChef
//
//  Created by Hugo Fontvieille on 28/8/23.
//

import SwiftUI

struct ConfirmationView: View {
    var body: some View {
        VStack {
            Text("Ça y est!")
            Text("Olivia est devenue un Baby de BabyChef")
            Text("À présent, vous pouvez commencer ensemble la grande aventure de la diversification alimentaire")
            Spacer()
            ZStack {
               RoundedRectangle(cornerRadius: 25)
                   .foregroundColor(.blue)
                   .frame(height: 50)
                   .mask(
                       Rectangle()
                           .padding(.bottom, -25)
                   )
               Text("C'est parti!")
                   .font(.title)
                   .foregroundColor(.white)
           }
        }
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView()
    }
}
