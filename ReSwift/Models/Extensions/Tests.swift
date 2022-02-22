//
//  Tests.swift
//  ReSwift
//
//  Created by Naji Achkar on 21/02/2022.
//

import SwiftUI

struct Tests: View {
    var body: some View {
        VStack {
            Button(action: {
                print("Delete tapped!")
            }) {
                HStack {
                    Image(systemName: "trash")
                        .font(.title)
                    Text("Delete")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
            }
        }
    }
}

struct Tests_Previews: PreviewProvider {
    static var previews: some View {
        Tests()
    }
}
