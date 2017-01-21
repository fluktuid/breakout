//
//  ViewController.swift
//  breakout
//
//  Created by Lukas Paluch on 21.01.17.
//  Copyright © 2017 Lukas Paluch. All rights reserved.
//

import UIKit

class HighscoreViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return 3
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
        cell.textLabel?.text = "Section \(indexPath.section), Row \(indexPath.row): foo"
        
        
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
