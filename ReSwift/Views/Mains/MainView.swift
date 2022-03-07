
//
//  MainView.swift
//  ReSwift
//
//  Created by Naji Achkar on 17/02/2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = CKRessourceService()
    
    @State private var showCode: Bool = false
    @State private var itemTaped: SwiftItem?
    @State private var codeSnippet: String = ""
    @State private var showAddView: Bool = false
    
    @State var filter: String?
    
    let gridColumns: [GridItem] =  Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                Spacer()
                Text(String(localized: "mainView")) // "Tap to get the code"
                    .foregroundColor(Color.theme.darkBlue)
                    .font(.headline)
                LazyVGrid(columns: gridColumns, alignment: .center, spacing: 20) {
                    ForEach(viewModel.swiftItems, id: \.self) { item in
                        if filter == item.type {
                        contentBuilder(item: item, geo: geo)
                        } else if filter == nil {
                            contentBuilder(item: item, geo: geo)
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
                        .font(.custom("Arial Rounded MT Bold", size: 20))
                        .foregroundColor(Color.theme.pinkIcon)
                        .padding()
                        .background(Color.theme.darkBlue)
                        .clipShape(Circle())
                }
            }
        }
        .navigationBarTitle("\(filter ?? "All Views")" + " collection")
        .font(.custom("Arial Rounded MT Bold", size: 20))
        .onAppear(perform:  viewModel.fetchSwiftItems)
        .sheet(isPresented: $showCode) {
            CodeView(code: $codeSnippet)
        }
        .fullScreenCover(isPresented: $showAddView) {
            AddNewItemView()
        }
    }

    
    @ViewBuilder func contentBuilder(item: SwiftItem, geo: GeometryProxy) -> some View {
        if let designUrl = item.designImage,
           let designData = try? Data(contentsOf: designUrl),
           let designImage = UIImage(data: designData) {
            
//            VStack {
//                Text(item.creator)
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color.white)
                .shadow(color: .theme.darkBlue, radius: 5, x: 0, y: 0)
                .padding()
                .frame(width: geo.size.width * (1/3), height: geo.size.height * 0.2)
                .overlay(
                    Image(uiImage: designImage)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                        .padding()
                )
                .onTapGesture {
                    itemTaped = item
                    self.codeSnippet = item.code
                    showCode.toggle()
                }
                .padding()
//        }
        }
    }
 
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
