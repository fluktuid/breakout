//
//  ViewController.swift
//  breakout
//
//  Created by Lukas Paluch on 12.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//

import UIKit

class BreakoutViewController: UIViewController {
    
    private let brickBrain: BrickBrain = BrickBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        brickBrain.setGame()
        label!.text = String(brickBrain.getBricksArray().count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var gameView: BreakoutView! {
        didSet {
            gameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setGame(recognizer:))))
        }
    }
    
    func setGame(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended {
            if !brickBrain.getGameRunning() {
                gameView.initializeBricks(bricksArray: brickBrain.getBricksArray())
                brickBrain.setGameRunning(running: true)
                let paddle = gameView.initializePaddle()
                paddle.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(movePaddle(recognizer:))))
                gameView.initializeBall()
            }
        }
    }
    
    func movePaddle(recognizer: UIPanGestureRecognizer) {
        if(recognizer.state == .began || recognizer.state == .changed) {
            let translation = recognizer.translation(in: self.view)
            recognizer.view!.center = CGPoint(x:recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y)
            recognizer.setTranslation(CGPoint.zero,in: self.view)
        }
    }
}

