//
//  PointResult.swift
//  breakout
//
//  Created by Lukas Paluch on 21.01.17.
//  Copyright © 2017 Lukas Paluch. All rights reserved.
//

import Foundation

class PointResult: NSObject {
    let timestamp:Int64
    let countOfBlocks:Int
    let playtime:Int64
    let maxHardnessOfBricks:Int
    let points:Int
    
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
    }
}
