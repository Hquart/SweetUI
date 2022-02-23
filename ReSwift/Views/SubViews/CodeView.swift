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
        
        TextEditor(text: $code)
            .font(.custom("SF Mono Bold", size: 20))
          
    }
}
