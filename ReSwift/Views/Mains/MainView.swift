//
//  MainView.swift
//  ReSwift
//
//  Created by Naji Achkar on 17/02/2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = CKResourcesViewModel()
    
    @State private var showCode: Bool = false
    @State private var itemTaped: SwiftItem?
    @State private var codeSnippet: String = ""
    @State private var showAddView: Bool = false
    
    let gridColumns: [GridItem] =  Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: gridColumns, alignment: .center, spacing: 20) {
                        ForEach(viewModel.swiftItems, id: \.self) { item in
                            if let designUrl = item.designImage,
                               let designData = try? Data(contentsOf: designUrl),
                               let designImage = UIImage(data: designData) {
                                Image(uiImage: designImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width * (1/5), height: geo.size.width * (1/5))
                                    .cornerRadius(15)
                                    .onTapGesture {
                                        itemTaped = item
                                        self.codeSnippet = item.code
                                        showCode.toggle()
                                    }
                            }
                        }
                    }
                }
                                .toolbar {
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button {
                                            showAddView.toggle()
                                        } label: {
                                            Text("Add your own View")
                                                .font(.title3)
                                                .foregroundColor(Color.white).bold()
                                                .frame(width: geo.size.width * 0.25, height: geo.size.height * 0.07)
                                                .background(Color.pink)
                                                .cornerRadius(10)
                                        }
                                        
                                    }
                                }
                            
                                .navigationBarTitle("Views library")
//                                .font(.custom("Arial Rounded MT Bold", size: 150))
                .onAppear(perform: viewModel.fetchItems)
                .sheet(isPresented: $showCode) {
                    CodeView(code: $codeSnippet)
                }
                .sheet(isPresented: $showAddView) {
                    AddNewItemView()
                }
               
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarColor(backgroundColor: UIColor(Color.theme.background), tintColor: UIColor(Color.black))
        }
}
}



//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
