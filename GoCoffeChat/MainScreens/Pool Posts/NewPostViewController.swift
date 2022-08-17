//
//  NewPostViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 07.08.2022.
//

import UIKit
import Firebase

class NewPostViewController: UIViewController, UITextViewDelegate {
    
    private var bgImage = UIImageView(image: UIImage(named: "backScreen"))
    
    private let inputTextView: UITextView = {
        let inputTextView = UITextView()
//        inputTextField.placeholder = "Enter text..."
        inputTextView.translatesAutoresizingMaskIntoConstraints = false
//        inputTextField.backgroundColor = .purple
        inputTextView.font = UIFont.systemFont(ofSize: 21.0, weight: .regular)
        inputTextView.backgroundColor = .darkGray
        inputTextView.layer.cornerRadius = 8
        inputTextView.layer.borderWidth = 2
        inputTextView.layer.borderColor = UIColor.white.cgColor
        inputTextView.textColor = .white
        
        return inputTextView
    }()
    
    
    @objc func handleSendButton() {
        
        let ref = Database.database().reference().child("posts")
        let childRef = ref.childByAutoId()
        
        let userId = Auth.auth().currentUser!.uid
        let timestamp = Int(Date().timeIntervalSince1970)
        
        let values = ["userId": userId, "text": inputTextView.text, "timestamp": timestamp] as [String : Any]
        childRef.updateChildValues(values)
        dismiss(animated: true)
    }
    
    func showAllert(){
        let alert = UIAlertController(title: "Ошибка", message: "Напишите текст поста", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgImage)
        let bgBlur = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: bgBlur)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        navigationController?.title = "New post"
        print("open screen new post")

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(hanleBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Опубликовать", style: .plain, target: self, action: #selector(handleSendButton))
        
        addSubviews()
        layoutViews()

    }
    
    func addSubviews(){ 
        view.addSubview(inputTextView)
        inputTextView.becomeFirstResponder()
    }
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            inputTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            inputTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            inputTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            inputTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),

        ])
    }

    
    @objc func hanleBack(){
        dismiss(animated: true)
    }
    
    


}
