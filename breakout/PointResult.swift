//
//  PointResult.swift
//  breakout
//
//  Created by Lukas Paluch on 21.01.17.
//  Copyright © 2017 Lukas Paluch. All rights reserved.
//

import Foundation

class PointResult {
    var timestamp:Int64
    var countOfBlocks:Int
    var playtime:Int64
    var maxHardnessOfBricks:Int
    var points:Int
    
    /*
    Zeitstempel des Spiels (wann wurde das Speil erfolgreich beendet)
    Anzahl der Blöcke im Spiel
    benötigte Spielzeit
    die maximale Wertigkeit
    die Punktzahl
     */
    
    init(timestamp:Int64,countOfBlocks:Int,playtime:Int64,maxHardnessOfBricks:Int,points:Int) {
        self.timestamp = timestamp
        self.countOfBlocks = countOfBlocks
        self.playtime = playtime
        self.maxHardnessOfBricks = maxHardnessOfBricks
        self.points = points
 /*
        self.init(timestamp: timestamp,countOfBlocks: countOfBlocks,playtime: playtime,maxHardnessOfBricks: maxHardnessOfBricks,points: points)
 */
    }
 
 

    /*
    //http://nshipster.com/nscoding/
    required convenience init?(coder decoder: NSCoder) {
        guard let timestamp = decoder.decodeObject(forKey: "timestamp") as? Int64,
            let countOfBlocks = decoder.decodeObject(forKey: "countOfBlocks") as? Int,
            let playtime = decoder.decodeObject(forKey: "playtime") as? Int64,
            let maxHardnessOfBricks = decoder.decodeObject(forKey: "maxHardnessOfBricks") as? Int,
            let points = decoder.decodeObject(forKey: "points") as? Int
            else { return nil}
        
        self.init(timestamp: timestamp,countOfBlocks: countOfBlocks,playtime: playtime,maxHardnessOfBricks: maxHardnessOfBricks,points: points)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(timestamp, forKey: "timestamp")
        aCoder.encode(countOfBlocks, forKey: "countOfBlocks")
        aCoder.encode(playtime, forKey: "playtime")
        aCoder.encode(maxHardnessOfBricks, forKey: "maxHardnessOfBricks")
        aCoder.encode(points, forKey: "points")
    }
 */
}
