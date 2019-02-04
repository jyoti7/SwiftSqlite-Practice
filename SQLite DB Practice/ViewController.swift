//
//  ViewController.swift
//  SQLite DB Practice
//
//  Created by Md. Abdur Rahman Jyoti on 4/2/19.
//  Copyright © 2019 Md. Abdur Rahman Jyoti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func createTable(_ sender: Any) {
        print("Create Table Tapped")
    }
    
    @IBAction func insertUser(_ sender: Any) {
         print("Insert user Tapped")
        
        /*For popup Alert with textField*/
        let alert = UIAlertController(title: "Insert User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Insert Name"}
        alert.addTextField { (tf) in tf.placeholder = "Insert E-mail"}
        let action = UIAlertAction (title: "SUBMIT", style: .default) {(_) in
            guard let name = alert.textFields?.first?.text,
                let email = alert.textFields?.last?.text
                else {return}
            print(name)
            print(email)
           
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
       
    }
    
    
    @IBAction func listUsers(_ sender: Any) {
        print("List users Tapped")
    }
    
    @IBAction func updateUser(_ sender: Any) {
        print("Update user Tapped")
        /*For popup Alert with textField*/
        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Insert Name"}
        alert.addTextField { (tf) in tf.placeholder = "Insert E-mail"}
        let action = UIAlertAction (title: "SUBMIT", style: .default) {(_) in
            guard let userIdString = alert.textFields?.first?.text,
                let email = alert.textFields?.last?.text
                else {return}
            print(userIdString)
            print(email)
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func deleteUser(_ sender: Any) {
        print("Delete user Tapped")
        
        let alert = UIAlertController(title: "Delete User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "User ID"}
        let action = UIAlertAction (title: "SUBMIT", style: .default) {(_) in
        guard let userIdString = alert.textFields?.first?.text
            else {return}
        print(userIdString)
    }
    
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
}

}
