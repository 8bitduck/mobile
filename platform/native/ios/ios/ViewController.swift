//
//  ViewController.swift
//  ios
//
//  Created by Allen Schober on 10/20/15.
//  Copyright © 2015 Lessig2016. All rights reserved.
//

import UIKit
import Parse
import Kingfisher

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    var itemCount = 0
    var actions: [Action]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        retrieveActionObjects()
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
//            NSLog("Object has been saved.")
//        }
    }
    
    // MARK:  UITextFieldDelegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemCount
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        let a = actions?[row]
        cell.textLabel?.text = a?.title
        cell.detailTextLabel?.text = a?.message
        if(a?["thumbnailUrl"] != nil) {
            cell.imageView?.kf_setImageWithURL(NSURL(string: a!.thumbnailUrl)!, placeholderImage: UIImage(named: "placeholderImage"))
        } else {
            cell.imageView?.image = UIImage(named: "placeholderImage")
        }

        return cell
    }
    
    // MARK:  UITableViewDelegate Methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print(row)
    }

    
    func retrieveActionObjects()
    {
        let query = Action.query()!
        query.addDescendingOrder("priority")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                self.itemCount = objects!.count
                self.actions = objects as? [Action]
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")

                // Do something with the found objects
                if let objects = objects as? [Action] {
                    for object in objects {

                        print(object.objectId)
                        print(object["message"])
                        print(object.recipients)
                    }
                }
            } else {
                self.itemCount = 0
                
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

