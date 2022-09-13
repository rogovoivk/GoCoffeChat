//
//  PoolPostsView.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 12.09.2022.
//

import UIKit

class PoolPostsView: UIView, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var screenView: UIView?
    var postsPoolViewController: PostsPoolViewController?
    
    private var bgImage = UIImageView(image: UIImage(named: "backScreen"))
    
    let cellId = "PostCell"
    public var posts = [Post]()
    
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
//        navigation?.presentNewPostViewControllerInWindow()
    }
    
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    func setView() {
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        screenView!.addSubview(bgImage)
        let bgBlur = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: bgBlur)
        blurEffectView.frame = screenView!.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        screenView!.addSubview(blurEffectView)
        
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
        
        
        screenView!.addSubview(tableView)
        screenView!.addSubview(newPostButton)
    }
    
    func layoutViews() {
        newPostButton.layer.cornerRadius = newPostButtonSize/2
        
        NSLayoutConstraint.activate([
            newPostButton.bottomAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            newPostButton.trailingAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            newPostButton.heightAnchor.constraint(equalToConstant: newPostButtonSize),
            newPostButton.widthAnchor.constraint(equalToConstant: newPostButtonSize),
            
            tableView.topAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: screenView!.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: screenView!.trailingAnchor, constant: -10),
            

        ])
    }
    
    func observePosts() {
        postsPoolViewController?.interactor.observePosts()
        
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
