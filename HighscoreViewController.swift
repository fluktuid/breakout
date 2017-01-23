//
//  ViewController.swift
//  breakout
//
//  Created by Lukas Paluch on 21.01.17.
//  Copyright © 2017 Lukas Paluch. All rights reserved.
//

import UIKit
import CoreData

class HighscoreViewController: UITableViewController {
    
    var highscore: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Highscore")
        let sortDescriptor = NSSortDescriptor(key: "points", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.returnsObjectsAsFaults = false
        
        print(highscore)
        do {
            highscore = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        print(highscore.count)
        if highscore.count>0 {
            print(highscore[0].value(forKey: "countOfBlocks"))
            print(highscore[0].value(forKey: "maxHardnessOfBricks"))
            print(highscore[0].value(forKey: "playtime"))
            print(highscore[0].value(forKey: "points"))
            print(highscore[0].value(forKey: "timestamp"))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Anzahl der Abschnitte (kann entfallen wenn nur ein Tabellenabschnitt benötigt wird)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    // Anzahl der Zeilen für einen bestimmten Abschnitt
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // Optional: Überschriften für die Tabellenabschnitte
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "#1"
        case 1:
            return "#2"
        case 2:
            return "#3"
        case 3:
            return "#4"
        case 4:
            return "#5"
        case 5:
            return "#6"
        case 6:
            return "#7"
        case 7:
            return "#8"
        case 8:
            return "#9"
        case 9:
            return "#10"
        default:
            return "##"
        }
    }
    
    // Tabellenzellen als UITableViewCell-Objekte erzeugen
    // Dafür wird der Abschnitts- und Zeilenindex in einem IndexPath-Objekt übergeben.
    // Mit dequeueReusableCell werden Zellen gemäß der im Storyboard definierten Prototypen erzeugt.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"ScoreCell", for: indexPath)
        
        
        if highscore.count>indexPath.row {
            let score = highscore[indexPath.row]
            
            
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Timestamp"
                cell.detailTextLabel?.text = "\(score.value(forKey: "timestamp"))"
            case 1:
                cell.textLabel?.text = "Count of Blocks"
                cell.detailTextLabel?.text = "\(score.value(forKey: "countOfBlocks"))"
                case 2:
                cell.textLabel?.text = "Duration"
                cell.detailTextLabel?.text = "\(score.value(forKey: "playtime"))"
            case 3:
                cell.textLabel?.text = "Max Hardness of blocks"
                cell.detailTextLabel?.text = "\(score.value(forKey: "maxHardnessOfBricks"))"
            case 4:
                cell.textLabel?.text = "Points"
                cell.detailTextLabel?.text = "\(score.value(forKey: "points"))"
            default:
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
            }
        } else {
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
