//
//  AddView.swift
//  ReSwift
//
//  Created by Naji Achkar on 21/02/2022.
//

import SwiftUI
import UIKit


struct AddNewItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let gridColumns: [GridItem] =  Array(repeating: .init(.flexible()), count: 3)
    
    @StateObject var viewModel = CKRessourceService()
    @StateObject var userViewModel = CKUserService()
    
    @State private var selectedType: String = ""
    @State private var showPicker = false
    
    @State private var previewImage = UIImage()
    @State private var imageisUploaded: Bool = false
    @State private var codeSnippet: String = ""
    @State private var showAlert: Bool = false
    private var formIsComplete: Bool {
        return selectedType != "" && imageisUploaded == true && codeSnippet.count > 10 && userViewModel.isSignedInToiCloud == true
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                /////////////////// TYPE PICKER /////////////////////////////////////////////////
                HStack {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                    Button("Confirm") {
                        confirm()
                    }
//                    .disabled(!formIsComplete)
                }
                .font(.title2)
                .padding()
                
                Group {
                    ItemPickerView(selection: $selectedType).frame(width: geo.size.width * 0.8, height: geo.size.height * 0.1, alignment: .center)
                        .padding(.top)
                    Divider()
                    /////////////////// IMAGE PICKER /////////////////////////////////////////////////
                    Text(String(localized: "addView1")) // "Upload a screenshot of your view"
                        .font(.custom("Arial Rounded MT Bold", size: 20))
                        .multilineTextAlignment(.center)
                    //                            .padding(.top)
                    Text(String(localized: "addView2")) // "Please make a screenshot of your view on a white background with a little padding"
                        .foregroundColor(Color.theme.placeholderText)
                    if imageisUploaded {
                        Image(uiImage: previewImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.15)
                    } else {
                        Button {
                            showPicker.toggle()
                        } label: {
                            Text("Pick Image")
                                .font(.title3)
                                .foregroundColor(Color.theme.pinkIcon)
                                .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.06)
                                .background(Color.theme.darkBlue)
                                .cornerRadius(10)
                        }
                    }
                }
                .sheet(isPresented: $showPicker) {
                    ImagePicker(selectedImage: $previewImage, hasSelected: $imageisUploaded)
                }
                .padding()
                Divider()
                ///////////////CODE///////
                Group {
                    Text(String(localized: "addView3")) //"Paste Swift code below"
                        .font(.custom("Arial Rounded MT Bold", size: 20))
                        .multilineTextAlignment(.center)
                        .padding()
                    Text(String(localized: "addView4"))// "Comment your code to add instructions if needed"
                        .foregroundColor(Color.theme.placeholderText)

                        Image(systemName: "doc.on.clipboard.fill")
                            .font(.title)
                            .foregroundColor(Color.theme.placeholderText)
                            .padding()
                            .onTapGesture {
                                pasteCode()
                            }
                }
                ZStack {
                    TextEditor(text: $codeSnippet)
                        .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.3, alignment: .center)
                        .border(Color.gray)
                    
                    if codeSnippet.count < 1 {
                        Text("var body: some View {...} ")
                            .foregroundColor(Color(UIColor.systemGray4))
                            .font(.title3)
                            .frame(width: geo.size.width, height: geo.size.height * 0.25)
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(String(localized: "alert1")), message: Text(String(localized: "alert2")), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func pasteCode() {
        let pasteboard = UIPasteboard.general
        if let codeToPaste = pasteboard.string {
            codeSnippet = codeToPaste
        }
    }
    
    func confirm() {
        guard formIsComplete else {
            showAlert.toggle()
            return }
        viewModel.addResourceItem(type: selectedType, designImage: previewImage, code: codeSnippet)
        presentationMode.wrappedValue.dismiss()
        
    }
}




















































//struct AddNewItemView: View {
//
//    @StateObject var newSwiftItem = ItemRepresentable.shared
//
//    var body: some View {
//        TabView {
//            TypeSelectionView()
//            ImageUploaderView()
//            CodeUploaderView()
//        }
//        .tabViewStyle(.page)
//        .indexViewStyle(.page(backgroundDisplayMode: .always))
//        .environmentObject(newSwiftItem)
//    }
//}
//struct AddNewItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddNewItemView()
//    }
//}




