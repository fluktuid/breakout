//
//  Ball.swift
//  breakout
//
//  Created by Lukas Paluch on 16.12.16.
//  Copyright © 2016 Lukas Paluch. All rights reserved.
//
//  deprecated see Ellipse.swift
//  Sources:
//    -http://stackoverflow.com/questions/36821110/cornerradius-exactly-uiview, Answer from 'Sergio'
//

import UIKit

class Ball: UIImageView {
    // used for restoring game state
    var linearVelocity: CGPoint?

    // iOS 9 specific
    //Idea:see sources
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = frame.width / 2.0
        backgroundColor = UIColor(red: 243/255.0, green: 41/255.0, blue: 56/255.0, alpha: 1.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
