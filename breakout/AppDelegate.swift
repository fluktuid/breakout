//
//  AppDelegate.swift
//  breakout
//
//  Created by Lukas Paluch on 17.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//


import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    struct Settings {
        static let Defaults = UserDefaults.standard
        struct Ball {
            static var Size: CGFloat {
                get { return Defaults.object(forKey: "Ball.Size") as? CGFloat ?? 20.0 }
                set { Defaults.set(newValue, forKey: "Ball.Size") }
            }
            static var CountOfBalls: Int {
                get { return Defaults.object(forKey: "Ball.CountOfBalls") as? Int ?? 1 }
                set { Defaults.set(newValue, forKey: "Ball.CountOfBalls") }
            }
        }
        struct Brick {
            static var Rows: Int {
                get { return Defaults.object(forKey: "Brick.Rows") as? Int ?? 3 }
                set { Defaults.set(newValue, forKey: "Brick.Rows") }
            }
            static var Columns: Int {
                get { return Defaults.object(forKey: "Brick.Columns") as? Int ?? 5 }
                set { Defaults.set(newValue, forKey: "Brick.Columns") }
            }
            static var HarderBricks: Bool {
                get { return Defaults.object(forKey: "Brick.Harder") as? Bool ?? false}
                set { Defaults.set(newValue, forKey: "Brick.Harder") }
            }
        }
        struct Game {
            static var ContinueAfterGameOver: Bool {
                get { return Defaults.object(forKey: "Game.ContinueAfterGameOver") as? Bool ?? true }
                set { Defaults.set(newValue, forKey: "Game.ContinueAfterGameOver") }
            }
        }
    }
    struct Score {
        static let Defaults = UserDefaults.standard
        struct current {
            static var points: Int {
                get { return Defaults.object(forKey: "current.points") as? Int ?? 0 }
                set { Defaults.set(newValue, forKey: "current.points") }
            }
            static var starttime: Int64 {
                get { return Defaults.object(forKey: "current.starttime") as? Int64 ?? 0 }
                set { Defaults.set(newValue, forKey: "current.starttime") }
            }
            static var maxHardnessOfBlocks: Int {
                get { return Defaults.object(forKey: "current.maxHardnessOfBlocks") as? Int ?? 0 }
                set { Defaults.set(newValue, forKey: "current.maxHardnessOfBlocks") }
            }
            static var remainingBlocks: Int {
                get { return Defaults.object(forKey: "current.remainingBlocks") as? Int ?? 0 }
                set { Defaults.set(newValue, forKey: "current.remainingBlocks") }
            }
            static var destroyedBlocks: Int {
                get { return Defaults.object(forKey: "current.destroyedBlocks") as? Int ?? 0 }
                set { Defaults.set(newValue, forKey: "current.destroyedBlocks") }
            }
        }
        
        //CheckForNil
        
        //Idee mit NSKeyedArchiver/-Unarchiver:
        //http://stackoverflow.com/questions/28240848/how-to-save-an-array-of-objects-to-nsuserdefault-with-swift
        //
        /*
        static var best:[PointResult]? {
            get {
                let data:Data? = Defaults.object(forKey: "score.best") as? Data
                if data != nil {
                    var best = NSKeyedUnarchiver.unarchiveObject(with: data!) as? [PointResult]
                    best = NSKeyedUnarchiver.unarchiveObject(withFile: "file") as? [PointResult] ?? [PointResult]()
                    return best
                } else {
                    return [PointResult]()
                }
            }
            set {
                let data = NSKeyedArchiver.archiveRootObject(newValue)
                Defaults.set(data, forKey: "score.best")
                Defaults.synchronize()
            }
        }
 */
        
        static var points:[Int] {
            get {
                return Defaults.object(forKey: "score.bestPoints") as? [Int] ?? [1,2,4,8,16,32,64,128,256,512]
            }
            set {
                Defaults.set(newValue, forKey: "score.bestPoints")
            }
        }
        static var timestamps:[Int64] {
            get {
                return Defaults.object(forKey: "score.timestamps") as? [Int64] ?? [1,2,4,8,16,32,64,128,256,512]
            }
            set {
                Defaults.set(newValue, forKey: "score.timestamps")
            }
        }
        static var countsOfBlocks:[Int] {
            get {
                return Defaults.object(forKey: "score.countsOfBlocks") as? [Int] ?? [1,2,4,8,16,32,64,128,256,512]
            }
            set {
                Defaults.set(newValue, forKey: "score.countsOfBlocks")
            }
        }
        static var playtimes: [Int64] {
            get {
                return Defaults.object(forKey: "score.playtimes") as? [Int64] ?? [1,2,4,8,16,32,64,128,256,512]
            }
            set {
                Defaults.set(newValue, forKey: "score.playtimes")
            }
        }
        static var maxHardnessesOfBricks: [Int] {
            get {
                return Defaults.object(forKey: "score.maxHardnessesOfBricks") as? [Int] ?? [1,2,4,8,16,32,64,128,256,512]
            }
            set {
                Defaults.set(newValue, forKey: "score.maxHardnessesOfBricks")
            }
        }
        
    }
    
    
    
    /*
    func savePlaces(){
        let placesArray = [Place(lat: 123, lng: 123, name: "hi")]
        let placesData = NSKeyedArchiver.archivedDataWithRootObject(placesArray)
        UserDefaults.standardUserDefaults().setObject(placesData, forKey: "places")
    }
    
    func loadPlaces(){
        let placesData = UserDefaults.standard.object(forKey: "places") as? NSData
        
        if let placesData = placesData {
            let placesArray = NSKeyedUnarchiver.unarchiveObjectWithData(placesData) as? [Place]
            
            if let placesArray = placesArray {
                // do something…
            }
            
        }
    }
*/
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "test")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    */
    
    
    

    
    
    
    
    
    
    /*
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "breakout.dummy" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
