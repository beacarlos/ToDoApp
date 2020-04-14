//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Beatriz Carlos on 14/04/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import Foundation

struct ToDoItem: Codable {
    var title:String
    var completed:Bool
    var cretedAt:Date
    var itemIdentifier:UUID
    
    func saveItem () {
        DataManager.save(self, with: itemIdentifier.uuidString)
    }
    
    func deleteItem() {
        DataManager.delete(itemIdentifier.uuidString)
    }
    
    mutating func markAsCompleted() {
        self.completed = true
        DataManager.save(self, with: itemIdentifier.uuidString)
    }
}
