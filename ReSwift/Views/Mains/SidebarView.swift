////
////  ContentView.swift
////  ReSwift
////
////  Created by Maertens Yann-Christophe on 16/02/22.
////
//


import SwiftUI

struct SidebarView: View {

    @State private var showAddPoolView: Bool = false
    @State private var showAddResourceView: Bool = false
    
    
    var types: [String] = ["Button", "Alert", "Slider", "Widget", "ProgressView", "Other"]

    var body: some View {
        NavigationView {
            List {
              Spacer()
                Group {
                NavigationLink(destination: MainView()) {
                    Label("Views Collection", systemImage: "rectangle.split.3x3.fill")
                        .font(.custom("Arial Rounded MT Bold", size: 20))
                }
                NavigationLink(destination: MainView()) {
                    Label("Buttons", systemImage: "square")
                        .font(.custom("Arial Rounded MT Bold", size: 17))
                }
                NavigationLink(destination: MainView()) {
                    Label("Alerts", systemImage: "bell.square")
                        .font(.custom("Arial Rounded MT Bold", size: 17))
                }
                NavigationLink(destination: MainView()) {
                    Label("Sliders", systemImage: "slider.horizontal.3")
                        .font(.custom("Arial Rounded MT Bold", size: 17))
                }
                NavigationLink(destination: MainView()) {
                    Label("Picker", systemImage: "list.bullet")
                        .font(.custom("Arial Rounded MT Bold", size: 17))
                }
                NavigationLink(destination: MainView()) {
                    Label("Progress View", systemImage: "minus")
                        .font(.custom("Arial Rounded MT Bold", size: 17))
                }
                NavigationLink(destination: MainView()) {
                    Label("Gauge View", systemImage: "speedometer")
                        .font(.custom("Arial Rounded MT Bold", size: 17))
                }
                NavigationLink(destination: MainView()) {
                    Label("Other", systemImage: "o.square")
                        .font(.custom("Arial Rounded MT Bold", size: 17))
                }
                }
                Group {
                Spacer(minLength: 350)
                NavigationLink(destination: ContributorsView()) {
                    Label("Best contributors", systemImage: "star.fill")
                        .font(.custom("Arial Rounded MT Bold", size: 20))
                }
                NavigationLink(destination: SettingsView()) {
                    Label("Profile Settings", systemImage: "person.fill")
                        .font(.custom("Arial Rounded MT Bold", size: 20))
                }
            }
            }
            .sheet(isPresented: $showAddResourceView) {
                AddNewItemView()
            }

            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("SweetUI")
            .listStyle(SidebarListStyle())
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
