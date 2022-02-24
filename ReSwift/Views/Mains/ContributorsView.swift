//
//  ContributorsView.swift
//  ReSwift
//
//  Created by Maertens Yann-Christophe on 16/02/22.
//

import SwiftUI

struct ContributorsView: View {
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
              
                    Text("Coming Soon:")
                        .font(.custom("Arial Rounded MT Bold", size: 20))
                        .foregroundColor(Color.theme.pinkIcon)
                        .padding().frame(width: geo.size.width * 0.3, height: geo.size.height * 0.05)
                    
                        .background(Color.theme.darkBlue)
                        .cornerRadius(4)
                        .shadow(color: Color.theme.pinkIcon, radius: 8)
                    Group {
                        Text(String(localized: "beta1")).padding()
                        Text(String(localized: "beta2")).padding()
                    }
                    .foregroundColor(Color(UIColor.systemGray4))
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
              
                    
                }
                .navigationBarTitle("Best Contributors")
                .font(.custom("Arial Rounded MT Bold", size: 20))
                .foregroundColor(Color.black)
                

            }.navigationViewStyle(StackNavigationViewStyle())
                .navigationBarColor(backgroundColor: UIColor(Color.theme.background), tintColor: .black)
        }
}
}

struct ContributorsView_Previews: PreviewProvider {
    static var previews: some View {
        ContributorsView()
    }
}
