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
                ScrollView {
                    List {
                        
              
                    }
                }
                .navigationBarTitle("Best Contributors")
//                .font(.system(.largeTitle, design: .rounded))
                .foregroundColor(Color.purple)
                

            }.navigationViewStyle(StackNavigationViewStyle())
                .navigationBarColor(backgroundColor: UIColor(Color.theme.background), tintColor: .purple)
        }
}
}

struct ContributorsView_Previews: PreviewProvider {
    static var previews: some View {
        ContributorsView()
    }
}
