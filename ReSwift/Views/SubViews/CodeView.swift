//
//  CodeView2.swift
//  ReSwift
//
//  Created by Naji Achkar on 20/02/2022.
//
//
import SwiftUI
import UIKit

struct CodeView: View {
    
    @Binding var code: String
    @Environment(\.presentationMode) var presentationMode
    @State private var copyButtonTaped: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
#if targetEnvironment(macCatalyst)
                HStack {
                    Spacer()
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(Color.red)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    .padding()
                }
               
#endif
                Spacer()
#if targetEnvironment(macCatalyst)
                TextEditor(text: $code)
                    .font(.custom("SF Mono Bold", size: 20))
                    .lineSpacing(15)
#else
            TextEditor(text: $code)
                .font(.custom("SF Mono Bold", size: 20))
#endif
            
                    Image(systemName: "doc.on.clipboard")
                        .font(.title)
                        .foregroundColor(Color.theme.placeholderText)
                        .onTapGesture {
                            copy(code: code)
                            copyButtonTaped.toggle()
                        }
                    .padding()
                    .popover(isPresented: $copyButtonTaped) {
                              Text("Copied !")
                                  .font(.headline)
                                  .padding()
                          }
                }
        }
    }
    func copy(code: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = code
    }
    
   
}
