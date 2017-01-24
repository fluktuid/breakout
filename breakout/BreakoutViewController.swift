//
//  ViewController.swift
//  breakout
//
//  Created by Lukas Paluch on 12.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//

import UIKit
import CoreData

class BreakoutViewController: UIViewController, BreakoutGameDelegate {
    
    @IBOutlet weak var breakoutView: UIView!
    @IBOutlet weak var levelLabel: UILabel!
    
    var highscores: [NSManagedObject] = []
    
    var levelcounter = 1
    
    lazy var breakoutGame: BreakoutGameBehavior = {
        let lazyBreakoutGame = BreakoutGameBehavior()
        lazyBreakoutGame.delegate = self
        return lazyBreakoutGame
    }()
    
    public var ballCount:Int = AppDelegate.Settings.Ball.CountOfBalls
    
    lazy var breakoutAnimator: UIDynamicAnimator = {
        let lazyBreakoutAnimator = UIDynamicAnimator(referenceView: self.breakoutView)
        return lazyBreakoutAnimator
    }()
    
    
    private var ballView: UIView? = nil
    
    private var paddleView: UIView? = nil
    
    private var brickViews: [[UIView]] = [[]]
    
    // MARK: - View controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        breakoutAnimator.addBehavior(breakoutGame)
        setBackground()
    }
    func setBackground() {
        breakoutView!.backgroundColor = Constants.BreakoutView.color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        breakoutGame.resumeGame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startGame(continuing: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        breakoutGame.pauseGame()
    }
    
    @IBAction func moveBall(_ tapGesture: UITapGestureRecognizer) {
        switch tapGesture.state {
        case .ended:
            let angleBasePart = CGFloat(M_PI/2)
            let angleRandomSpread = CGFloat(Float(arc4random()) / Float(UINT32_MAX) - 0.5) * Constants.Ball.StartSpreadAngle
            let angle = angleBasePart + angleRandomSpread
            let magnitude = CGFloat(0.5)
            breakoutGame.pushView(ballView!, angle: angle, magnitude: magnitude)
        default:
            break
        }
    }
    
    @IBAction func movePaddle(_ panGesture: UIPanGestureRecognizer) {
        switch panGesture.state {
        case .began: fallthrough
        case .changed: fallthrough
        case .ended:
            let translation = panGesture.translation(in: breakoutView)
            breakoutGame.moveView(paddleView!, translation: translation)
            panGesture.setTranslation(CGPoint.zero, in: breakoutView)
        default:
            break
        }
    }
    
    func changeLevelLabel() {
        if(AppDelegate.Settings.Game.LevelMode) {
            levelLabel!.text = "Level \(String(levelcounter))"
            levelLabel.textColor = UIColor.gray
        } else {
            levelLabel!.text = "Levelmode off"
            levelLabel.textColor = UIColor.lightGray
        }
    }
    
    func createBall() {
        let ballViewOrigin = CGPoint(x: breakoutView.bounds.midX - Constants.Ball.Size.width / 2,
                                     y: breakoutView.bounds.maxY - Constants.Ball.BottomOffset - Constants.Ball.Size.height / 2)
        ballView = Ellipse(frame: CGRect(origin: ballViewOrigin, size: Constants.Ball.Size))
        ballView!.layer.backgroundColor = Constants.Ball.BackgroundColor.cgColor
        ballView!.layer.cornerRadius = ballView!.layer.frame.width/2
        ballView!.type = BreakoutViewType.ball
        ballView!.clipsToBounds=true
        breakoutGame.addView(ballView!)
    }
    
    
    //Breakout game
    
    func startGame(continuing:Bool) {
        changeLevelLabel()
        if !continuing {
            breakoutGame.savedPoints = 0
            levelcounter = 1
        }
        if AppDelegate.Settings.Game.LevelMode {
            AppDelegate.Score.current.maxHardnessOfBlocks = levelcounter
        } else if AppDelegate.Settings.Brick.HarderBricks {
            AppDelegate.Score.current.maxHardnessOfBlocks = 3
        } else {
            AppDelegate.Score.current.maxHardnessOfBlocks = 1
        }
        ballCount = AppDelegate.Settings.Ball.CountOfBalls
        AppDelegate.Score.current.points = 0
        AppDelegate.Score.current.remainingBlocks = AppDelegate.Settings.Brick.Columns * AppDelegate.Settings.Brick.Rows
        AppDelegate.Score.current.destroyedBlocks = 0
        AppDelegate.Score.current.starttime = NSDate().timeIntervalSince1970
        
        for view in breakoutView.subviews {
            breakoutGame.removeView(view)
        }
        
        breakoutView.type = BreakoutViewType.boundary
        breakoutGame.createBoundary(breakoutView)
        
        for _ in 0..<AppDelegate.Settings.Ball.CountOfBalls {
            createBall()
        }
        
        
        let paddleViewOrigin = CGPoint(x: breakoutView.bounds.midX - Constants.Paddle.Size.width / 2, y: breakoutView.bounds.maxY - Constants.Paddle.BottomOffset)
        
        paddleView = Ellipse(frame: CGRect(origin: paddleViewOrigin, size: Constants.Paddle.Size))
        paddleView!.layer.backgroundColor = Constants.Paddle.BackgroundColor.cgColor
        let maskLayer = CAShapeLayer()
        maskLayer.frame = paddleView!.bounds
        maskLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 100, height: 30)).cgPath
        paddleView!.layer.mask = maskLayer
        paddleView!.type = BreakoutViewType.paddle
        paddleView!.clipsToBounds = true
        breakoutGame.addView(paddleView!)
        
        
        var brickViewSize = CGSize(width: (breakoutView.bounds.width - Constants.Brick.Gap * CGFloat(Constants.Brick.Columns + 1))
            / CGFloat(Constants.Brick.Columns),
                                   height: Constants.Brick.Height)
        brickViews.reserveCapacity(Constants.Brick.Rows)
        
        if levelcounter % 10 == 0 {   //10er Level
            brickViewSize = CGSize(width: (breakoutView.bounds.width - Constants.Brick.Gap * CGFloat(7 + 1))
                / CGFloat(7),
                                   height: Constants.Brick.Height)
            brickViews.reserveCapacity(10)
            
            for row in 0 ..< 7 {
                var bricksColumn: [UIView] = []
                bricksColumn.reserveCapacity(7)
                for column in 0 ..< 10 {
                    let brickViewOrigin = CGPoint(x: Constants.Brick.Gap + (brickViewSize.width + Constants.Brick.Gap) * CGFloat(column),
                                                  y:  Constants.Brick.TopOffset + (brickViewSize.height + Constants.Brick.Gap) * CGFloat(row))
                    let brickView = UIView(frame: CGRect(origin: brickViewOrigin, size: brickViewSize))
                    brickView.layer.backgroundColor = Constants.Brick.HardestBackgroundColor.cgColor
                    brickView.type = BreakoutViewType.brick
                    bricksColumn.insert(brickView, at: column)
                    breakoutGame.addView(brickView)
                }
                brickViews.insert(bricksColumn, at: row)
            }
        } else {
            for row in 0 ..< Constants.Brick.Rows {
                var bricksColumn: [UIView] = []
                bricksColumn.reserveCapacity(Constants.Brick.Columns)
                for column in 0 ..< Constants.Brick.Columns {
                    let brickViewOrigin = CGPoint(x: Constants.Brick.Gap + (brickViewSize.width + Constants.Brick.Gap) * CGFloat(column),
                                                  y:  Constants.Brick.TopOffset + (brickViewSize.height + Constants.Brick.Gap) * CGFloat(row))
                    let brickView = UIView(frame: CGRect(origin: brickViewOrigin, size: brickViewSize))
                    if AppDelegate.Settings.Game.LevelMode {
                        if levelcounter<3 {
                            if (levelcounter == 3) {
                                brickView.layer.backgroundColor = Constants.Brick.HardestBackgroundColor.cgColor
                            } else if(levelcounter == 2) {
                                brickView.layer.backgroundColor = Constants.Brick.HarderBackgroundColor.cgColor
                            } else {
                                brickView.layer.backgroundColor = Constants.Brick.BackgroundColor.cgColor
                            }
                        } else if(AppDelegate.Settings.Brick.HarderBricks) {
                            let harder = Int(arc4random_uniform(3))
                            if (harder == 2) {
                                brickView.layer.backgroundColor = Constants.Brick.HardestBackgroundColor.cgColor
                            } else if(harder == 1) {
                                brickView.layer.backgroundColor = Constants.Brick.HarderBackgroundColor.cgColor
                            } else {
                                brickView.layer.backgroundColor = Constants.Brick.BackgroundColor.cgColor
                            }
                        } else {
                            brickView.layer.backgroundColor = Constants.Brick.BackgroundColor.cgColor
                        }
                        brickView.type = BreakoutViewType.brick
                        bricksColumn.insert(brickView, at: column)
                        breakoutGame.addView(brickView)
                    }
                    brickViews.insert(bricksColumn, at: row)
                }
            }
        }
    }
    
    func winGame() {
        print("calculatedP:",breakoutGame.calculatePoints())
        breakoutGame.savedPoints = breakoutGame.calculatePoints()
        breakoutGame.pauseGame()
        if(!AppDelegate.Settings.Game.LevelMode) {
            //single level
            let alert = UIAlertController(title: "Victory", message: "You scored \(AppDelegate.Score.current.points) points", preferredStyle: UIAlertControllerStyle.alert)
            let newGameAction = UIAlertAction(title: "New Game", style: UIAlertActionStyle.cancel) {
                (action: UIAlertAction!) -> Void in
                self.startGame(continuing: false)
                self.addToHighscore()
            }
            alert.addAction(newGameAction)
            present(alert, animated: true, completion: nil)
        } else {
            //multi level
            
            //kleiner Hack, da diese Me
            levelcounter += 1
            startGame(continuing: true)
        }
    }
    
    func updateCurrentBadge(points: Int) {
        tabBarController?.tabBar.items![0].badgeValue = String(points)
    }
    
    func addToHighscore() {
        let points = breakoutGame.calculatePoints()
        
        let current = NSDate().timeIntervalSince1970           //current time
        let z = current - AppDelegate.Score.current.starttime  //playtime
        let w = AppDelegate.Score.current.maxHardnessOfBlocks  //max hardness
        
        
        addHighscore(points: NSNumber(value: points),
                     maxHardnessOfBricks: NSNumber(value: w),
                     playtime: NSNumber(value: z),
                     countOfBlocks: NSNumber(value: (AppDelegate.Score.current.destroyedBlocks + AppDelegate.Score.current.remainingBlocks)),
                     timestamp: NSNumber(value: current))
    }
    
    func addHighscore(points: NSNumber, maxHardnessOfBricks: NSNumber, playtime: NSNumber, countOfBlocks: NSNumber, timestamp:NSNumber) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        print("addHS points",points)
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Highscore",
                                                in: managedContext)!
        
        let test = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        test.setValue(points, forKeyPath: "points")
        test.setValue(maxHardnessOfBricks, forKeyPath: "maxHardnessOfBricks")
        test.setValue(playtime, forKeyPath: "playtime")
        test.setValue(countOfBlocks, forKeyPath: "countOfBlocks")
        test.setValue(timestamp, forKeyPath: "timestamp")
        
        do {
            try managedContext.save()
            highscores.append(test)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func endGame() {
        breakoutGame.pauseGame()
        let alert = UIAlertController(title: "Game Over", message: "you have lost\nYou scored \(AppDelegate.Score.current.points) points", preferredStyle: UIAlertControllerStyle.alert)
        let newGameAction = UIAlertAction(title: "New Game", style: UIAlertActionStyle.cancel) {
            (action: UIAlertAction!) -> Void in
            self.addToHighscore()
            self.startGame(continuing: false)
        }
        alert.addAction(newGameAction)
        if AppDelegate.Settings.Game.ContinueAfterGameOver == true {
            let continueAction = UIAlertAction(title: "Continue", style: UIAlertActionStyle.default) {
                (action: UIAlertAction!) -> Void in
                self.breakoutGame.resumeGame()
            }
            alert.addAction(continueAction)
        }
        present(alert, animated: true, completion: nil)
    }
    
    public func getBallCount() -> Int {
        return ballCount
    }
    public func removeBall() {
        ballCount = ballCount - 1
    }
}
