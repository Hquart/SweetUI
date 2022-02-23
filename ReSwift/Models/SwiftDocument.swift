//
//  File.swift
//  ReSwift
//
//  Created by Naji Achkar on 20/02/2022.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct MessageDocument: FileDocument {
    
    static var readableContentTypes: [UTType] { [.swiftSource, .plainText] }

    var content: String

    init(content: String) {
        self.content = content
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        content = string
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: content.data(using: .utf8)!)
    }
    
}
