//
//  TableViewController.swift
//  Wilks_v01
//
//  Created by Mehdi Salemi on 2016-04-04.
//  Copyright © 2016 MxMd. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class TableViewController : UITableViewController {
    
    var people = [Person]()
    
    var addNewPersonButton : UIBarButtonItem?
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewPersonButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewPerson:")
    }

    func fetchAllPeople() -> [Person] {
        
        // Create the Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        // Execute the Fetch Request
        do {
            return try sharedContext.executeFetchRequest(fetchRequest) as! [Person]
        } catch  let error as NSError {
            print("Error in fetchAllActors(): \(error)")
            return [Person]()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.rightBarButtonItem = addNewPersonButton
        people = fetchAllPeople()
        print(people)
        tableView.reloadData()
    }
    
    @IBAction func addNewPerson(sender:AnyObject){
        print("Adding New Person")
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("NewPersonViewController") as! NewPersonViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    //Mark : Table View Functions
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let person = people[indexPath.row]
        //TODO: Set cell's attributes
        cell.textLabel?.text = person.name
        
        return cell
    }
    
}


