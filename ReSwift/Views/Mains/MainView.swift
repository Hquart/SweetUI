
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
                    Spacer()
                    Text("Click on a view to get the code")
                        .foregroundColor(Color(UIColor.systemGray4))
                        .font(.title3.bold())
//                        .frame(width: geo.size.width, height: geo.size.height * 0.3)
                    LazyVGrid(columns: gridColumns, alignment: .center, spacing: 20) {
                        ForEach(viewModel.swiftItems, id: \.self) { item in
                            if let designUrl = item.designImage,
                               let designData = try? Data(contentsOf: designUrl),
                               let designImage = UIImage(data: designData) {
                                    RoundedRectangle(cornerRadius: 15)
                                    .foregroundColor(Color.white)
                                    .shadow(color: .theme.background, radius: 8, x: 0, y: 0)
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
                                    
                                
                                /*Image(uiImage: designImage)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(15)
                                    .frame(width: geo.size.width * (1/5), height: geo.size.width * (1/5))
                                    .onTapGesture {
                                        itemTaped = item
                                        self.codeSnippet = item.code
                                        showCode.toggle()
                                    }*/
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddView.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundColor(Color.pink)
                        }
                    }
                }
                
                .navigationBarTitle("Buttons collection")
                //                                .font(.custom("Arial Rounded MT Bold", size: 150))
                .onAppear(perform: viewModel.fetchItems)
                .sheet(isPresented: $showCode) {
                    CodeView(code: $codeSnippet)
                        .background(Color.black)
                }
                .sheet(isPresented: $showAddView) {
                    AddNewItemView()
                }
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarColor(backgroundColor: UIColor(Color.theme.background), tintColor: UIColor(Color.primary))
        }
    }
}



//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
