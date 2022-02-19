//
//  ColorExtension.swift
//  ReSwift
//
//  Created by Maertens Yann-Christophe on 16/02/22.
//

import SwiftUI

struct ColorTheme {
    let background = Color("BackgroundColor")
    let elements = Color("ElementsColor")
}

extension Color {
    static let theme = ColorTheme()
}
