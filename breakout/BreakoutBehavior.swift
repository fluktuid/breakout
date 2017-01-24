//
//  BreakoutBehavior.swift
//  breakout
//
//  Created by Lukas Paluch on 16.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//


import UIKit

public enum BreakoutViewType: Int {
    case ball = 1
    case paddle
    case brick
    case boundary
}

public protocol BreakoutGameDelegate {
    func winGame() -> Void
    func endGame() -> Void
    func updateCurrentBadge() -> Void
    func removeBall() -> Void
    func getBallCount() -> Int
}

public extension UIView {
    var type: BreakoutViewType {
        get {
            return BreakoutViewType(rawValue: self.tag)!
        }
        set {
            self.tag = newValue.rawValue
        }
    }
}

class BreakoutGameBehavior: UIDynamicBehavior, UICollisionBehaviorDelegate {
    
    lazy private var gravity: UIGravityBehavior = {
        let gravity = UIGravityBehavior()
        gravity.magnitude = 0.15
        return gravity
    }()
    
    
    lazy private var collider: UICollisionBehavior = {
        let collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = false
        collider.collisionMode = UICollisionBehaviorMode.everything
        collider.collisionDelegate = self
        return collider
    }()
    
    lazy private var ballBehavior: UIDynamicItemBehavior = {
        let ballBehavior = UIDynamicItemBehavior()
        ballBehavior.allowsRotation = true
        ballBehavior.density = 1.0
        ballBehavior.elasticity = 4.0
        ballBehavior.friction = 0.0
        ballBehavior.angularResistance = 0.1
        return ballBehavior
    }()
    
    lazy private var paddleBehavior: UIDynamicItemBehavior = {
        let paddleBehavior = UIDynamicItemBehavior()
        
        //setzt die Einstellungen für alles
        paddleBehavior.allowsRotation = false
        paddleBehavior.charge = 0
        paddleBehavior.density = 2000.0
        paddleBehavior.elasticity = 1.0
        paddleBehavior.friction = 20.0
        paddleBehavior.resistance = 3000.0
        paddleBehavior.angularResistance = 0.0
        return paddleBehavior
    }()
    
    lazy private var brickBehavior: UIDynamicItemBehavior = {
        let brickBehavior = UIDynamicItemBehavior()
        
        //setzt die Einstellungen für alles
        brickBehavior.allowsRotation = false
        brickBehavior.density = 500.0
        brickBehavior.elasticity = 0.0
        brickBehavior.friction = 0.0
        brickBehavior.resistance = 30.0
        brickBehavior.angularResistance = 0.0
        return brickBehavior
    }()
    
    lazy private var paddleAttachment: UIAttachmentBehavior? = nil
    
    lazy private var brickAttachments: [UIView: UIAttachmentBehavior] = [:]
    
    var delegate: BreakoutGameDelegate? = nil
    
    override init() {
        super.init()
        addChildBehavior(collider)
        addChildBehavior(ballBehavior)
        addChildBehavior(paddleBehavior)
        addChildBehavior(brickBehavior)
        addChildBehavior(gravity)
    }
    
    func addView(_ view: UIView) {
        dynamicAnimator?.referenceView?.addSubview(view)
        collider.addItem(view)
        switch view.type {
        case .ball:
            dynamicAnimator?.referenceView?.addSubview(view)
            ballBehavior.addItem(view)
            gravity.addItem(view) // Schwerkraft, damit der Ball langsam nach unten kommt
            
        case .paddle:
            dynamicAnimator?.referenceView?.addSubview(view)
            paddleAttachment = UIAttachmentBehavior(item: view, attachedToAnchor: view.center)
            paddleAttachment!.frequency = 1.0
            paddleAttachment!.damping = 0.5
            addChildBehavior(paddleAttachment!)
            paddleBehavior.addItem(view)
        case .brick:
            brickAttachments[view] = UIAttachmentBehavior(item: view, attachedToAnchor: view.center)
            brickAttachments[view]!.frequency = 1.0
            brickAttachments[view]!.damping = 0.5
            addChildBehavior(brickAttachments[view]!)
            brickBehavior.addItem(view)
        default:
            return
        }
    }
    
