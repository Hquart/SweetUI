////
////  ContentView.swift
////  ReSwift
////
////  Created by Maertens Yann-Christophe on 16/02/22.
////

import SwiftUI

struct SidebarView: View {
    
    @State private var showAddPoolView: Bool = false
    @State private var showAddResourceView: Bool = false
    
    @State private var inBeta: Bool = true
    
    @AppStorage("explanations") private var isShowingExplanations: Bool = true
    
    
    init() {
      let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.darkBlue)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.theme.background)]
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
            List {
                Spacer()
                ForEach(CollectionType.allCases, id: \.self) { type in
                    NavigationLink(destination: MainView(collectionType: "\(type.name)")) {
                        
                        HStack {
                            Image(systemName: "\(type.symbol)")
                        
                                .foregroundColor(Color.theme.pinkIcon)
                            Text(type.name) .foregroundColor(Color.theme.darkBlue)
                        }
                        .font(.custom("Arial Rounded MT Bold", size: 25))
//                        Label(type.name, systemImage: "\(type.symbol)")
//                            .font(.custom("Arial Rounded MT Bold", size: 20))
//                            .foregroundColor(Color.theme.pinkIcon)
                    }
                }
                Spacer()
                Group {
                    Spacer(minLength: 350)
                    NavigationLink(destination: SettingsView()) {
                 
                        Label("Profile Settings", systemImage: "person.fill")
                            .font(.custom("Arial Rounded MT Bold", size: 20)).disabled(inBeta)
                    }
                    NavigationLink(destination: ContributorsView()) {
                        Label("Best contributors", systemImage: "star.fill")
                            .font(.custom("Arial Rounded MT Bold", size: 20)).disabled(inBeta)
                    }
                }
                Spacer(minLength: 150)
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("SweetUI").foregroundColor(Color.theme.darkBlue)
           
            .listStyle(SidebarListStyle())
            
            .sheet(isPresented: $showAddResourceView) {
                AddNewItemView()
            }
            .sheet(isPresented: $isShowingExplanations, onDismiss: {
                isShowingExplanations = false
            }, content: {
                OnboardingView(isShowingExplanations: $isShowingExplanations)
            })
            
           
            
            VStack {
                HStack(spacing: -1) {
                Text("Sweet")
                        .foregroundColor(Color.theme.darkBlue).italic().bold()
                        .font(.custom("Arial Rounded MT Bold", size: 35))
                Text("UI")
                        .foregroundColor(Color.theme.pinkIcon).italic().bold()
                        .font(.custom("Arial Rounded MT Bold", size: 35))
                }
                Image("iconImage")
                
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .opacity(0.5)
                    .cornerRadius(15)
                
                Text(String(localized: "home0")).padding()
                Text(String(localized: "home1")).padding()
                Text(String(localized: "home2")).padding()
                Text(String(localized: "home3")).padding()
                Text(String(localized: "home4")).padding()
            }
            .foregroundColor(Color(UIColor.systemGray4))
            .font(.title.bold())
            .multilineTextAlignment(.center)
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
