//
//  TypeSelectionView.swift
//  ReSwift
//
//  Created by Naji Achkar on 21/02/2022.
//

import SwiftUI

struct TypeSelectionView: View {
    
    var types: [String] = ["Button", "Alert", "Slider", "Widget", "Text", "Picker", "ProgressView", "GaugeView", "Other"]
    let gridColumns: [GridItem] =  Array(repeating: .init(.flexible()), count: 3)
    
    @EnvironmentObject var viewModel: CKResourcesViewModel
    
    @State private var selectedType: String = ""
    @State private var typeIsSelected = false
    
    var body: some View {
        VStack {
            Text("Please select the type of view you want to provide")
                .font(.custom("Arial Rounded MT Bold", size: 30))
                .lineLimit(2)
                .multilineTextAlignment(.center)
//                .offset(x: , y: <#T##CoreGraphics.CGFloat#>)
            Spacer()
            LazyVGrid(columns: gridColumns, spacing: 50) {
                ForEach(types, id: \.self) { type in
                    Text("\(type)")
                        .foregroundColor(self.selectedType == type ? Color.white : Color.black)
                        .font(.custom("Arial Rounded MT Bold", size: 25))
                        .padding()
                        .background(self.selectedType == type ? Color.blue : Color.theme.background)
                        .cornerRadius(20)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.2)) {
                                selectedType = type
                                typeIsSelected.toggle()
                            }
                        }
                }
            }
        }
    }
}

struct TypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TypeSelectionView(size: .zero)
    }
}
