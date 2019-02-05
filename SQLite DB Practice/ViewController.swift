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
    
    let user_Table = Table("users") //initialize table
    let id = Expression<Int>("id") //create column
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    
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
        
        let createTable = self.user_Table.create { (table) in
            table.column(self.id, primaryKey:true)
            table.column(self.name)
            table.column(self.email, unique:true)
         
        }
        do{
           try self.database.run(createTable)
            print("create Table")
        }catch{
            print(error)
        }
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

            //catched value passing to database table
            let insertUser = self.user_Table.insert(self.name <- name, self.email <- email)
            
            do{
                try self.database.run(insertUser)
                print("INSERTED USER")
            }catch{
                
                print(error)
            }
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    
    @IBAction func listUsers(_ sender: Any) {
        print("List users Tapped")

        do{
            let users = try self.database.prepare(self.user_Table) // database column data show
           // print(users)
            for user in users {
                print("userId: \(user[self.id]), userName: \(user[self.name]), userEmail: \(user[self.email])")
            }

        }catch{
            print(error)
        }
        
    }
    
    
        
        /*For update popup Alert with textField*/
    @IBAction func updateUser(_ sender: Any) {
        print("Update user Tapped")
        
        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "User ID"}
        alert.addTextField { (tf) in tf.placeholder = "E-mail"}
        let action = UIAlertAction (title: "SUBMIT", style: .default) {(_) in
            guard let userIdString = alert.textFields?.first?.text,
                let userId = Int(userIdString),
                let email = alert.textFields?.last?.text
                else {return}
            print(userIdString)
            print(email)
           
            let user = self.user_Table.filter(self.id == userId)
            let updateUser = user.update(self.email <- email)
            do{
                try self.database.run(updateUser)
                print("UPDATED USER")
            }catch{
                
                print(error)
            }
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
        guard let userIdString = alert.textFields?.first?.text,
            let userId = Int(userIdString)
            else {return}
        print(userIdString)
            
            let user = self.user_Table.filter(self.id == userId)
            let deleteUser = user.delete()
            
            do{
                try self.database.run(deleteUser)
            }catch{
                print(error)
            }
        
    }
    
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
}


