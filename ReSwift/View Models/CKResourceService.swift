//
//  CKResourceViewModel2.swift
//  ReSwift
//
//  Created by Naji Achkar on 20/02/2022.
//



import Foundation
import SwiftUI
import CloudKit
import UniformTypeIdentifiers

class CKRessourceService: ObservableObject {
    
    @Published var swiftItems: [SwiftItem] = []
    
    var userModel = CKUserService()
    
    init() {
        fetchSwiftItems()
    }
    //////////////////////////////////////////////////////////////////////////////////////////////// CREATE FUNCTIONS    ////////////////////////////////////////////////////////////////////////////////////////////////
    func addResourceItem(type: String, designImage: UIImage?, code: String) {
        let newSwiftItem = CKRecord(recordType: "SwiftItem")
        newSwiftItem["type"] = type
        newSwiftItem["code"] = code
   
        
        guard let CkDesignImage = designImage,
              let designUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("\(type)+design.jpg"),
              let designData = CkDesignImage.jpegData(compressionQuality: 1.0) else { return }
        do {
            try designData.write(to: designUrl)
            let designAsset = CKAsset(fileURL: designUrl)
            newSwiftItem["designImage"] = designAsset
        }  catch let error {
            print(error)
        }
        saveItem(record: newSwiftItem)
    }
    
   
    

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    private func saveItem(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { [weak self] returnedRecord, returnedError in
            print("Record: \(String(describing: returnedRecord))")
            print("Error: \(String(describing: returnedError))")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.fetchSwiftItems()
            }
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////////////// READ FUNCTIONS    ////////////////////////////////////////////////////////////////////////////////////////////////
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
    
  
    
    
    
    
    
    
    
     func fetchSwiftItems() {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "SwiftItem", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
         queryOperation.resultsLimit = 20

        var returnedItems: [SwiftItem] = []
         ////////////////////////////////////////////////////////////////////////////////////////////////
        if #available (iOS 15.0, *) {
            queryOperation.recordMatchedBlock = { (returnedRecordID, returnedResult) in
                switch returnedResult {
                case .success(let record):
                   
                    guard let type = record["type"] as? String,
                          let code = record["code"] as? String
//                          let creator = record["creator"] as? String
                    else { return }
             
                  
                    let designImageAsset = record["designImage"] as? CKAsset
                    let designImageUrl = designImageAsset?.fileURL
             
                    returnedItems.append(SwiftItem(type: type, designImage: designImageUrl, code: code, record: record))
                                         
                case .failure(let error):
                    print("Error recordMatchedBlock: \(error)")
                }
            }
            
        } else {
            queryOperation.recordFetchedBlock =  { (record) in
                guard let type = record["type"] as? String,
                      let code = record["code"] as? String
//                      let creator = record["creator"] as? String
                else { return }
              
                let designImageAsset = record["designImage"] as? CKAsset
                let designImageUrl = designImageAsset?.fileURL
             
                returnedItems.append(SwiftItem(type: type, designImage: designImageUrl, code: code, record: record))
            }
        }
         ////////////////////////////////////////////////////////////////////////////////////////////////
        if #available (iOS 15.0, *) {
            queryOperation.queryResultBlock = { [weak self] returnedResult in
                print("RETURNED RESULT: \(returnedResult)")
                DispatchQueue.main.async {
                    self?.swiftItems = returnedItems
                }
            }
            
        } else {
            queryOperation.queryCompletionBlock = { [weak self] (returnedCursor, returnedError) in
                print("RETURNED queryCompletionBlock")
                self?.swiftItems = returnedItems
            }
        }
        addOperation(operation: queryOperation)
    }
}

