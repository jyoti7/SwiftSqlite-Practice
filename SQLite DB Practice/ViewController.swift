//
//  ViewController.swift
//  SQLite DB Practice
//
//  Created by Md. Abdur Rahman Jyoti on 4/2/19.
//  Copyright © 2019 Md. Abdur Rahman Jyoti. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    var database: Connection!//Global DB
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            //we create a storage loc user database table, use file manager loc in the app
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            //Connection DB
            let database = try Connection(fileUrl.path)
            self.database = database //assign as Global DB
        }
        catch{
            print(error)
        }
        
    }

    @IBAction func createTable(_ sender: Any) {
        print("Create Table Tapped")
    }
    
    @IBAction func insertUser(_ sender: Any) {
         print("Insert user Tapped")
        
        /*For insert popup Alert with textField*/
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
    /*For update popup Alert with textField*/
    @IBAction func updateUser(_ sender: Any) {
        print("Update user Tapped")
        
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
    /*For delete popup Alert with textField*/
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
