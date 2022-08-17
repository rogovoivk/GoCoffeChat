//
//  MessageViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 24.07.2022.
//

import UIKit
import Firebase

class NewChatViewController: UITableViewController {

    let cellId = "Cell"
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Новый чат"
        
        self.tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
              
        fetchUser()
        
        
    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = User(dictionary: dictionary)
                user.id = snapshot.key

                self.users.append(user)

                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })

            }
            
        }, withCancel: nil)
        
    }
    
    
    @objc func hanleBack(){
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("users cout \(users.count)")
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId)
        let user = users[indexPath.row]
        cell?.textLabel?.text = user.nickname
        cell?.detailTextLabel?.text = user.email
        
        return cell!
    }
    
    var poolChats: PoolChatsViewController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("sth selected")
        dismiss(animated: true) {
            print("sth selected and dismiss")
            
            let user = self.users[indexPath.row]
            self.poolChats?.showChat(user: user)
        }

    }
    
    
}


