//
//  ViewController.swift
//  breakout
//
//  Created by Lukas Paluch on 12.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//

import UIKit

class BreakoutViewController: UIViewController, BreakoutGameDelegate {
    
    @IBOutlet weak var breakoutView: UIView!
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        breakoutGame.resumeGame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startGame()
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
    
    func createBall() {
        let ballViewOrigin = CGPoint(x: breakoutView.bounds.midX - Constants.Ball.Size.width / 2,
                                     y: breakoutView.bounds.maxY - Constants.Ball.BottomOffset - Constants.Ball.Size.height / 2)
        ballView = UIView(frame: CGRect(origin: ballViewOrigin, size: Constants.Ball.Size))
        ballView!.layer.backgroundColor = Constants.Ball.BackgroundColor.cgColor
        ballView!.layer.cornerRadius = ballView!.layer.frame.width/2
        ballView!.type = BreakoutViewType.ball
        ballView!.clipsToBounds=true
        breakoutGame.addView(ballView!)
    }
    
    
    //Breakout game
    
    func startGame() {
        ballCount = AppDelegate.Settings.Ball.CountOfBalls
        AppDelegate.Score.current.points = 0
        AppDelegate.Score.current.remainingBlocks = AppDelegate.Settings.Brick.Columns * AppDelegate.Settings.Brick.Rows
        AppDelegate.Score.current.destroyedBlocks = 0
   //     AppDelegate.Score.current.starttime = Int64(NSDate().timeIntervalSince1970)
        
        for view in breakoutView.subviews {
            breakoutGame.removeView(view)
        }
        
        breakoutView.type = BreakoutViewType.boundary
        breakoutGame.createBoundary(breakoutView)
        
        for _ in 0..<AppDelegate.Settings.Ball.CountOfBalls {
            createBall()
        }
        
        let paddleViewOrigin = CGPoint(x: breakoutView.bounds.midX - Constants.Paddle.Size.width / 2, y: breakoutView.bounds.maxY - Constants.Paddle.BottomOffset)
        
        paddleView = UIView(frame: CGRect(origin: paddleViewOrigin, size: Constants.Paddle.Size))
        
        paddleView!.layer.backgroundColor = Constants.Paddle.BackgroundColor.cgColor
        
        
        //ultra hard layer!
   /*
        let maskLayer = CAShapeLayer()
        maskLayer.frame = paddleView!.bounds
        maskLayer.path = UIBezierPath(ovalIn: CGRect(x: 10, y: 0, width: 10, height: 10)).cgPath
        paddleView!.layer.mask = maskLayer
 */
        
        //normal layer
      /*
        let maskLayer = CAShapeLayer()
        maskLayer.frame = paddleView!.bounds
        maskLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 100, height: 10)).cgPath
        paddleView!.layer.mask = maskLayer
 */
        
        paddleView!.layer.cornerRadius = min(paddleView!.frame.size.height, paddleView!.frame.size.width) / 2.0
        paddleView!.type = BreakoutViewType.paddle
        paddleView!.clipsToBounds = true
        breakoutGame.addView(paddleView!)
        
        let brickViewSize = CGSize(width: (breakoutView.bounds.width - Constants.Brick.Gap * CGFloat(Constants.Brick.Columns + 1))
            / CGFloat(Constants.Brick.Columns),
                                   height: Constants.Brick.Height)
        brickViews.reserveCapacity(Constants.Brick.Rows)
        for row in 0 ..< Constants.Brick.Rows {
            var bricksColumn: [UIView] = []
            bricksColumn.reserveCapacity(Constants.Brick.Columns)
            for column in 0 ..< Constants.Brick.Columns {
                let brickViewOrigin = CGPoint(x: Constants.Brick.Gap + (brickViewSize.width + Constants.Brick.Gap) * CGFloat(column),
                                              y:  Constants.Brick.TopOffset + (brickViewSize.height + Constants.Brick.Gap) * CGFloat(row))
                let brickView = UIView(frame: CGRect(origin: brickViewOrigin, size: brickViewSize))
                
                if(AppDelegate.Settings.Brick.HarderBricks) {
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
    
    func winGame() {
        addToHighscore()
//        breakoutGame.pauseGame()
        
        let alert = UIAlertController(title: "Victory", message: "You scored \(AppDelegate.Score.current.points) points", preferredStyle: UIAlertControllerStyle.alert)
        let newGameAction = UIAlertAction(title: "New Game", style: UIAlertActionStyle.cancel) {
            (action: UIAlertAction!) -> Void in
            self.startGame()
        }
        alert.addAction(newGameAction)
        breakoutGame.pauseGame()
        present(alert, animated: true, completion: nil)
    }
    
    func updateCurrentBadge() {
        tabBarController?.tabBar.items![0].badgeValue = String(AppDelegate.Score.current.points)
    }
    
    func addToHighscore() {
        let points = breakoutGame.calculatePoints()
        
        let current = NSDate().timeIntervalSince1970
 //       let z = (NSNumber(value: current) as! Decimal) - (NSNumber(value: AppDelegate.Score.current.starttime) as! Decimal)  //playtime
        let w = AppDelegate.Score.current.maxHardnessOfBlocks                      //max hardness

        
        var best:[PointResult]? = loadPointResultArray()
        //TODO: currentBlocks!
  //      DataHelper().saveHighscore(timestamp: NSNumber(value: current), countOfBlocks: NSNumber(value: 0), playtime: NSNumber(value: 0), maxHardnessOfBricks: NSNumber(value: w), points: NSNumber(value: points))
    }
    
    //todo: in model?
    func loadPointResultArray() -> [PointResult] {
  //      let pointResultArray = DataHelper().fetchHighscores()
        let points = AppDelegate.Score.points
        let timestamps = AppDelegate.Score.timestamps
        let countsOfBlocks = AppDelegate.Score.countsOfBlocks
        let playtimes = AppDelegate.Score.playtimes
        let maxHardnessesOfBricks = AppDelegate.Score.maxHardnessesOfBricks
        
        var pointResultArray = [PointResult]()
        
        for index in 0 ..< points.count {
            let loadedPointResult = PointResult(timestamp: timestamps[index],
                                                countOfBlocks: countsOfBlocks[index],
                                                playtime: playtimes[index],
                                                maxHardnessOfBricks: maxHardnessesOfBricks[index],
                                                points: points[index])
            pointResultArray.append(loadedPointResult)
        }
        return pointResultArray
    }
    
    
    //todo: in model?
    func storePointResultArray(array: [PointResult]) {
   //     DataHelper().fetchHighscores()
        var points:[Int] = [Int]()
        var timestamps:[Int64] = [Int64]()
        var countsOfBlocks:[Int] = [Int]()
        var playtimes:[Int64] = [Int64]()
        var maxHardnessesOfBricks:[Int] = [Int]()
        
        for index in 0 ..< array.count {
            points.append(array[index].points)
            timestamps.append(array[index].timestamp)
            countsOfBlocks.append(array[index].countOfBlocks)
            playtimes.append(array[index].playtime)
            maxHardnessesOfBricks.append(array[index].maxHardnessOfBricks)
        }
    //    DataHelper().saveHighscore(highscores: array)
        AppDelegate.Score.points = points
        AppDelegate.Score.timestamps = timestamps
        AppDelegate.Score.countsOfBlocks = countsOfBlocks
        AppDelegate.Score.playtimes = playtimes
        AppDelegate.Score.maxHardnessesOfBricks = maxHardnessesOfBricks
    }
    
    func endGame() {
        breakoutGame.pauseGame()
        let alert = UIAlertController(title: "Game Over", message: "you have lost", preferredStyle: UIAlertControllerStyle.alert)
        let newGameAction = UIAlertAction(title: "New Game", style: UIAlertActionStyle.cancel) {
            (action: UIAlertAction!) -> Void in
            self.startGame()
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
