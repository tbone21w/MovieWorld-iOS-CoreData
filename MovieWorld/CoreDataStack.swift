//
//  CoreDataStack.swift
//  MovieWorld
//
//  Created by Todd Isaacs on 7/13/16.
//  Copyright © 2016 Todd Isaacs. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack {
  
  //MARK: variables
  let modelName = "MovieWorld"
  
  
  //MARK: public
  lazy var context: NSManagedObjectContext = {
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    managedObjectContext.persistentStoreCoordinator = self.psc
    managedObjectContext.name = "Main Context"
    managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    
    return managedObjectContext
  }()
  
  
  //MARK: private
  private lazy var applicationDocumentsDirectory: NSURL = {
    let urls = NSFileManager
      .defaultManager()
      .URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return urls.last!
  }()
  
  
  
  private lazy var managedObjectModel: NSManagedObjectModel = {
    
    let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!
    
    return NSManagedObjectModel(contentsOfURL: modelURL)!
  }()
  
  

  private lazy var psc: NSPersistentStoreCoordinator = {
    
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(self.modelName)
    
    print("Persistant Store URL: \(url)")
    do {
      let options = [NSMigratePersistentStoresAutomaticallyOption : true]
      
      try coordinator.addPersistentStoreWithType(NSSQLiteStoreType,
                                                 configuration: nil,
                                                 URL: url,
                                                 options: options)
    } catch  {
      print("Error adding persistent store.")
    }
    
    return coordinator
  }()
  
}
