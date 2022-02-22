//
//  CodeUploaderView.swift
//  ReSwift
//
//  Created by Naji Achkar on 21/02/2022.
//

import SwiftUI

struct CodeUploaderView: View {
    
    @State private var document: MessageDocument = MessageDocument(content: "")
    @State private var isImportingFile: Bool = false
    
    var body: some View {
        GeometryReader { geo in
        VStack {
            Text("Please paste Swift code below")
                .font(.custom("Arial Rounded MT Bold", size: 30))
                .multilineTextAlignment(.center)
//        Button("import") {
//            isImportingFile.toggle()
//        }
//            .fileImporter(
//                isPresented: $isImportingFile,
//                allowedContentTypes: [.swiftSource],
//                allowsMultipleSelection: false
//            ) { result in
//                do {
//                    guard let selectedFile: URL = try result.get().first else { return }
//                    if selectedFile.startAccessingSecurityScopedResource() {
//                        guard let content = String(data: try Data(contentsOf: selectedFile), encoding: .utf8) else { return }
//                        defer { selectedFile.stopAccessingSecurityScopedResource() }
//                        document.content = content
//                    } else {
//                   print("deded")
//                    }
//                    } catch {
//                        // Handle failure.
//                    }
//                }
          
                TextEditor(text: $document.content)
                .border(Color.gray)
                .padding()
    }
        .frame(width: geo.size.width, height: geo.size.height)
}
    }
}

struct CodeUploaderView_Previews: PreviewProvider {
    static var previews: some View {
        CodeUploaderView()
    }
}
