//
//  ChatViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 24.07.2022.
//

import UIKit
import Firebase

class PoolChatsViewController: UITableViewController {

    let cellId = "Cell"
    
    private var chats = [Message]()
    
    private let newMessageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(UIImage(named:"new_message_icon.png"), for: .normal)
        button.addTarget(self, action: #selector(handleNewMessage), for: .touchUpInside)
        
        return button
    }()
    private let newMessageButtonSize: CGFloat = 50
    
    @objc func handleLogout(){
    }
    
    @objc func handleNewMessage(){
        let newChatController = NewChatViewController()
        newChatController.poolChats = self
        let vc = UINavigationController(rootViewController: newChatController)
//        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        addSubviews()
        layoutViews()
        observeMessage()
    }
    
    func observeMessage() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let message = Message(dictionary: dictionary)
//                user.id = snapshot.key

                self.chats.append(message)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
    }

    
    func addSubviews(){
        view.addSubview(newMessageButton)
    }
    
    func layoutViews() {
        newMessageButton.layer.cornerRadius = newMessageButtonSize/2
        
        NSLayoutConstraint.activate([
            newMessageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            newMessageButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newMessageButton.heightAnchor.constraint(equalToConstant: newMessageButtonSize),
            newMessageButton.widthAnchor.constraint(equalToConstant: newMessageButtonSize)
 
        ])
    }
    
    func showChat(user: User){
        print("show chat")
        
        let chatController = ChatViewController()
        chatController.user = user
        let vc = UINavigationController(rootViewController: chatController)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
            
        let message = chats[indexPath.row]
        cell.textLabel?.text = message.toId
        cell.message = message
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = chats[indexPath.row]
        
        guard let chatPartnerId = message.chatPartnerId() else { return }
        
        let ref = Database.database().reference().child("users").child(chatPartnerId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(dictionary: dictionary)
            user.id = chatPartnerId
            self.showChatControllerForUser(user)
            
        }, withCancel: nil)
        
    }
    
    func showChatControllerForUser(_ user: User) {
        let vc = ChatViewController()
        vc.user = user
        let chatController = UINavigationController(rootViewController: vc)
        chatController.modalPresentationStyle = .fullScreen
        present(chatController, animated: true, completion: nil)
    }


}
