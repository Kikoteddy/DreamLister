//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Kristijan Ivanov on 11/22/17.
//  Copyright © 2017 Kristijan Ivanov. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var PriceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var thumgImg: UIImageView!
    @IBOutlet weak var itemType: CustomTextField!
    
    
    var stores = [Store]()
    var types = [ItemType]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let store = Store(context: context)
        store.name = "Best Buy"
        let store2 = Store(context: context)
        store2.name = "Tesla Dealership"
        let store3 = Store(context: context)
        store3.name = "Frys Electornics"
        let store4 = Store(context: context)
        store4.name = "Target"
        let store5 = Store(context: context)
        store5.name = "Amazon"
        let store6 = Store(context: context)
        store6.name = "Kmart"

        

        let type = ItemType(context: context)
        type.type = "Electronics"
        let type1 = ItemType(context: context)
        type1.type = "Cars"
        let type2 = ItemType(context: context)
        type2.type = "Fashion"
        let type3 = ItemType(context: context)
        type3.type = "Home appliances"
        let type4 = ItemType(context: context)
        type4.type = "Food"
        ad.saveContext()
        getTypes()
        
        
        getStores()
        
        if itemToEdit != nil {
            
            loadItemData()
        }
    }
    
    //MARK: Actions
    
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return stores[row].name
        } else {
            return types[row].type
        }
        
       
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        
        if component == 0 {
            return stores.count
        } else {
            return types.count
        }
        
    }
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 1 {
        itemType.text = types[row].type
        
        }
    }
    
    func getTypes() {
        
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        
        do {
            self.types = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    func getStores() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
            
        } catch {
            
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: Item!
        let picture = Image(context: context)
        let itemTypes = ItemType(context: context)
        itemTypes.type = itemType.text
        picture.image = thumgImg.image
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            
            item.title = title
        }
        
        if let price = PriceField.text {
            
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text {
            
            item.details = details
        }
        
        if let itemType = itemType.text {
            
            item.toItemType?.type = itemType
            
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        item.toItemType = types[storePicker.selectedRow(inComponent: 1)]
        ad.saveContext()
        
       _ = navigationController?.popViewController(animated: true)
    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            
            titleField.text = item.title
            PriceField.text = "\(item.price)"
            detailsField.text = item.details
            itemType.text = item.toItemType?.type
            thumgImg.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                
                var index = 0
                
                repeat {
                    
                    let s = stores[index]
                    
                    if s.name == store.name {
                        
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                } while (index < stores.count)
            }
            
            if let type = item.toItemType?.type {
                
                var index = 0
                
                repeat {
                    let t = types[index]
                    
                    if t.type == type {
                        storePicker.selectRow(index, inComponent: 1, animated: false)
                    }
                    index += 1
                } while (index < types.count)
                
            }
            
        }
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addImg(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        if let img = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            
            thumgImg.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
