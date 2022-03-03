//
//  ItemPickerView.swift
//  SweetUI
//
//  Created by Naji Achkar on 27/02/2022.
//
// This view......

import SwiftUI


struct ItemPickerView: View {
    
    @Binding var selection: String
    
    var body: some View {
        VStack {
            Text(String(localized: "addView0")) // "Select the type of view you want to add"
                .font(.custom("Arial Rounded MT Bold", size: 20))
                .multilineTextAlignment(.center)
                .padding()
            Picker("View Type", selection: $selection) {
                ForEach(CollectionType.allCases, id: \.self) { type in
                    Text(type.name)
                        .tag(type.name)
                }
            }
            .pickerStyle(.segmented)
        }
     
    }
}

struct ItemPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ItemPickerView(selection: .constant("Button"))
    }
}
