//
//  AddView.swift
//  ReSwift
//
//  Created by Naji Achkar on 21/02/2022.
//

import SwiftUI


struct AddNewItemView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var currentView = CurrentView.shared
    
    let gridColumns: [GridItem] =  Array(repeating: .init(.flexible()), count: 3)
    
    @StateObject var viewModel = CloudKitService()
    @StateObject var userViewModel = CKUser()
    
    @State private var selectedType: String = ""
    @State private var showPicker = false
    
    @State private var previewImage = UIImage()
    @State private var imageisUploaded: Bool = false
    @State private var codeSnippet: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                /////////////////// IMAGE PICKER /////////////////////////////////////////////////
                Spacer(minLength: 30)
                Text("Please Upload a screenshot of your view")
                    .font(.custom("Arial Rounded MT Bold", size: 25))
                    .multilineTextAlignment(.center)
                Button {
                    showPicker.toggle()
                } label: {
                    if imageisUploaded {
                        Image(uiImage: previewImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.6, height: geo.size.height * 0.15)
                    } else {
                        Text("Pick Image")
                            .font(.headline)
                            .foregroundColor(Color.theme.pinkIcon)
                            .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.06)
                            .background(Color.theme.darkBlue)
                            .cornerRadius(10)
                            
                    }
                }

                .sheet(isPresented: $showPicker) {
                    ImagePicker(selectedImage: $previewImage, hasSelected: $imageisUploaded)
                }
                Spacer()
                Divider()
                ///////////////CODE///////
                Spacer(minLength: 30)
                Text("2 - Paste Swift code below")
                    .font(.custom("Arial Rounded MT Bold", size: 25))
                    .multilineTextAlignment(.center)
                Button {
                    pasteCode()
                } label: {
                    Image(systemName: "doc.on.clipboard.fill")
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                ZStack {
                    TextEditor(text: $codeSnippet)
                        .border(Color.gray)
                        .padding()
                    if codeSnippet.count < 1 {
                        Text("var body: some View {...} ")
                            .foregroundColor(Color(UIColor.systemGray4))
                            .font(.title3)
                            .frame(width: geo.size.width, height: geo.size.height * 0.25)
                    }
                }
                
                Button("Submit") {
                  confirm()
                   
                }
                .font(.headline)
                .foregroundColor(Color.theme.pinkIcon)
                .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.06)
                .background(Color.theme.darkBlue)
                .cornerRadius(8)
                .shadow(color: Color.theme.lightBlue, radius: 2)
                .padding()
            }
        
            .alert(isPresented: $showAlert) {
                      Alert(title: Text("Incorrect Submission"), message: Text("Please complete all steps and make sure you are logged in to iCloud on your device"), dismissButton: .default(Text("Got it!")))
               
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
        guard imageisUploaded == true,
              codeSnippet.count > 10,
        userViewModel.isSignedInToiCloud == true else {
        
                  showAlert.toggle()
                  return }
        viewModel.addResourceItem(type: currentView.selection, designImage: previewImage, code: codeSnippet)
     
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

