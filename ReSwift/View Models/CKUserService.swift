//
//  CKUserViewModel.swift
//  ReSwift
//
//  Created by Maertens Yann-Christophe on 16/02/22.
//

import Foundation
import CloudKit
import UIKit

class CKUserService: ObservableObject {
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
//    @Published var familyName: String = ""
    @Published var UIImage: UIImage?
    @Published var permissionStatus: Bool = false
    @Published var contributionScore: Int = 0
    
    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecordID()
    }
    
    private func getiCloudStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in //check use status (happens asynchronously so self is weak)
            DispatchQueue.main.async {
                switch returnedStatus {
                case .available:
                    self?.isSignedInToiCloud = true
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .temporarilyUnavailable:
                    self?.error = CloudKitError.iCloudAccountTemporaryUnavailable.rawValue
                @unknown default:
                    self?.error = CloudKitError.iCloudAccountUnknowIssue.rawValue
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotDetermined
        case iCloudAccountNotAvailable
        case iCloudAccountRestricted
        case iCloudAccountNotFound
        case iCloudAccountTemporaryUnavailable
        case iCloudAccountUnknowIssue
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                }
            }
    }
    }
    
    
    func fetchiCloudUserRecordID() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    
    
    func discoveriCloudUser(id: CKRecord.ID) {
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
//                   let familyName = returnedIdentity?.nameComponents?.familyName
                
                    self?.userName = name
//                    self?.familyName = familyName
                }
            }
        }
    }
}


     
                    
