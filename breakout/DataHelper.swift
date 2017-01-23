//
//  DataHelper.swift
//  breakout
//
//  Created by Lukas Paluch on 23.01.17.
//  Copyright © 2017 Lukas Paluch. All rights reserved.
//

import UIKit
import CoreData

class DataHelper {

    func fetchHighscores() -> [PointResult] {
        let appDel:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LogItem")
  //      request.returnsObjectsAsFaults = false
//        let sortDescriptor = NSSortDescriptor(key: "prozent", ascending: false)
//        let sortDescriptors = [sortDescriptor]
//        request.sortDescriptors = sortDescriptors
//        request.returnsObjectsAsFaults = false
        
        /*
        do{
            let results = try context.execute(request)
            let bar = results as! LogItem
            print(bar)
        }catch{
            fatalError("Error is retriving Gorcery items")
        }
        */
        
        
        
        var array = [PointResult]()
        
        
        
        
        
        
        
        
        
        /*
        do{
            let highscores = try context.fetch(request) as NSArray
            
            //Workaround durch Bug
            
            
            
            var position = 0
            if(highscores.count > 0){
                print(Mirror(reflecting: highscores))
                for high in highscores {
                    print(Mirror(reflecting: high))
                }
                for highscore in highscores as! [NSManagedObject] {
                    position += 1
                    let points = highscores.value(forKey: "points") as? String
                    
                    print(Mirror(reflecting: points),points)
                    let playtime = highscores.value(forKey: "playtime") as? String
                    let timestamp = highscores.value(forKey: "timestamp") as? String
                    let maxHardnessOfBlocks = highscores.value(forKey: "maxHardnessOfBricks") as? String
                    let countOfBlocks = highscores.value(forKey: "countOfBlocks") as? String
         //           print(highscore)
       /*             array.append(PointResult(timestamp: Int64(timestamp),
                                             countOfBlocks: countOfBlocks,
                                             playtime: Int64(playtime),
                                             maxHardnessOfBricks: maxHardnessOfBlocks,
                                             points: points))
 */
    /*                if(position == 10)
                    {
                        break
                    }
                    */
                }
            } else {
                print("0 Results?")
            }
        }catch{
            print("error?")
        }
        */
        return array
    }
 
    func saveHighscore(timestamp: NSNumber,countOfBlocks:NSNumber,playtime:NSNumber,maxHardnessOfBricks:NSNumber,points:NSNumber) {
        
        
        let appDel:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let moc = appDel.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Highscore", in: moc)
        let desc = NSManagedObject(entity: entity!, insertInto: moc)
        
        
        do{
            /*
            desc.setValue(1 , forKey: "timestamp")
            desc.setValue(2, forKey: "countOfBlocks")
            desc.setValue(3, forKey: "timestamp")
            desc.setValue(4, forKey: "maxHardnessOfBricks")
            desc.setValue(5, forKey: "points")
            */
            
            print(String(describing: timestamp))
            desc.setValue(timestamp, forKey: "timestamp")
            desc.setValue(countOfBlocks, forKey: "countOfBlocks")
            desc.setValue(playtime, forKey: "timestamp")
            desc.setValue(maxHardnessOfBricks, forKey: "maxHardnessOfBricks")
            desc.setValue(points, forKey: "points")
            
        } catch {
            fatalError("\(error)")
        }
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
 
    }

}


