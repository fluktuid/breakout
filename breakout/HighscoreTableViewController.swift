//
//  HighscoreNavigationViewController.swift
//  breakout
//
//  Created by Lukas Paluch on 21.01.17.
//  Copyright © 2017 Lukas Paluch. All rights reserved.
//
//  deprecated, only needed to find an error working with the core data 
//  Sources:
//    -https://codingtutor.de/uitableview-uitableviewcontroller-swift/

import UIKit

class HighscoreTableViewController: UIViewController, UITableViewDataSource {

    private var highscore:[Score] = []

    let entries = ["iOS mit Swift", "Swift Tutorial", "Swift lernen"]


    @IBOutlet weak var settingsTableView: UITableView!


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return entries.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
    }



    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        /*
        let one = AppDelegate.Score.one.self
        let two = AppDelegate.Score.two.self
        let three = AppDelegate.Score.three.self
        let four = AppDelegate.Score.four.self
        let five = AppDelegate.Score.five.self
        let six = AppDelegate.Score.six.self
        let seven = AppDelegate.Score.seven.self
        let eight = AppDelegate.Score.eight.self
        let nine = AppDelegate.Score.nine.self
        let ten = AppDelegate.Score.ten.self
        */

        loadData()
    }

    //loads the highscoredata from the CoreData
    func loadData() {
        var p0 = AppDelegateOwn.Score.one.points
        var ts0 = AppDelegateOwn.Score.one.timestamp
        var t0 = AppDelegateOwn.Score.one.playtime
        var m0 = AppDelegateOwn.Score.one.maxBlockHardness
        var c0 = AppDelegateOwn.Score.one.countOfBlocks
        highscore.append(Score(points: p0, timestamp: ts0, playtime: t0, maxBlockHardness: m0, blockCount: c0))

        p0 = AppDelegateOwn.Score.two.points
        ts0 = AppDelegateOwn.Score.two.timestamp
        t0 = AppDelegateOwn.Score.two.playtime
        m0 = AppDelegateOwn.Score.two.maxBlockHardness
        c0 = AppDelegateOwn.Score.two.countOfBlocks
        highscore.append(Score(points: p0, timestamp: ts0, playtime: t0, maxBlockHardness: m0, blockCount: c0))

        p0 = AppDelegateOwn.Score.three.points
        ts0 = AppDelegateOwn.Score.three.timestamp
        t0 = AppDelegateOwn.Score.three.playtime
        m0 = AppDelegateOwn.Score.three.maxBlockHardness
        c0 = AppDelegateOwn.Score.three.countOfBlocks
        highscore.append(Score(points: p0, timestamp: ts0, playtime: t0, maxBlockHardness: m0, blockCount: c0))

        p0 = AppDelegateOwn.Score.four.points
        ts0 = AppDelegateOwn.Score.four.timestamp
        t0 = AppDelegateOwn.Score.four.playtime
        m0 = AppDelegateOwn.Score.four.maxBlockHardness
        c0 = AppDelegateOwn.Score.four.countOfBlocks
        highscore.append(Score(points: p0, timestamp: ts0, playtime: t0, maxBlockHardness: m0, blockCount: c0))

        p0 = AppDelegateOwn.Score.five.points
        ts0 = AppDelegateOwn.Score.five.timestamp
        t0 = AppDelegateOwn.Score.five.playtime
        m0 = AppDelegateOwn.Score.five.maxBlockHardness
        c0 = AppDelegateOwn.Score.five.countOfBlocks
        highscore.append(Score(points: p0, timestamp: ts0, playtime: t0, maxBlockHardness: m0, blockCount: c0))

        p0 = AppDelegateOwn.Score.six.points
        ts0 = AppDelegateOwn.Score.six.timestamp
        t0 = AppDelegateOwn.Score.six.playtime
        m0 = AppDelegateOwn.Score.six.maxBlockHardness
        c0 = AppDelegateOwn.Score.six.countOfBlocks
        highscore.append(Score(points: p0, timestamp: ts0, playtime: t0, maxBlockHardness: m0, blockCount: c0))

        p0 = AppDelegateOwn.Score.seven.points
        ts0 = AppDelegateOwn.Score.seven.timestamp
        t0 = AppDelegateOwn.Score.seven.playtime
        m0 = AppDelegateOwn.Score.seven.maxBlockHardness
        c0 = AppDelegateOwn.Score.seven.countOfBlocks
        highscore.append(Score(points: p0, timestamp: ts0, playtime: t0, maxBlockHardness: m0, blockCount: c0))

        p0 = AppDelegateOwn.Score.eight.points
        ts0 = AppDelegateOwn.Score.eight.timestamp
        t0 = AppDelegateOwn.Score.eight.playtime
        m0 = AppDelegateOwn.Score.eight.maxBlockHardness
        c0 = AppDelegateOwn.Score.eight.countOfBlocks
        highscore.append(Score(points: p0, timestamp: ts0, playtime: t0, maxBlockHardness: m0, blockCount: c0))

        p0 = AppDelegateOwn.Score.nine.points
        ts0 = AppDelegateOwn.Score.nine.timestamp
        t0 = AppDelegateOwn.Score.nine.playtime
        m0 = AppDelegateOwn.Score.nine.maxBlockHardness
        c0 = AppDelegateOwn.Score.nine.countOfBlocks
        highscore.append(Score(points: p0, timestamp: ts0, playtime: t0, maxBlockHardness: m0, blockCount: c0))

        p0 = AppDelegateOwn.Score.ten.points
        ts0 = AppDelegateOwn.Score.ten.timestamp
        t0 = AppDelegateOwn.Score.ten.playtime
        m0 = AppDelegateOwn.Score.ten.maxBlockHardness
        c0 = AppDelegateOwn.Score.ten.countOfBlocks
        highscore.append(Score(points: p0, timestamp: ts0, playtime: t0, maxBlockHardness: m0, blockCount: c0))
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "myTableCell", for: indexPath as IndexPath) as! UITableViewCell
        cell.textLabel?.text = entries[indexPath.row]

        return cell
    }
}
