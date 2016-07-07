//
//  TodoItemViewController.swift
//  実習
//
//  Created by 渡辺寛太 on 2016/07/07.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

class TodoItemViewController: UIViewController {
    
    @IBOutlet weak var todoField: UITextField!
    var task: Todo? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let taskTodo = task {
            todoField.text = taskTodo.item
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancel(sender: UIBarButtonItem) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        if task != nil {
            editTask()
        } else {
            createTask()
        }
        navigationController!.popViewControllerAnimated(true)
    }
    
    func createTask() {
        let newTask: Todo = Todo.MR_createEntity()! as Todo
        newTask.item = todoField.text
        newTask.managedObjectContext!.MR_saveToPersistentStoreAndWait()
    }
    
    func editTask() {
        task?.item = todoField.text
        task?.managedObjectContext!.MR_saveToPersistentStoreAndWait()
    }

    

}
