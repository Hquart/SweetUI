//
//  CodeView2.swift
//  ReSwift
//
//  Created by Naji Achkar on 20/02/2022.
//
//
import SwiftUI

struct CodeView: View {
    
    @Binding var code: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geo in
            VStack {
#if targetEnvironment(macCatalyst)
                HStack {
                    Spacer()
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
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
            
            Button {
                copy(code: code)
            } label: {
                Image(systemName: "doc.on.clipboard")
                    .font(.subheadline)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.theme.placeholderText)
                    .cornerRadius(10)
            }
                Spacer()
            }.accentColor(.red)

        }
    }
    func copy(code: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = code
    }
}
