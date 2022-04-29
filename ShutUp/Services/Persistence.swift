/**
 
 - Description:
 The Persistance.swift is provided by Apple and handles the communication with CoreData
 
 - Authors:
 Andreas J
 Gustav S
 Calle H
 
 */

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ShutUpCD")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
                
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
