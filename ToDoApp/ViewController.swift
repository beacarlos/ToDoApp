//
//  ViewController.swift
//  ToDoApp
//
//  Created by Beatriz Carlos on 14/04/20.
//  Copyright © 2020 Beatriz Carlos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todoItem = ToDoItem(title: "teste", completed: false, cretedAt: Date(), itemIdentifier: UUID())
        
        let todos = DataManager.loadAll(ToDoItem.self)
//        todoItem.saveItem()
        
        print(todos)
    }


}

