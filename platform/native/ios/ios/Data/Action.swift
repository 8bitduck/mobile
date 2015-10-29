//
//  Action.swift
//  ios
//
//  Created by Bryan Rehbein on 10/27/15.
//  Copyright © 2015 Lessig2016. All rights reserved.
//

import Foundation
import Parse

class Action: PFObject, PFSubclassing
{
    @NSManaged var title: String
    @NSManaged var message: String
    @NSManaged var actionType: String
    @NSManaged var ref: String
    @NSManaged var subject: String
    @NSManaged var body: String
    @NSManaged var recipients: [String]
    @NSManaged var thumbnailUrl: String
    @NSManaged var imageUrl: String
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Action"
    }
}