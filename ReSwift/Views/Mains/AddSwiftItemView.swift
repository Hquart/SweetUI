//
//  AddSwiftItemView.swift
//  ReSwift
//
//  Created by Naji Achkar on 17/02/2022.
//

import SwiftUI

struct AddSwiftItemView: View {
    
    //        @State private var typedTitle = ""
    //        @State private var selectedTag: ResourceTag? = nil
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = CKResourcesViewModel()
    
    @State private var isPresented = false
    @State private var isShowingCodeImageLibrary = false
    @State private var isShowingPreviewImageLibrary = false
    @State private var codeImage = UIImage()
    @State private var previewImage = UIImage()
    @State private var selectedType: String = ""
    
    var types = ["Button", "Alert", "Slider"]
    let gridColumns: [GridItem] =  Array(repeating: .init(.flexible()), count: 3)
    
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 15) {
              
                    //////////////////////////////////////////// TYPE SELECTION///////////////////////
                    Section(header: Text("Select type of View you want to provide")) {
                        LazyVGrid(columns: gridColumns) {
                            ForEach(types, id: \.self) { type in
                                //////////////////////////////////////////// TYPE  CAPSULES ////////////////////////////////////////////////////
                                Text("\(type)")
                                    .foregroundColor(self.selectedType == type ? Color.white : Color.black)
                                    .padding()
                                    .background(self.selectedType == type ? Color.blue : Color.gray)
                                    .cornerRadius(20)
                                
                                    .onTapGesture {
                                        withAnimation(.easeIn(duration: 0.2)) {
                                            selectedType = type
                                        }
                                    }
                            }
                        }
                    }
                    HStack {
                        ActionButtonView(size: geo.size, actionIcon: "list.bullet.rectangle", actionText: "Upload Code Image", toggleSheet: toggleCodeImagePicker)
                            .sheet(isPresented: $isShowingCodeImageLibrary) {
                                ImagePicker(selectedImage: $codeImage, hasSelected: $isShowingCodeImageLibrary)
                            }
                        
                        ActionButtonView(size: geo.size, actionIcon: "list.bullet.rectangle", actionText: "Upload Preview Image", toggleSheet: togglePreviewImagePicker)
                            .sheet(isPresented: $isShowingPreviewImageLibrary) {
                                ImagePicker(selectedImage: $previewImage, hasSelected: $isShowingPreviewImageLibrary)
                            }
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Image(uiImage: codeImage)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                            .cornerRadius(10)
                        Image(uiImage: previewImage)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                            .cornerRadius(10)
                        //.frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                    }
                
            }
        }
        .navigationTitle("Create Resource")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    confirm()
                }
            }
        }
        .padding()
        .ignoresSafeArea(.keyboard)
    }
    func toggleSheet() { isPresented.toggle() }
    func toggleCodeImagePicker() { isShowingCodeImageLibrary.toggle() }
    func togglePreviewImagePicker() { isShowingPreviewImageLibrary.toggle() }
    
    func confirm() {
        viewModel.addResourceItem(type: selectedType, designImage: previewImage, codeImage: codeImage)
        presentationMode.wrappedValue.dismiss()
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddSwiftItemView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
