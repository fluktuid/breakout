//
//  brickBrain.swift
//  breakout
//
//  Created by Lukas Paluch on 12.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//

import Foundation

class BrickBrain {
    private var gameRunning = false {
        didSet {
            print("GameState:",gameRunning.description)
        }
    }
    private var bricksArray = [Brick] ()
    private let countOfBricks = 32
    private let bricksInOneLine = 5
    
    public func getBricksArray() -> [Brick] {
        return bricksArray
    }
    
    public func setGame() {
        bricksArray = initializeBricks(count: countOfBricks)
    }
    
    func initializeBricks(count: NSInteger) -> [Brick]{
        var bricksArray = [Brick]()
        var xPosition = 0
        var yPosition = 0
        
        for _ in 0..<count {
            let b = Brick()
            b.x = xPosition
            b.y = yPosition
            bricksArray.insert(b, at: bricksArray.count)
            xPosition += 1
            yPosition += 1
        }
        return bricksArray
    }
    
    /*
     @unfinished
    */
    public func removeBrick(brick: Brick) {
    }
    
    public func getGameRunning() -> Bool{
        return gameRunning
    }
    
    public func setGameRunning(running: Bool) {
        gameRunning = running
    }
}
