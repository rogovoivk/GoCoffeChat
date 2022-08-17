//
//  ChatViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 25.07.2022.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITextFieldDelegate {
    
    public var user: User? {
        didSet{
            navigationItem.title = user?.nickname
        }
    }
    
    private let containerView: UIView = {
        let conteinerView = UIView()
        conteinerView.backgroundColor = .init(red: 0.1568, green: 0.3137, blue: 0.8784, alpha: 0.65)
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        return conteinerView
    }()
    
    private let sendButton = UIButton(type: .system)
    private let inputTextField = UITextField()
    private let separatorLineView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.title = "Chat"
        print("open screen chat")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(hanleBack))
        
        addSubviews()
        layoutViews()

    }
    
    func addSubviews(){
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(pressSendButton), for: .touchUpInside)
        
        inputTextField.placeholder = "Enter message..."
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.delegate = self
        
        separatorLineView.backgroundColor = .black
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        containerView.addSubview(sendButton)
        containerView.addSubview(inputTextField)
        containerView.addSubview(separatorLineView)
    }
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            
            sendButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            sendButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            sendButton.widthAnchor.constraint(equalToConstant: 80),
            sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            
            inputTextField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            inputTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            inputTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: 0),
            inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            
            separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
//            separatorLineView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            separatorLineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0),
            separatorLineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            separatorLineView.heightAnchor.constraint(equalToConstant: 1),

        ])
    }
    
    @objc func pressSendButton(){
        let ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let toId = user!.id!
        let fromId = Auth.auth().currentUser!.uid
        let timestamp = Int(Date().timeIntervalSince1970)
        let values = ["text": inputTextField.text!, "toId": toId, "fromId": fromId, "timestamp": timestamp] as [String : Any]
            
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
                
            self.inputTextField.text = nil

            let userMessageRef = Database.database().reference().child("user-messages").child(fromId)

            let messageId = childRef.key
            userMessageRef.updateChildValues([messageId: 1])

            let recipientUserMessagesRef = Database.database().reference().child("user-messages").child(toId)
            recipientUserMessagesRef.updateChildValues([messageId: 1])
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pressSendButton()
        return true
    }
    
    @objc func hanleBack(){
        dismiss(animated: true)
    }
    
    


}
