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
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
#if targetEnvironment(macCatalyst)
                List {
                    NavigationLink(destination: MainView(filter: nil)) {
                        HStack {
                            Image(systemName: "rectangle.split.3x3")
                                .foregroundColor(Color.theme.pinkIcon)
                            Text("All Views")
                                .foregroundColor(Color.theme.darkBlue)
                        }
                        .font(.title)
                        .padding()
                    }
                    ForEach(CollectionType.allCases, id: \.self) { type in
                        NavigationLink(destination: MainView(filter: "\(type.name)")) {
                            HStack {
                                Image(systemName: "\(type.symbol)")
                                    .foregroundColor(Color.theme.pinkIcon)
                                Text(type.name)
                                    .foregroundColor(Color.theme.darkBlue)
                            }
                            .font(.title2)
                            .padding()
                        }
                    }
                    Spacer()
                    Spacer(minLength: 150)
               
                }
                .listStyle(SidebarListStyle())
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle("SweetUI")
#else
                List {
                    NavigationLink(destination: MainView(filter: nil)) {
                        HStack {
                            Image(systemName: "rectangle.split.3x3")
                                .foregroundColor(Color.theme.pinkIcon)
                            Text("All Views")
                                .foregroundColor(Color.theme.darkBlue)
                        }
                        .font(.custom("Arial Rounded MT Bold", size: 25))
                        .padding(.top)
                        .padding(.bottom)
                    }
//                    Spacer()
                    ForEach(CollectionType.allCases, id: \.self) { type in
                        NavigationLink(destination: MainView(filter: "\(type.name)")) {
                            HStack {
                                Image(systemName: "\(type.symbol)")
                                    .foregroundColor(Color.theme.pinkIcon)
                                Text(type.name)
                                    .foregroundColor(Color.theme.darkBlue)
                            }
                            .font(.custom("Arial Rounded MT Bold", size: 22))
                        }
                    }
                    Spacer()
                    Spacer(minLength: 150)
                }
                .listStyle(SidebarListStyle())
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle("SweetUI")
#endif
            }
            .sheet(isPresented: $showAddResourceView) {
                AddNewItemView()
            }
            .sheet(isPresented: $isShowingExplanations, onDismiss: {
                isShowingExplanations = false
            }, content: {
                OnboardingView(isShowingExplanations: $isShowingExplanations)
            })
            MainView(filter: nil)
        }
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}



