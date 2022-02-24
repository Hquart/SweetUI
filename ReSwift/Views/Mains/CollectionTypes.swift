//
//  CollectionTypes.swift
//  ReSwift
//
//  Created by Naji Achkar on 24/02/2022.
//

import Foundation




enum CollectionType: CaseIterable {
    
    case button, alert, slider, picker, progressView, other
    
    var name: String {
        switch self {
        case .button:
            return "Button"
        case .alert:
            return "Alert"
        case .slider:
            return "Slider"
        case .progressView:
            return "ProgressView"
        case .other:
            return "Other"
        case .picker:
            return "Picker"
        }
    }
    
    var symbol: String {
        switch self {
        case .button:
            return "square"
        case .alert:
            return "bell.square"
        case .slider:
            return "slider.horizontal.3"
        case .progressView:
            return "minus"
        case .other:
            return "o.square"
        case .picker:
            return "list.bullet"
        }
    }
}
