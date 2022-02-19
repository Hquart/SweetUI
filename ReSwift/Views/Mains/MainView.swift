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
    @State private var codeImage: Image = Image(systemName: "photo.fill")
    
    let gridColumns: [GridItem] =  Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                Text("Click a view to see the code")
                    .font(.title).italic()
                    
                LazyVGrid(columns: gridColumns, alignment: .center, spacing: 20) {
            ForEach(viewModel.swiftItems, id: \.self) { item in
              
                if let designUrl = item.codeImage,
                   let designData = try? Data(contentsOf: designUrl),
                   let designImage = UIImage(data: designData)  {
                    
               
                    Image(uiImage: designImage)
                        .resizable()
                        .frame(width: geo.size.width * (1/3), height: geo.size.width * (1/3))
                        .cornerRadius(15)
                        .onTapGesture {
                            itemTaped = item
                            if let url = itemTaped?.designImage,
                               let data = try? Data(contentsOf: url),
                               let image = UIImage(data: data) {
                                self.codeImage = Image(uiImage: image)
                            }
                                showCode.toggle()
                        }
                    }
                }
            }
        }
        
        .navigationTitle("SwiftUI Views")
        .onAppear(perform: viewModel.fetchItems)
        .sheet(isPresented: $showCode) {
            CodeView(image: $codeImage)
        }
        }.padding()
    }
}


//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