    func createBoundary(_ view: UIView) {
        let topLeft = CGPoint(x: view.frame.minX, y: view.frame.minY)
        let topRight = CGPoint(x: view.frame.maxX, y: view.frame.minY)
        let bottomLeft = CGPoint(x: view.frame.minX, y: view.frame.maxY)
        let bottomRight = CGPoint(x: view.frame.maxX, y: view.frame.maxY)
        collider.addBoundary(withIdentifier: Constants.Boundary.Top as NSCopying, from: topLeft, to: topRight)
        collider.addBoundary(withIdentifier: Constants.Boundary.Bottom as NSCopying, from: bottomLeft, to: bottomRight)
        collider.addBoundary(withIdentifier: Constants.Boundary.Left as NSCopying, from: topLeft, to: bottomLeft)
        collider.addBoundary(withIdentifier: Constants.Boundary.Right as NSCopying, from: topRight, to: bottomRight)
    }
    
    func moveView(_ view: UIView, translation: CGPoint) {
        switch view.type {
        case .paddle:
            let breakoutView = dynamicAnimator?.referenceView!
            view.center.x += translation.x
            view.center.x = max(view.center.x, breakoutView!.frame.minX + view.frame.width / 2)
            view.center.x = min(view.center.x, breakoutView!.frame.maxX - view.frame.width / 2)
            paddleAttachment?.anchorPoint.x = view.center.x
            dynamicAnimator?.updateItem(usingCurrentState: view)
        default:
            return
        }
    }
    
    func pushView(_ view: UIView, angle: CGFloat, magnitude: CGFloat) {
        let viewPush = UIPushBehavior(items: [view], mode: UIPushBehaviorMode.instantaneous)
        viewPush.angle = angle
        viewPush.magnitude = magnitude
        viewPush.action = {
            viewPush.dynamicAnimator?.removeBehavior(viewPush)
        }
        dynamicAnimator?.addBehavior(viewPush)
    }
    func changeBrickColor(_ view: UIView, toColor: UIColor) {
        UIView.animate(withDuration: 0.1) {
            view.backgroundColor = toColor
        }
    }
    
    func removeView(_ view: UIView, animated: Bool = false) {
        
        if animated == true {
            UIView.animate(withDuration: 0.1, animations: {
                view.alpha = 1.0
                view.alpha = 0.5
                },
                           completion: { (finished: Bool) -> Void in
                            self.removeView(view, animated: false)
            })
            return
        }
        
        switch view.type {
        case .ball:
            ballBehavior.removeItem(view)
        case .paddle:
            if paddleAttachment != nil {
                paddleBehavior.removeItem(view)
                removeChildBehavior(paddleAttachment!)
                paddleAttachment = nil
            } else { return }
        case .brick:
            if brickAttachments[view] != nil {
                brickBehavior.removeItem(view)
                removeChildBehavior(brickAttachments[view]!)
                brickAttachments[view] = nil
            } else { return }
        default:
            return
        }
        collider.removeItem(view)
        view.removeFromSuperview()
    }
    
    
    fileprivate var pausedBallVelocity: CGPoint?
    
    func pauseGame() {
        if let ballView = ballBehavior.items.first as? UIView {
            gravity.removeItem(ballView)
            pausedBallVelocity = ballBehavior.linearVelocity(for: ballView)
            ballBehavior.addLinearVelocity(-pausedBallVelocity!, for: ballView)
        }
    }
    
    func resumeGame() {
        if let ballView = ballBehavior.items.first as? UIView {
            if pausedBallVelocity != nil {
                gravity.addItem(ballView)
                ballBehavior.addLinearVelocity(pausedBallVelocity!, for: ballView)
                pausedBallVelocity = nil
            }
        }
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        let (ballView, _, brickView) = collisionViewsForItems([item1, item2])
        if ballView != nil {
            ballBehavior.limitLinearVelocity(min: Constants.Ball.MinVelocity, max: Constants.Ball.MaxVelocity, forItem: ballView!)
        }
        if ballView != nil && brickView != nil {
            if brickAttachments.count == 1 {
                delegate?.winGame()
            }
            if brickView!.backgroundColor == Constants.Brick.HardestBackgroundColor {
                changeBrickColor(brickView!, toColor: Constants.Brick.HarderBackgroundColor)
                calculateBlocks(blocksHit: 1)
            } else if brickView!.backgroundColor == Constants.Brick.HarderBackgroundColor {
                changeBrickColor(brickView!,toColor: Constants.Brick.BackgroundColor)
                calculateBlocks(blocksHit: 1)
            } else {
                removeView(brickView!, animated: true)
                calculateBlocks(blocksHit: 1)
            }
            let points = calculatePoints()
            print("currentPoints: ", points)
        }
    }
    
