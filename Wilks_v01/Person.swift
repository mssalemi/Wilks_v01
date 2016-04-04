//
//  Person.swift
//  Wilks_v01
//
//  Created by Mehdi Salemi on 2016-04-04.
//  Copyright © 2016 MxMd. All rights reserved.
//

import CoreData
import Foundation

class Person: NSManagedObject {
    
    @NSManaged var name : String!
    @NSManaged var gender : String!
    @NSManaged var imagePath : String!
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary:[String:AnyObject], context:NSManagedObjectContext){
        let entity =  NSEntityDescription.entityForName("Person", inManagedObjectContext: context)!
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        self.name = dictionary["name"] as! String
        self.gender = dictionary["gender"] as! String
        self.imagePath = dictionary["imagePath"] as! String
    }
    
}