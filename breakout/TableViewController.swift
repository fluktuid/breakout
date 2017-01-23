//
//  TableViewController.swift
//  breakout
//
//  Created by Lukas Paluch on 17.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//

import UIKit
import CoreData

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var brickRowsStepper: UIStepper!
    @IBOutlet weak var brickRowsStepperLabel: UILabel!
    @IBOutlet weak var brickColumnsStepper: UIStepper!
    @IBOutlet weak var brickColumnsStepperLabel: UILabel!
    
    @IBOutlet weak var ballCountStepper: UIStepper!
    @IBOutlet weak var ballCountStepperLabel: UILabel!
    
    @IBOutlet weak var ballSizeStepper: UIStepper!
    @IBOutlet weak var ballSizeStepperLabel: UILabel!
    
    
    @IBOutlet weak var makeHarderBricksSwitch: UISwitch!
    @IBOutlet weak var gameContinueAfterGameOverSwitch: UISwitch!
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    var test: [NSManagedObject] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Test")
        print(test)
        do {
            test = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        print(test.count)
        print(test[0].value(forKey: "title"))
        
        
        
        
        
        
        
        brickRowsStepper.value = Double(AppDelegate.Settings.Brick.Rows)
        brickRowsStepperLabel.text = "\(AppDelegate.Settings.Brick.Rows)"
        brickColumnsStepper.value = Double(AppDelegate.Settings.Brick.Columns)
        brickColumnsStepperLabel.text = "\(AppDelegate.Settings.Brick.Columns)"
        ballCountStepper.value = Double(AppDelegate.Settings.Brick.Rows)
        ballCountStepperLabel.text = "\(AppDelegate.Settings.Brick.Rows)"
        ballSizeStepper.value = Double(AppDelegate.Settings.Brick.Columns)
        ballSizeStepperLabel.text = "\(AppDelegate.Settings.Brick.Columns)"
        
        gameContinueAfterGameOverSwitch.isOn = AppDelegate.Settings.Game.ContinueAfterGameOver
        makeHarderBricksSwitch.isOn = AppDelegate.Settings.Brick.HarderBricks
    }
    
    // MARK: - Settings value change handling
    @IBAction func brickRowsValueChanged(_ sender: UIStepper) {
        let numRows = Int(sender.value)
        brickRowsStepperLabel.text = "\(numRows)";
        AppDelegate.Settings.Brick.Rows = numRows;
    }
    
    @IBAction func brickColumnsValueChanged(_ sender: UIStepper) {
        let numColumns = Int(sender.value)
        brickColumnsStepperLabel.text = "\(numColumns)";
        AppDelegate.Settings.Brick.Columns = numColumns;
    }
    
    @IBAction func ballCountValueChanged(_ sender: UIStepper) {
        let balls = Int(sender.value)
        ballCountStepperLabel.text = "\(balls)"
        AppDelegate.Settings.Ball.CountOfBalls = balls
    }
    
    @IBAction func ballSizeValueChanged(_ sender: UIStepper) {
        let size = Int(sender.value)
        ballSizeStepperLabel.text = "\(size)"
        AppDelegate.Settings.Ball.Size = CGFloat(10 + size * 5)
    }
    @IBAction func generateHarderBricks(_ sender: UISwitch) {
        AppDelegate.Settings.Brick.HarderBricks = sender.isOn
    }
    
    @IBAction func gameContinueAfterGameOverValueChanged(_ sender: UISwitch) {
        AppDelegate.Settings.Game.ContinueAfterGameOver = sender.isOn
    }
    
}
