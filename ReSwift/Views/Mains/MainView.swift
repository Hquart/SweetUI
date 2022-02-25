
//
//  MainView.swift
//  ReSwift
//
//  Created by Naji Achkar on 17/02/2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = CloudKitService()
    
    @ObservedObject var currentView = CurrentView.shared
    
    @State private var showCode: Bool = false
    @State private var itemTaped: SwiftItem?
    @State private var codeSnippet: String = ""
    @State private var showAddView: Bool = false
    
    @State var collectionType: String
    
    let gridColumns: [GridItem] =  Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        GeometryReader { geo in
            
            
//            NavigationView {
                ScrollView {
                    Spacer()
                    Text(String(localized: "mainView")) // "Tap to get the code"
                        .foregroundColor(Color.theme.darkBlue)
                        .font(.headline)
                    //                        .frame(width: geo.size.width, height: geo.size.height * 0.3)
                    LazyVGrid(columns: gridColumns, alignment: .center, spacing: 20) {
                        ForEach(viewModel.swiftItems, id: \.self) { item in
                            if item.type == collectionType {
                                if let designUrl = item.designImage,
                                   let designData = try? Data(contentsOf: designUrl),
                                   let designImage = UIImage(data: designData) {
                                    RoundedRectangle(cornerRadius: 15)
                                        .foregroundColor(Color.white)
                                        .shadow(color: .theme.darkBlue, radius: 5, x: 0, y: 0)
                                        .padding()
                                        .frame(width: geo.size.width * (1/3), height: geo.size.height * 0.2)
                                        .overlay(
                                            Image(uiImage: designImage)
                                                .resizable()
                                                .scaledToFit()
                                                .padding()
                                        )
                                        .onTapGesture {
                                            itemTaped = item
                                            self.codeSnippet = item.code
                                            showCode.toggle()
                                        }
                                        .padding()
                                }
                            }
                        }
                    }
                }
                
                .onAppear(perform: viewModel.fetchSwiftItems)
              
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddView.toggle()
                        } label: {
                            Text("+")
                                .font(.custom("Arial Rounded MT Bold", size: 25))
                                .foregroundColor(Color.theme.pinkIcon)
                                .padding()
                                .background(Color.theme.darkBlue)
                                .clipShape(Circle())
                                .shadow(color: Color.theme.lightBlue, radius: 8)
                                
                        }
                    }
                 
                }
                .navigationBarTitle("\(collectionType)" + " collection")
                .font(.custom("Arial Rounded MT Bold", size: 20))
                .onAppear(perform: setView)
                .sheet(isPresented: $showCode) {
                    CodeView(code: $codeSnippet)
                    
                }
                .sheet(isPresented: $showAddView) {
                    AddNewItemView()
                }
            
            .navigationBarColor(backgroundColor: UIColor(Color.red), tintColor: UIColor(Color.theme.darkBlue))
            .navigationViewStyle(StackNavigationViewStyle())
       
        }
//    } navigationView end
    }
    func setView() {
        viewModel.fetchSwiftItems()
        self.currentView.selection = collectionType
    }
}



//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
