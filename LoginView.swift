//
//  LoginView.swift
//  ReSwift
//
//  Created by Naji Achkar on 23/02/2022.
//

import SwiftUI
import AuthenticationServices
import CloudKit


struct LoginView: View {
    
    @ObservedObject var viewModel = CloudKitService()
    
    @State private var isLogedIn: Bool = false
    @AppStorage("firstName") var name: String = ""
    
    @Binding var avatar: UIImage
    
    
    var body: some View {
        
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
                        viewModel.addSweetUser(name: firstName ?? "Hidden Name", avatar: avatar, id: userID)
                        isLogedIn.toggle()
                        
                    default:
                        break
                    }
                case .failure(let error):
                    print("Authorisation failed: \(error.localizedDescription)")
                }
            }
        } else {
            
            Text("Welcome: \(name)")
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
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//final class SignInWithApple: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
//
//        return ASAuthorizationAppleIDButton()
//    }
//
//    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
//    }
//}
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}

