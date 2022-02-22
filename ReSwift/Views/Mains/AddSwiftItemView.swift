//
//  AddSwiftItemView.swift
//  ReSwift
//
//  Created by Naji Achkar on 17/02/2022.
//

import SwiftUI

struct AddSwiftItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var viewModel = CKResourcesViewModel()
    
    @State private var document: MessageDocument = MessageDocument(content: "Hello, World!")
    @State private var isImportingFile: Bool = false
    
    @State private var isPresented = false

    @State private var showPicker = false

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
                        Spacer()
                        Button("import") {
                            isImportingFile.toggle()
                        }

                            .fileImporter(
                                isPresented: $isImportingFile,
                                allowedContentTypes: [.swiftSource],
                                allowsMultipleSelection: false
                            ) { result in
                                do {
                                    guard let selectedFile: URL = try result.get().first else { return }
                                    if selectedFile.startAccessingSecurityScopedResource() {
                                        guard let content = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
                                        defer { selectedFile.stopAccessingSecurityScopedResource() }
                                        document.content = content
                                    } else {
                                   print("deded")
                                    }
                                    } catch {
                                        // Handle failure.
                                    }
                                }
                        Spacer()
                        Button("Add screenshot") {
                            showPicker.toggle()
                        }
                            .sheet(isPresented: $showPicker) {
                                ImagePicker(selectedImage: $previewImage, hasSelected: $showPicker)
                            }
                        Spacer()
                    }
                    .padding(.vertical)
                    
                    HStack {
                        GroupBox(label: Text("Code here:")) {
                            TextEditor(text: $document.content)
                        }
                      
                        Image(uiImage: previewImage)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                            .cornerRadius(10)
                        .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
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
    
    func confirm() {
        viewModel.addResourceItem(type: selectedType, designImage: previewImage, code: document.content)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddSwiftItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddSwiftItemView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
