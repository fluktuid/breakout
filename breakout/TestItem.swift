//
//  TestItem.swift
//  breakout
//
//  Created by Lukas Paluch on 23.01.17.
//  Copyright © 2017 Lukas Paluch. All rights reserved.
//

import Foundation
import CoreData


class LogItem : NSManagedObject {
    @NSManaged var title: String
    @NSManaged var itemText: String
}
