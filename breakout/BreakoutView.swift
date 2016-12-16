//
//  BreakoutView.swift
//  breakout
//
//  Created by Lukas Paluch on 16.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//

import UIKit

class BreakoutView: UIView {
    private let bricksPerRow:Double = 8
    private var brickBackgroundColor:UIColor{
        get {
            let random = Int(arc4random_uniform(7))
            return brickBackgrounds[random]!
        }
    }
    
    
    private var brickSize: CGSize {
        let size = bounds.size.width / CGFloat(bricksPerRow)
        return CGSize(width: size, height: size/2)
    }
    
    func initializePaddle() -> UIView {
        let paddle = Paddle()
        let size = CGSize(width: CGFloat(paddle.width), height: CGFloat(paddle.height))
        var frame = CGRect(origin: CGPoint.zero, size: size)
        frame.origin.y = CGFloat(paddle.movingLine)
        frame.origin.x = CGFloat(self.frame.width/2)
        let paddleView = UIView(frame: frame)
        paddleView.backgroundColor = UIColor.darkGray
        addSubview(paddleView)
        return paddleView
    }
    
    func initializeBall() {
        let paddle = Paddle()
        let size = CGSize(width: CGFloat(paddle.height), height: CGFloat(paddle.height))
        var frame = CGRect(origin: CGPoint.zero, size: size)
        frame.origin.y = CGFloat(self.frame.height/2)
        frame.origin.x = CGFloat(self.frame.width/2)
        let paddleView = UIView(frame: frame)
        paddleView.backgroundColor = brickBackgroundColor
        addSubview(paddleView)
    }
    
    
    func initializeBricks(bricksArray: [Brick]) {
        for i in 0..<bricksArray.count {
            let brick = initializeBrick(brick: bricksArray[i], row: CGFloat(floor(Double(i) / bricksPerRow)), column: CGFloat((Double(i).truncatingRemainder(dividingBy: bricksPerRow))))
            addSubview(brick)
        }
    }
    
    func initializeBrick(brick: Brick, row: CGFloat, column: CGFloat) -> UIView {
        var frame = CGRect(origin: CGPoint.zero, size:brickSize)
        frame.origin.x = column * brickSize.width
        frame.origin.y = row * brickSize.height
        let brick = UIView(frame:frame)
        brick.backgroundColor = brickBackgroundColor
        return brick
    }
    

    
    private let brickBackgrounds: Dictionary<Int,UIColor> = [
        0: UIColor.blue,
        1: UIColor.black,
        2: UIColor.brown,
        3: UIColor.green,
        4: UIColor.gray,
        5: UIColor.cyan,
        6: UIColor.yellow
    ]
    
}
