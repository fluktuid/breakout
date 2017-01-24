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
    
    
    init(timestamp:Int64,countOfBlocks:Int,playtime:Int64,maxHardnessOfBricks:Int,points:Int) {
        self.timestamp = timestamp
        self.countOfBlocks = countOfBlocks
        self.playtime = playtime
        self.maxHardnessOfBricks = maxHardnessOfBricks
        self.points = points
    }
}
