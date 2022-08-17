//
//  PoolPostsViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 22.07.2022.
//

import UIKit
import Firebase

class PostsPoolViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    private var bgImage = UIImageView(image: UIImage(named: "backScreen"))
    
    let cellId = "PostCell"
    private var posts = [Post]()
    
    private let newPostButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(UIImage(named:"new_message_icon.png"), for: .normal)
        button.addTarget(self, action: #selector(handleNewPost), for: .touchUpInside)
        
        return button
    }()
    private let newPostButtonSize: CGFloat = 50
    
    @objc func handleNewPost(){
        
        let newPostController = NewPostViewController()
//        newChatController.poolChats = self
        let vc = UINavigationController(rootViewController: newPostController)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgImage)
        let bgBlur = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: bgBlur)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        navigationController?.title = "Posts Pool"
        print("open screen Posts Pool")
        
        addSubviews()
        layoutViews()
        observePosts()

    }
    
    func addSubviews(){
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(PostCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        
        view.addSubview(tableView)
        view.addSubview(newPostButton)
    }
    
    func layoutViews() {
        newPostButton.layer.cornerRadius = newPostButtonSize/2
        
        NSLayoutConstraint.activate([
            newPostButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            newPostButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newPostButton.heightAnchor.constraint(equalToConstant: newPostButtonSize),
            newPostButton.widthAnchor.constraint(equalToConstant: newPostButtonSize),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            

        ])
    }
    
    func observePosts() {
        let ref = Database.database().reference().child("posts")
        ref.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let post = Post(dictionary: dictionary)
//                user.id = snapshot.key

                self.posts.append(post)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }, withCancel: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection \(posts.count)")
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.post = post
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let stringSizeAsText: CGSize = getStringSizeForFont(font: UIFont.systemFont(ofSize: 21), myText: posts[indexPath.row].text!)
        let labelWidth: CGFloat = tableView.bounds.width //UIScreen.main.bounds.width
        let originalLabelHeight: CGFloat = 0 //20.5

        let labelLines: CGFloat = CGFloat(ceil(Float(stringSizeAsText.width/labelWidth)))

        let height =  tableView.rowHeight - originalLabelHeight + CGFloat(labelLines*stringSizeAsText.height) + 115

        return height
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.width - 20)
    }
    
    
    
    func getStringSizeForFont(font: UIFont, myText: String) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (myText as NSString).size(withAttributes: fontAttributes)

        return size

    }


}

