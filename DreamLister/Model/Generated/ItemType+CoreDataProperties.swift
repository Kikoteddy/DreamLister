//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Kristijan Ivanov on 11/21/17.
//  Copyright © 2017 Kristijan Ivanov. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
