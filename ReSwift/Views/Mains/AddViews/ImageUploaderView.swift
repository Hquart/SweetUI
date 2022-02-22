//
//  ImageUploaderView.swift
//  ReSwift
//
//  Created by Naji Achkar on 21/02/2022.
//

import SwiftUI

struct ImageUploaderView: View {
    
    @State private var showPicker = false
    @State private var previewImage = UIImage()
    
    @State private var imageisIploaded: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 10) {
                Text("Please Upload a screenshot of your view")
                    .font(.custom("Arial Rounded MT Bold", size: 30))
                    .font(.title)
                    .multilineTextAlignment(.center)
                Button {
                    showPicker.toggle()
                } label: {
                    if imageisIploaded {
                        Image(uiImage: previewImage)
                            .resizable()
                            .scaledToFit()
//
                    } else {
                        Text("Pick an Image")
                            .font(.headline)
                            .foregroundColor(Color.white).bold()
                            .background(Color.pink)
                            .cornerRadius(10)
                    }
                }
            .sheet(isPresented: $showPicker) {
                ImagePicker(selectedImage: $previewImage, hasSelected: $imageisIploaded)
            }
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct ImageUploaderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUploaderView()
    }
}
