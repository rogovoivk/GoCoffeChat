//
//  NewPostViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 07.08.2022.
//

import UIKit
import Firebase

class NewPostViewController: UIViewController, UITextViewDelegate {
    
    var interactor: NewPostInteractor?
    var newPostView = NewPostView()
    
    
    @objc func handleSendButton() {
        interactor?.sendPost(textPost: newPostView.inputTextView.text)
        dismiss(animated: true)
    }
    
    func showAllert(){
        let alert = UIAlertController(title: "Ошибка", message: "Напишите текст поста", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newPostView.screenView = self.view
        newPostView.newPostViewController = self
        newPostView.setView()
    }
    


    
    @objc func handleBack(){
        dismiss(animated: true)
    }
    
    


}
