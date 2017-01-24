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
            static var LevelMode: Bool {
                get { return Defaults.object(forKey: "Game.LevelMode") as? Bool ?? true }
                set { Defaults.set(newValue, forKey: "Game.LevelMode") }
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
            static var starttime: TimeInterval {
                get { return Defaults.object(forKey: "current.starttime") as? TimeInterval ?? 0 }
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
