//
//  ItemCell.swift
//  DreamLister
//
//  Created by Kristijan Ivanov on 11/21/17.
//  Copyright © 2017 Kristijan Ivanov. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var itemType: UILabel!
    
    
    func configureCell(item: Item) {
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
        thumb.image = item.toImage?.image as? UIImage
        itemType.text = item.toItemType?.type
        
    }
    
    

}
