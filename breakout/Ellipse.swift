//
//  Paddle.swift
//  breakout
//
//  Created by Lukas Paluch on 24.01.17.
//  Copyright © 2017 Lukas Paluch. All rights reserved.
//

import UIKit

class Ellipse: UIView {
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .ellipse
    }
}
