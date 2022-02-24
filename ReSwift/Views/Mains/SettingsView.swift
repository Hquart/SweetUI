//
//  SettingsView.swift
//  ReSwift
//
//  Created by Maertens Yann-Christophe on 16/02/22.
//

import SwiftUI
import AuthenticationServices
import CloudKit

struct SettingsView: View {
    
    @StateObject private var viewModel = CloudKitService()
 
    @State private var inBeta: Bool = true
    @State private var showPicker: Bool = false
    @State private var avatar = UIImage()
    @State private var currentName = "Martin"
    @FocusState var isFocused: Bool
    
    @State private var isLogedIn: Bool = false
    @AppStorage("firstName") var name: String = ""

    var body: some View {
        GeometryReader { geo in
            HStack {
                Spacer()
            VStack(alignment: .center, spacing: 20) {
                Image("memoji")
                    .resizable()
                    .frame(maxWidth: geo.size.width * 0.1, maxHeight: geo.size.width * 0.12)
                    .padding()
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
                    .padding()
              
                ////////////////////////////////////////////////////////////////////////////////////////////////
                if isLogedIn == false {
                    SignInWithAppleButton(.signIn) { request in
                        request.requestedScopes = [.fullName, .email]
                    } onCompletion: { result in
                        switch result {
                        case .success(let auth):
                            
                            switch auth.credential {
                            case let credential as ASAuthorizationAppleIDCredential:
                                
                                let firstName = credential.fullName?.givenName
                                let userID = credential.user
                                
                                self.name = firstName ?? ""
                                print("FIRST NAME AFTER LOGIN: \(String(describing: firstName))")
                                viewModel.addSweetUser(name: firstName ?? "Hidden Name", avatar: avatar, id: userID)
                                isLogedIn.toggle()
                                
                            default:
                                break
                            }
                        case .failure(let error):
                            print("Authorisation failed: \(error.localizedDescription)")
                        }
                    }
                    .disabled(inBeta)
                    .frame(width: geo.size.width * 0.3, height: geo.size.height * 0.08, alignment: .center)
                    
                    Text("Coming Soon:")
                        .font(.custom("Arial Rounded MT Bold", size: 20))
                        .foregroundColor(Color.theme.pinkIcon)
                        .padding().frame(width: geo.size.width * 0.3, height: geo.size.height * 0.05)
                    
                        .background(Color.theme.darkBlue)
                        .cornerRadius(4)
                        .shadow(color: Color.theme.pinkIcon, radius: 8)
                    Text(String(localized: "beta2"))
                        .foregroundColor(Color(UIColor.systemGray4))
                        .font(.title2.bold())
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                } else {
                    Text("Welcome: \(name)")
                        .frame(width: 60, height: 100, alignment: .center)
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
                }
            }
                Spacer()
            }
            .sheet(isPresented: $showPicker) {
                ImagePicker(selectedImage: $avatar, hasSelected: $showPicker)
            }
        }
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
final class SignInWithApple: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        
        return ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
