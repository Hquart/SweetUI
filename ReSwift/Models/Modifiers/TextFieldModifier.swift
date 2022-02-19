//
//  TextFieldModifier.swift
//  ReSwift
//
//  Created by Maertens Yann-Christophe on 16/02/22.
//

import SwiftUI

struct TextFieldModifier<LeadingContent: View>: ViewModifier {
    var text: Binding<String>
    var leadingContent: LeadingContent
    
    init(text: Binding<String>, @ViewBuilder leadingContent: @escaping () -> LeadingContent) {
        self.text = text
        self.leadingContent = leadingContent()
    }
    
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.leading, 30)
            .background(Color(UIColor.systemGray4))
            .cornerRadius(8)
            //.shadow(color: .secondary, radius: 0, x: 1, y: 1)
            .overlay(
                Button(action: {
                    
                }) {
                    HStack(spacing: 10) {
                        leadingContent
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !text.wrappedValue.isEmpty {
                            Button(action: {
                                self.text.wrappedValue = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                }
            )
            .padding(.horizontal)
    }
}
