//
//  ScoreItem.swift
//  SweetUI
//
//  Created by Naji Achkar on 06/03/2022.
//

import Foundation
import CloudKit

struct ScoreItem: Hashable {
    
    var creator: String
    var value: Int
    var record: CKRecord
}
