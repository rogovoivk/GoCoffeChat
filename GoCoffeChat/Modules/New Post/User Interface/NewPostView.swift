//
//  NewPostView.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 13.09.2022.
//

import UIKit

class NewPostView: UIView {
    
    var screenView: UIView?
    var newPostViewController: NewPostViewController?
    
    private var bgImage = UIImageView(image: UIImage(named: "backScreen"))
    
    public let inputTextView: UITextView = {
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
        newPostViewController?.handleSendButton()
    }
    
    func setView() {
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        screenView!.addSubview(bgImage)
        let bgBlur = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: bgBlur)
        blurEffectView.frame = screenView!.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        screenView!.addSubview(blurEffectView)
        
        newPostViewController?.navigationController?.title = "New post"
//        print("open screen new post")

        newPostViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(self.handleBack))
        newPostViewController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Опубликовать", style: .plain, target: self, action: #selector(handleSendButton))
        
        addSubviews()
        layoutViews()

    }

    func addSubviews(){
        screenView!.addSubview(inputTextView)
        inputTextView.becomeFirstResponder()
    }
    
    @objc func handleBack(){
        newPostViewController?.handleBack()
    }
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            inputTextView.topAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.topAnchor, constant: 50),
            inputTextView.bottomAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            inputTextView.leadingAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            inputTextView.trailingAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.trailingAnchor, constant: -25),

        ])
    }
}
