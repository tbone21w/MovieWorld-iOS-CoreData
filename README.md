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
 ![Single View Application](https://github.com/tbone21w/MovieWorld-iOS-CoreData/raw/master/resources/version_control.png "Project Details")
   
## Step Two
Setup CoreData

 * File > New > File
   * select iOS Source and Swift
   * Name CoreDataStack
   * import CoreData
   * class creation code
   * create constant variable "MovieWorld"
   * managed object model 
   * application document dir
   * persistent store coordinator
   * managed object context
 * File > New > iOS CoreData and select Data Model
  * name MovieWorld
 * Instantiate CoreDataStack and print context name

