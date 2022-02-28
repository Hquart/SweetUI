//
//  ReSwiftApp.swift
//  ReSwift
//
//  Created by Maertens Yann-Christophe on 16/02/22.
//

import SwiftUI

@main
struct ReSwiftApp: App {
    
    var body: some Scene {
        WindowGroup {
            SidebarView()
                .navigationBarColor(backgroundColor: UIColor(Color.red), tintColor: UIColor(Color.theme.background))
        }
    }
}

//class CurrentView: ObservableObject {
//    
//    @Published var selection: String = ""
//
//    static let shared = CurrentView()
//}
