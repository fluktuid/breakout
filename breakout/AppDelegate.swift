//
//  AppDelegate.swift
//  breakout
//
//  Created by Lukas Paluch on 17.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//


import UIKit

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
        }
        struct best {
            static var points: Int {
                get { return Defaults.object(forKey: "current.points") as? Int ?? 0 }
                set { Defaults.set(newValue, forKey: "current.points") }
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
    
    
}
