//
//  ContentView.swift
//  ReSwift
//
//  Created by Maertens Yann-Christophe on 16/02/22.
//

import SwiftUI

struct SidebarView: View {

    @State private var showAddPoolView: Bool = false
    @State private var showAddResourceView: Bool = false

    var body: some View {
        NavigationView {
            List {
                Spacer()
                NavigationLink(destination: MainView()) {
                    Label("Views", systemImage: "rectangle.split.3x3.fill")
                        .font(.custom("Arial Rounded MT Bold", size: 25))
                }
           
                Spacer(minLength: 300)
                NavigationLink(destination: ContributorsView()) {
                    Label("Best contributors", systemImage: "star.fill")
                        .font(.custom("Arial Rounded MT Bold", size: 25))
                }
            
                NavigationLink(destination: SettingsView()) {
                    Label("Profile Settings", systemImage: "person.fill")
                        .font(.custom("Arial Rounded MT Bold", size: 25))
                }
            }
            .sheet(isPresented: $showAddResourceView) {
                AddSwiftItemView()
            }

            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("SweetUI")
            .listStyle(SidebarListStyle())
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Menu {
//                        Button("Create new Pool") { showAddPoolView.toggle() }
//                        Button("Add resource to Global Database") { showAddResourceView.toggle() }
//                    } label: {
//                        Image(systemName: "plus.circle")
//                    }
//                }
//            }
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
