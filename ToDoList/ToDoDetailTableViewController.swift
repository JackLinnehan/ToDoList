//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by John Linnehan on 9/27/21.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var noteView: UITextView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    }
