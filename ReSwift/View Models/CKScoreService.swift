//
//  CKScoreViewModel.swift
//  SweetUI
//
//  Created by Naji Achkar on 06/03/2022.
//

import Foundation
import SwiftUI
import CloudKit

class CKScoreService: ObservableObject {
    
    @Published var scoreItems: [ScoreItem] = []
    
    var userModel = CKUserService()
    
    init() {
        //        fetchScoreItems()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func isFirstCreation() -> Bool {
        for element in scoreItems {
            if element.creator.contains(userModel.familyName) {
                return false
            }
        }
        return true
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func findUserScoreRecord() {
        
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func incrementScore(creator: String) {
        // if creation before
        if isFirstCreation() == false {
            
        }
        // if no creation before
        let newScoreItem = CKRecord(recordType: "ScoreItem")
        newScoreItem["creator"] =  userModel.userName + " " + userModel.familyName
        newScoreItem["value"] = 1
        
        saveItem(record: newScoreItem)
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    private func saveItem(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(String(describing: returnedRecord))")
            print("Error: \(String(describing: returnedError))")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.fetchScoreItems()
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func fetchScoreItems() {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "ScoreItem", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [ScoreItem] = []
        
        if #available (iOS 15.0, *) {
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult {
                case .success(let record):
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                    guard let creator = record["creator"] as? String,
                          let value = record["value"] as? Int else { return }
                    
                    returnedItems.append(ScoreItem(creator: creator, value: value))
                    
                case .failure(let error):
                    print("Error recordMatchedBlock: \(error)")
                }
            }
        } else {
            queryOperation.recordFetchedBlock =  { (record) in
                ////////////////////////////////////////////////////////////////////////////////////////////////
                guard let creator = record["creator"] as? String,
                      let value = record["value"] as? Int else { return }
                returnedItems.append(ScoreItem(creator: creator, value: value))
            }
        }
        if #available (iOS 15.0, *) {
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                print("RETURNED RESULT: \(returnedResult)")
                DispatchQueue.main.async {
                    self?.scoreItems = returnedItems
                }
            }
        } else {
            queryOperation.queryCompletionBlock = { [weak self] (returnedCursor, returnedError) in
                print("RETURNED queryCompletionBlock")
                self?.scoreItems = returnedItems
            }
        }
        addOperation(operation: queryOperation)
    }
}
