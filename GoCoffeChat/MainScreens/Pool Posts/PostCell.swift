//
//  PostCell.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 12.08.2022.
//

import UIKit
import Firebase


class PostCell: UITableViewCell {

    var post: Post? {
        didSet {
            if let seconds = post?.timestamp?.doubleValue {
                let timestampDate = Date(timeIntervalSince1970: seconds)

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                timeLabel.text = dateFormatter.string(from: timestampDate)
                textView.text = post?.text
                fetchUserAndSetupProfileData()
            }
        }
    }
    
    func fetchUserAndSetupProfileData() {
        
        guard let postUserId = post?.userId! else { return }
        Database.database().reference().child("users").child(postUserId).observeSingleEvent(of: .value, with: { (snapshot) in

            if let dictionary = snapshot.value as? [String: AnyObject] {

                let user = User(dictionary: dictionary)
                self.nicknameText.text = user.nickname
            }

        }, withCancel: nil)
    }

    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let nicknameText: UITextView = {
        let nickText = UITextView()
        nickText.translatesAutoresizingMaskIntoConstraints = false
        nickText.font = UIFont.systemFont(ofSize: 21)
        nickText.textColor = .white
        nickText.backgroundColor = .clear
        nickText.text = "nil"
        
        return nickText
    }()

    let timeLabel: UILabel = {
        let label = UILabel()
        //label.text = "HH:MM:SS"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textView: UITextView = {
        let label = UITextView()
        //label.text = "HH:MM:SS"
        label.font = UIFont.systemFont(ofSize: 21)
        label.textColor = .white
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .darkGray
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        
        return containerView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .clear
        
        addSubview(containerView)
        containerView.addSubview(nicknameText)
        containerView.addSubview(profileImageView)
        containerView.addSubview(timeLabel)
        containerView.addSubview(textView)
        
        containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true

        profileImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        nicknameText.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10).isActive = true
        nicknameText.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 10).isActive = true
        nicknameText.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        nicknameText.heightAnchor.constraint(equalToConstant: 48).isActive = true

        timeLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
        
        textView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20).isActive = true
        textView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20).isActive = true
        textView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 18).isActive = true
        textView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -1).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
