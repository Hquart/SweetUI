//
//  SweetUser.swift
//  ReSwift
//
//  Created by Naji Achkar on 23/02/2022.
//

import Foundation
import CloudKit

struct SweetUser {
    
    var name: String
    var id: String
    var avatar: URL?
    var record: CKRecord
}
