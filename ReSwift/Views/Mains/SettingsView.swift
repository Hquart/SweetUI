//
//  SettingsView.swift
//  ReSwift
//
//  Created by Maertens Yann-Christophe on 16/02/22.
//

import SwiftUI

struct SettingsView: View {
    
    //    var languages = ["English, Spanish, French, German"]
    
    //@StateObject private var viewModel = CKUserViewModel()
    //    @State private var selectedLanguage = "English"
    @State private var userName: String = ""
    @State private var currentName = "Martin"
    @FocusState var isFocused: Bool
    var body: some View {
        //        ZStack {
        //            Color.itemBack
        //                .ignoresSafeArea()
        GeometryReader { geo in
            VStack() {
                Image("memoji")
                    .resizable()
                    .frame(maxWidth: geo.size.width * 0.2, maxHeight: geo.size.width * 0.2)
                    .padding()
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                Text(currentName)
                    .font(.system(size: geo.size.width * 0.08, weight: .bold, design: .default))
                HStack {
                    TextField("", text: $userName)
                        .defaultTextFieldStyle(text: $userName) {
                            HStack(spacing: 15) {
                                Image(systemName: "pencil")
                                if !isFocused && userName.isEmpty {
                                    Button("Change Username") {
                                        isFocused = true
                                    }
                                }
                            }
                            .foregroundColor(.secondary)
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        }
                        .focused($isFocused)
                        .onChange(of: isFocused) { _ in
                            if !isFocused { userName = "" }
                        }
                        .onSubmit {
                            currentName = userName
                        }
                        .disableAutocorrection(true)
                }
                HStack {
                    Spacer()
                    Button {
                        print("Log out")
                    } label: {
                        Text("Log Out").font(.headline).bold()
                    }
                    .buttonStyle(.bordered)
                    Spacer()
                }
                
                
                /*Form {
                    HStack {
                        Spacer()
                        //                    VStack(alignment: .center) {
                        //                        Text("IS SIGNED IN: \(viewModel.isSignedInToiCloud.description.uppercased())")
                        //                            .padding()
                        //                        Text(viewModel.error)
                        //
                        //                        Text("Permission: \(viewModel.permissionStatus.description.uppercased())")
                        //
                        //                        if viewModel.isSignedInToiCloud {
                        //                            Text("Welcome \(viewModel.userName)")
                        //                        }
                        //                    }
                        Spacer()
                    }
                    //                Picker("Prefered Language", selection: $selectedLanguage) {
                    //                    Text("English")
                    //                    Text("Italian")
                    //                    Text("Spanish")
                    //                    Text("French")
                    //                }
                    //                .pickerStyle(.wheel)
                    Spacer()
                }*/
                
            }
        }
    }
}








struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
