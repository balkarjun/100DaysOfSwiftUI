//
//  DataController.swift
//  P11-Bookworm
//
//  Created by Arjun B on 31/10/22.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    // name of the data model file
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
