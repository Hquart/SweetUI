//
//  ResourceViewModel.swift
//  ReSwift
//
//  Created by Naji Achkar on 17/02/2022.


import Foundation
import SwiftUI

import CloudKit

class CKResourcesViewModel: ObservableObject {
    
    @Published var swiftItems: [SwiftItem] = []
    
    init() {
        fetchItems()
    }
    
    
    
    //////////////////////////////////////////////////////////////////////////////////////////////// CREATE FUNCTIONS    ////////////////////////////////////////////////////////////////////////////////////////////////
    func addResourceItem(type: String, designImage: UIImage?, codeImage: UIImage?) {
        let newSwiftItem = CKRecord(recordType: "SwiftItem")
        newSwiftItem["type"] = type
        
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
      
        guard let CkCodeImage = codeImage,
              let codeUrl = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("\(type)+code.jpg"),
              let codeData = CkCodeImage.jpegData(compressionQuality: 1.0) else { return }
        do {
            try codeData.write(to: codeUrl)
            let codeAsset = CKAsset(fileURL: codeUrl)
            newSwiftItem["codeImage"] = codeAsset
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
                self?.fetchItems()
            }
        }
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////// READ FUNCTIONS    ////////////////////////////////////////////////////////////////////////////////////////////////
    func addOperation(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
    }
    
     func fetchItems() {
        
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
                    ////////////////////////////////////////////////////////////////////////////////////////////////
                    guard let type = record["type"] as? String else { return }
                    let designImageAsset = record["designImage"] as? CKAsset
                    let designImageUrl = designImageAsset?.fileURL
                    let codeImageAsset = record["codeImage"] as? CKAsset
                    let codeImageUrl = codeImageAsset?.fileURL
                    
                    
                    returnedItems.append(SwiftItem(type: type, designImage: designImageUrl, codeImage: codeImageUrl, record: record))
                                         
                case .failure(let error):
                    print("Error recordMatchedBlock: \(error)")
                }
            }
        } else {
            queryOperation.recordFetchedBlock =  { (record) in
                guard let type = record["type"] as? String else { return }
                let designImageAsset = record["designImage"] as? CKAsset
                let designImageUrl = designImageAsset?.fileURL
                let codeImageAsset = record["codeImage"] as? CKAsset
                let codeImageUrl = codeImageAsset?.fileURL
                
                
                returnedItems.append(SwiftItem(type: type, designImage: designImageUrl, codeImage: codeImageUrl, record: record))
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
    //////////////////////////////////////////////////////////////////////////////////////////////// UPDATE FUNCTION    ////////////////////////////////////////////////////////////////////////////////////////////////
//    func updateItem(resource: Resource) {
//        let record = resource.record
//        record["name"] = "NEW NAME"
//        saveItem(record: record)
//    }
    //////////////////////////////////////////////////////////////////////////////////////////////// DELETE FUNCTION    ////////////////////////////////////////////////////////////////////////////////////////////////

//    func deleteItem(indexSet: IndexSet) {
//        guard let index = indexSet.first else { return }
//        let resourceToRemove = resources[index]
//        let record = resourceToRemove.record
//
//            CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { [weak self] returnedRecordID, returnedError in
//                DispatchQueue.main.async {
//                self?.resources.remove(at: index)
//                }
//
//        }
//    }

}







////////////////////////////////////////////////////////////////////////////////////////////////   ////////////////////////////////////////////////////////////////////////////////////////////////
//    func fetchPreview(urlString: String) {
//        guard let url = URL(string: urlString) else {
//            return
//        }
//        let linkPreview = LPLinkView()
//        let provider = LPMetadataProvider()
//        provider.startFetchingMetadata(for: url) { [weak self] metaData, error in
//            guard let data = metaData, error == nil else {
//                return
//            }
//            DispatchQueue.main.async {
//                linkPreview.metadata = data
//                self?.view.addSubview(linkPreview)
//                linkPreview.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
//                linkPreview.center = self?.view.center ?? .zero
//            }
//        }
//    }
