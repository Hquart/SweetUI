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
                NavigationLink(destination: MainView()) {
                    Label("Database", systemImage: "network")
                        .font(.headline)
                }
                NavigationLink(destination: AddSwiftItemView()) {
                    Label("Add SwiftUI View", systemImage: "rectangle.split.3x1.fill")
                        .font(.headline)
                }
            }
           
//            .sheet(isPresented: $showAddPoolView) {
//                AddPoolView(viewModel: self.poolsViewModel)
//            }
            .sheet(isPresented: $showAddResourceView) {
                AddSwiftItemView()
            }
         
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("My Resources")
            .listStyle(SidebarListStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Create new Pool") { showAddPoolView.toggle() }
                        Button("Add resource to Global Database") { showAddResourceView.toggle() }
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
