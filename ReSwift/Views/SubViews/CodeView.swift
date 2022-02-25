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
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
            TextEditor(text: $code)
                .font(.custom("SF Mono Bold", size: 20))
     
            
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
        }
        }
        
    }
    func copy(code: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = code
    }
}
