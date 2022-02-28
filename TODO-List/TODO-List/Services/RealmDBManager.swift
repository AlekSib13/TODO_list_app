//
//  RealmDBManager.swift
//  TODO-List
//
//  Created by Aleksandr Malinin on 27.02.2022.
//

import Foundation
import RealmSwift

protocol BaseRealm {}

extension BaseRealm {
    var realmDB: Realm {try! Realm()}
}

class RealmDBManager {
    static let instance = RealmDBManager()
    
    private init() {}
    
    func initializeDB() {
        do {let file =  try FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("toDoList.realm")
            
            Realm.Configuration.defaultConfiguration = Realm.Configuration(fileURL: file, inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: 0, migrationBlock: nil, deleteRealmIfMigrationNeeded: true, shouldCompactOnLaunch: nil, objectTypes: nil)
            //MARK: for the purposes of development 'deleteRealmIfMigrationNedded is set to true and migtaionBlock is nil, but prior 'go-live' it is required to use migration block with schema versions
            
            print("Realm: \(Realm.Configuration.defaultConfiguration.fileURL!)")
            
        } catch {
            let error = NSError(domain: RealmErrors.description, code: RealmErrors.couldNotCreateRealm.rawValue, userInfo: [NSLocalizedDescriptionKey: RealmErrors.couldNotCreateRealm.describeError()])
            
            print("\(error.localizedDescription)")
            return
        }
    }
}