    func calculatePoints() -> Int{
        let b = AppDelegate.Score.current.remainingBlocks+AppDelegate.Score.current.destroyedBlocks     //count of blocks destroyed
        let current = NSDate().timeIntervalSince1970
        let z = current - AppDelegate.Score.current.starttime //playtime
        let zInInt = Int(z)
        print(zInInt)
        let w = AppDelegate.Score.current.maxHardnessOfBlocks //max hardness
        let p = (b * w * 1000) / (zInInt + 30)
        
        
        AppDelegate.Score.current.points = Int(p)
        delegate?.updateCurrentBadge()
        return Int(p)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        let (ballView, paddleView, _) = collisionViewsForItems([item1, item2])
        if ballView != nil {
            ballBehavior.limitLinearVelocity(min: Constants.Ball.MinVelocity, max: Constants.Ball.MaxVelocity, forItem: ballView!)
        }
        if ballView != nil && paddleView != nil {
            ballBehavior.addLinearVelocity(CGPoint(x: 0.0, y: 10.0), for: ballView!)
            let radians = atan2f(Float(ballView!.transform.b), Float(ballView!.transform.a))
            let degrees = radians * Float((180 / M_PI))
            print(degrees)
        }
        calculatePoints()
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        let points = calculatePoints()
        var (ballView, _, _) = collisionViewsForItems([item])
        if ballView != nil {
            ballBehavior.limitLinearVelocity(min: Constants.Ball.MinVelocity, max: Constants.Ball.MaxVelocity, forItem: ballView!)
        }
        if let boundaryName = identifier as? String {
            switch boundaryName {
            case Constants.Boundary.Bottom:
                if ballView != nil {
                    delegate?.removeBall()
                    if(delegate?.getBallCount())! <= 0 {
                        delegate?.endGame()
                    }
 //                   ballView?.removeFromSuperview()
                }
            default:
                break
            }
        }
    }
    
    func calculateBlocks(blocksHit: Int) {
        AppDelegate.Score.current.remainingBlocks = AppDelegate.Score.current.remainingBlocks - blocksHit
        AppDelegate.Score.current.destroyedBlocks = AppDelegate.Score.current.destroyedBlocks + blocksHit
    }
    
    
    fileprivate func collisionViewsForItems(_ items: [UIDynamicItem]) -> (ballView: UIView?, paddleView: UIView?, brickView: UIView?) {
        var ballView: UIView? = nil
        var paddleView: UIView? = nil
        var brickView: UIView? = nil
        for item in items {
            if let view = item as? UIView {
                switch view.type {
                case .ball:
                    ballView = view
                case .paddle:
                    paddleView = view
                case .brick:
                    brickView = view
                default:
                    break
                }
            }
        }
        return (ballView, paddleView, brickView)
    }
}

private extension UIDynamicItemBehavior {
    func limitLinearVelocity(min: CGFloat, max: CGFloat, forItem item: UIDynamicItem) {
        assert(min < max, "min < max")
        let itemVelocity = linearVelocity(for: item)
        if itemVelocity.magnitude == 0.0 { return }
        if itemVelocity.magnitude < min {
            let deltaVelocity = min/itemVelocity.magnitude * itemVelocity - itemVelocity
            addLinearVelocity(deltaVelocity, for: item)
        }
        if itemVelocity.magnitude > max  {
            let deltaVelocity = max/itemVelocity.magnitude * itemVelocity - itemVelocity
            addLinearVelocity(deltaVelocity, for: item)
        }
    }
}

private extension CGPoint {
    var angle: CGFloat {
        get { return CGFloat(atan2(self.x, self.y)) }
    }
    var magnitude: CGFloat {
        get { return CGFloat(sqrt(self.x*self.x + self.y*self.y)) }
    }
}

prefix func - (left: CGPoint) -> CGPoint {
    return CGPoint(x: -left.x, y: -left.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (left: CGFloat, right: CGPoint) -> CGPoint {
    return CGPoint(x: left * right.x, y: left * right.y)
}
