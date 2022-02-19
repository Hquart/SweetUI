//
//  ActionButtonView.swift
//  ReSwift
//
//  Created by Naji Achkar on 17/02/2022.
//

import SwiftUI

    struct ActionButtonView: View {
        var size: CGSize
        var actionIcon: String
        var actionText: String
        var toggleSheet: (() -> Void)?
        var body: some View {
            Button(action: {
                toggleSheet?()
            }) {
                HStack {
                    Image(systemName: actionIcon)
                    Text(actionText)
                }
                .foregroundColor(Color.white)
                .font(.system(size: size.width * 0.03, weight: .bold, design: .default))
                .padding()
                .frame(maxWidth: .infinity, maxHeight: size.height * 0.1)
                .background(Color.accentColor.cornerRadius(8))
            }
        }
    }

    struct ActionButtonView_Previews: PreviewProvider {
        static var previews: some View {
            ActionButtonView(size: .zero, actionIcon: "heart", actionText: "Action")
        }
    }
