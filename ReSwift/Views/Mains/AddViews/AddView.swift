//
//  AddView.swift
//  ReSwift
//
//  Created by Naji Achkar on 21/02/2022.
//

import SwiftUI

struct AddNewItemView: View {
    
    @StateObject var viewModel = CKResourcesViewModel()
    
    var body: some View {
        TabView {
           TypeSelectionView()
            ImageUploaderView()
            CodeUploaderView()
            Text("Fourth")
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .environmentObject(viewModel)
    }
}

struct AddNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewItemView()
    }
}
