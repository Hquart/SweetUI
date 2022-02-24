//
//  AddView.swift
//  ReSwift
//
//  Created by Naji Achkar on 21/02/2022.
//

import SwiftUI


struct AddNewItemView2: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let gridColumns: [GridItem] =  Array(repeating: .init(.flexible()), count: 3)
    
    @StateObject var viewModel = CloudKitService()
    @StateObject var userViewModel = CKUser()
    
    @State private var selectedType: String = ""
    @State private var typeIsSelected = false
    @State private var showPicker = false
    
    @State private var previewImage = UIImage()
    @State private var imageisUploaded: Bool = false
    @State private var codeSnippet: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVStack {
                    Text("1 - Select the type of view")
                        .font(.custom("Arial Rounded MT Bold", size: 25))
                        .multilineTextAlignment(.center)
                        .frame(width: geo.size.width, height: geo.size.height * 0.07)
                    ///////////////////// TYPES BUTTONS GRID ///////////////////////////////
                    LazyVGrid(columns: gridColumns, spacing: 20) {
                        ForEach(CollectionType.allCases, id: \.self) { type in
                            Text("\(type.name)")
                                .foregroundColor(self.selectedType == type.name ? Color.white : Color.primary)
                                .font(.custom("Arial Rounded MT Bold", size: 20))
                                .padding()
                                .background(self.selectedType == type.name ? Color.blue : Color.theme.background)
                                .cornerRadius(20)
                                .onTapGesture {
                                    withAnimation(.easeIn(duration: 0.2)) {
                                        selectedType = type.name
                                        typeIsSelected.toggle()
                                    }
                                }
                        }
                    }
                    .frame(width: geo.size.width, height: geo.size.height * 0.2)
                    Divider()
                }
                /////////////////// IMAGE PICKER /////////////////////////////////////////////////
                Spacer(minLength: 30)
                Text("2 - Upload a screenshot of your view")
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
                            .font(.body)
                            .foregroundColor(Color.white).bold()
                            .padding()
                            .background(Color.pink)
                            .cornerRadius(10)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(imageisUploaded ? .clear : .pink)
                )
                .sheet(isPresented: $showPicker) {
                    ImagePicker(selectedImage: $previewImage, hasSelected: $imageisUploaded)
                }
                Divider()
                ///////////////CODE///////
                Spacer(minLength: 30)
                Text("3 - Paste Swift code below")
                    .font(.custom("Arial Rounded MT Bold", size: 25))
                    .multilineTextAlignment(.center)
                ZStack {
                    TextEditor(text: $codeSnippet)
                        .border(Color.gray)
                        .padding()
                    if codeSnippet.count < 1 {
                        Text("Paste code here")
                            .foregroundColor(Color(UIColor.systemGray4))
                            .font(.callout)
                            .frame(width: geo.size.width, height: geo.size.height * 0.3)
                    }
                }
                
                Button("Save") {
                    confirm()
                    
                }
                
                .foregroundColor(Color.white)
                .padding()
                .background(Color.red)
                .cornerRadius(8)
                .shadow(color: Color.black, radius: 2)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Incorrect Submission"), message: Text("Please complete all steps and make sure you are logged in to iCloud on your device"), dismissButton: .default(Text("Got it!")))
            }
            
            //                .frame(width: geo.size.width, height: geo.size.height * 0.8)
        }
    }
    
    func confirm() {
        guard selectedType != "",
              imageisUploaded == true,
              codeSnippet.count > 10,
              userViewModel.isSignedInToiCloud == true else {
                  
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

