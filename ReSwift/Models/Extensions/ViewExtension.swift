//
//  ViewExtension.swift
//  ReSwift
//
//  Created by Maertens Yann-Christophe on 16/02/22.
//

import SwiftUI

extension View {
    func defaultTextFieldStyle<T: View>(text: Binding<String>, leadingContent: @escaping () -> T) -> some View {
        modifier(TextFieldModifier(text: text, leadingContent: leadingContent))
    }
}


