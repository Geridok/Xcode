//
//  Task+CoreDataProperties.swift
//  Module14TaskManager
//
//  Created by Vladimir Mustafin on 25.05.2021.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var taskDescriprtion: String
    @NSManaged public var selfIndex: Int64
    @NSManaged public var date: Date

}

extension Task : Identifiable {

}
