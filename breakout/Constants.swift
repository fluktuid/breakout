//
//  Constants.swift
//  breakout
//
//  Created by Lukas Paluch on 17.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//
//
//  colors: https://developer.apple.com/ios/human-interface-guidelines/visual-design/color/
import UIKit

public struct Constants {
    struct Ball {
        static var Size: CGSize { return CGSize(width: AppDelegate.Settings.Ball.Size, height: AppDelegate.Settings.Ball.Size) }
        static var StartSpreadAngle: CGFloat = 0.523599 // ca. pi/6
        static let BackgroundColor = UIColor.init(red: 90/255, green: 200/255, blue: 250/255, alpha: 0.8)   //Teal Blue
        static let BottomOffset = CGFloat(40.0)
        
        
        //für BreakoutBehavior
        static let MinVelocity = CGFloat(100.0)
        static let MaxVelocity = CGFloat(700.0)
    }
    struct Paddle {
        static let Size = CGSize(width: 100.0, height: -20.0)
        static let BackgroundColor = UIColor.darkGray
        static let BottomOffset = CGFloat(15.0)
    }
    struct Brick {
        static var hardness: Int = 1
        static var Rows: Int { return AppDelegate.Settings.Brick.Rows }
        static var Columns: Int { return AppDelegate.Settings.Brick.Columns }
        static let Gap = CGFloat(5.0)
        static let Height = CGFloat(30.0)
        
        static let BackgroundColor = UIColor.init(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)          //Yellow
        static let HarderBackgroundColor = UIColor.init(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)    //Orange
        static let HardestBackgroundColor = UIColor.init(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)   //Red
        static let TopOffset = CGFloat(100.0)
    }
    struct Boundary {
        static let Top = "Top"
        static let Left = "Left"
        static let Right = "Right"
        static let Bottom = "Bottom"
    }
    
    struct BreakoutView {
        static let color = UIColor.white
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
