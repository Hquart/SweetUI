//
//  CodeView.swift
//  ReSwift
//
//  Created by Naji Achkar on 17/02/2022.
//

import SwiftUI

struct CodeView: View {
    
    @Binding var image: Image
    var body: some View {
        
        image
            .resizable()
            .scaledToFill()
    }
}

//struct CodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        CodeView()
//    }
//}
