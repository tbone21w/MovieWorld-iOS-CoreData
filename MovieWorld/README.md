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
 * Create CoreDataStack class
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
   * managed object model
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
   * persistent store coordinator
   ```swift
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
   ```
   * managed object context
   ```swift
     lazy var context: NSManagedObjectContext = {
       var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
       managedObjectContext.persistentStoreCoordinator = self.psc
       managedObjectContext.name = "Main Context"
       managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

      return managedObjectContext
     }()
   ```
 * Create the CoreData Model
  * File > New > iOS CoreData and select Data Model
  * Select Next and name **MovieWorld** and save  (this matches the model name above)
   ![Single View Application](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/new_datamodel.png "New Data Model")
 * Instantiate CoreDataStack and print context name
   * Open AppDelegate.swift and delete all functions except didFinishLaunchingWithOptions
   * Instantiate CoreData and print the context name
   ```swift
<<<<<<< HEAD
     func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

          let coreDataStack = CoreDataStack()
          print("Context Name: \(coreDataStack.context.name!)")

          return true
     }
   ```
   * run app and view console and verify the path to the database and the context name is printed out
   ```swift
=======
>>>>>>> afd85bc13e103443861e9e9afde23f16b77becf1
      func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       let coreDataStack = CoreDataStack()
       print("Context Name: \(coreDataStack.context.name!)")

       return true
     }
   ```
   * run app and view console to verify the path to the database and the context name is printed out
   ![Single View Application](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/console_step_2.png "Console")

   ## Step Three
Setup data model

Open the MovieWorld data model MovieWorld.xcdatamodeld

Add the following entities

| Table   |      Attribute      |  Type |
|----------|:-------------:|:------:|
| Movie |  duration | Int32 |
|       |  title | String |
| Rating |  descr | String |
|       |  code | String |
| Genre |  name | String |

Add relationships

### Movie
| relationship | Destination | Inverse | Type |
|----------|:-------------:|:------:|
| genre |  Genre | movies | To One |
| rating |  Rating | movies | To One |

### Genre
| relationship | Destination | Inverse | Type |
|----------|:-------------:|:------:|
| movies |  Movie | genre | To Many |

### Rating
| relationship | Destination | Inverse | Type |
|----------|:-------------:|:------:|
| movies |  Movie | rating | To Many |

 ![Movie reationship ](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/movie_model_step_3.png "Movie relationship")

  ![Genre relationship](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/genre_model_step_3.png "Genre relationship")
