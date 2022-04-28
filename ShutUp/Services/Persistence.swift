//
//  Persistence.swift
//  gsdx<g
//
//  Created by Gustav Söderberg on 2022-04-25.
//

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
