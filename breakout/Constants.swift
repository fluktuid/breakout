//
//  Constants.swift
//  breakout
//
//  Created by Lukas Paluch on 17.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//
import UIKit

public struct Constants {
    struct Ball {
        static var Size: CGSize { return CGSize(width: AppDelegate.Settings.Ball.Size, height: AppDelegate.Settings.Ball.Size) }
        static var StartSpreadAngle: CGFloat = 0.523599 // ca. pi/6
        static let BackgroundColor = UIColor.cyan
        static let BottomOffset = CGFloat(40.0)
        
        
        //für BreakoutBehavior
        static let MinVelocity = CGFloat(100.0)
        static let MaxVelocity = CGFloat(700.0)
    }
    struct Paddle {
        static let Size = CGSize(width: 100.0, height: -20.0)
        static let BackgroundColor = UIColor.gray
        static let BottomOffset = CGFloat(15.0)
    }
    struct Brick {
        static var hardness: Int = 1
        static var Rows: Int { return AppDelegate.Settings.Brick.Rows }
        static var Columns: Int { return AppDelegate.Settings.Brick.Columns }
        static let Gap = CGFloat(5.0)
        static let Height = CGFloat(30.0)
        static let BackgroundColor = UIColor.magenta
        static let HarderBackgroundColor = UIColor.gray
        static let HardestBackgroundColor = UIColor.blue
        static let TopOffset = CGFloat(100.0)
    }
    struct Boundary {
        static let Top = "Top"
        static let Left = "Left"
        static let Right = "Right"
        static let Bottom = "Bottom"
    }
    
    private let colors: Dictionary<Int,UIColor> = [
        0: UIColor.black,
        1: UIColor.blue,
        2: UIColor.brown,
        3: UIColor.cyan,
        4: UIColor.darkGray,
        5: UIColor.gray,
        6: UIColor.green,
        7: UIColor.magenta,
        8: UIColor.orange,
        9: UIColor.purple,
        10:UIColor.red,
        11:UIColor.yellow
    ]
}
