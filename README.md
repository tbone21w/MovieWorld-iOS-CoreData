# MovieWorld-iOS-CoreData

Sample project to work with CoreData and managed objects.

## Step One
Setup new project.
 * Xcode 7.3
 * IOS 9
 * Swift 2.2


 Create new project  **File > New > Project**
 ![Single View Application](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/singleview_app.png "Single View Application")


 Project details - add the following
  * Product Name **MovieWorld**
  * Language **Swift**
  * Device **Universal**
  *  **DO NOT SELECT _Use Core Data_** (we will be creating a helper class)
 ![Single View Application](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/project_details.png "Project Details")

 Save and add version control
  * Check **Create Git repository** on (My Mac)
 ![Single View Application](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/version_control.png "Version Control")

## Step Two
Setup CoreData
We will be creating a helper class to access the managed object context which is used to access CoreData. We will also be setting up the CoreData model which is use to create the mapping to the database.

 * Create CoreDataStack class Swift file
   * File > New > File
   * select iOS Source and Swift
   * Name CoreDataStack
   * import CoreData
   ```swift
    import CoreData

    class CoreDataStack {

    }
   ```
   * create constant variable **"MovieWorld"**
   ```swift
      class CoreDataStack {

      let modelName = "MovieWorld"
   ```
   * managed object model  (loads the data model named "MovieWord")
   ```swift
     private lazy var managedObjectModel: NSManagedObjectModel = {

       let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!

       return NSManagedObjectModel(contentsOfURL: modelURL)!
     }()
   ```
   * application document dir
   ```swift
     private lazy var applicationDocumentsDirectory: NSURL = {
       let urls = NSFileManager
                     .defaultManager()
                     .URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
       return urls.last!
     }()
   ```
   * persistent store coordinator - coordinates the objects between the data store and the managed context.  Also verifies the data is in a consistent state.
   ```swift
     private lazy var psc: NSPersistentStoreCoordinator = {

       let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
       let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(self.modelName)

       print("Persistent Store URL: \(url)")
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
   ```
   * managed object context - This is the context (object) the application works with to manipulate data.  It is usually described as a "scratch pad".  The objects are pulled from the persistent store and placed in the memory in the context where they may be changed.  If the changes are not saved, the persistent store remains unchanged. All objects must be registered with the context so any new objects will need to be registered.
   ```swift
     lazy var context: NSManagedObjectContext = {
       var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
       managedObjectContext.persistentStoreCoordinator = self.psc
       managedObjectContext.name = "Main Context"
       managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

      return managedObjectContext
     }()
   ```
 * Create the CoreData Model - This is used to make the mapping to the data store and the relations between the objects and much more.
  * File > New > iOS CoreData and select Data Model
  * Select Next and name **MovieWorld** and save  (this matches the model name above)
   ![Single View Application](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/new_datamodel.png "New Data Model")
 * Instantiate CoreDataStack and print context name
   * Open AppDelegate.swift and delete all functions except didFinishLaunchingWithOptions
   * Instantiate CoreData and print the context name
   ```swift
     func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

          let coreDataStack = CoreDataStack()
          print("Context Name: \(coreDataStack.context.name!)")

          return true
     }
   ```
   * run app and view console and verify the path to the database and the context name is printed out
   ```swift
      func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       let coreDataStack = CoreDataStack()
       print("Context Name: \(coreDataStack.context.name!)")

       return true
     }
   ```
   * ![Single View Application](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/console_step_2.png "Console")

## Step Three
Define the data model.  
NOTE: make change to the the .xcdatamodeld requires a migration.  We will not tackle that sine we are not deploying code.  Just remember to reset the the simulator (Simulator > Reset Content & Settings) or delete and reinstall the application.

We will be creating the following data model:

![ERD](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/erd.png "ERD")

Open the MovieWorld data model **MovieWorld.xcdatamodeld**

Add the following entities

| Table   |      Attribute      |  Type |
|----------|:-------------:|:------:|
| **Movie** |  duration | Int32 |
|       |  title | String |
| **Rating** |  descr | String |
|       |  code | String |
| **Genre** |  name | String |

Add relationships

### Movie

| relationship | Destination | Inverse | Type |
|----------|:-------------:|:------:|:------:|
| genre |  Genre | movies | To One |
| rating |  Rating | movies | To One |

### Genre

| relationship | Destination | Inverse | Type |
|----------|:-------------:|:------:|:------:|
| movies |  Movie | genre | To Many |

### Rating

| relationship | Destination | Inverse | Type |
|----------|:-------------:|:------:|:------:|
| movies |  Movie | rating | To Many |

 ![Movie reationship ](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/movie_model_step_3.png "Movie relationship")

  ![Genre relationship](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/genre_model_step_3.png "Genre relationship")
