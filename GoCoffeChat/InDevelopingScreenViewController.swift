//
//  InDevelopingScreenViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 17.08.2022.
//

import UIKit

class InDevelopingScreenViewController: UIViewController {
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "В разработке :("
        textView.textAlignment = .center
        
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            textView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

}
