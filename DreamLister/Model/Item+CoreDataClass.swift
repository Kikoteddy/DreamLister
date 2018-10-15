//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Kristijan Ivanov on 11/21/17.
//  Copyright © 2017 Kristijan Ivanov. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
