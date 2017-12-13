//
//  ViewController.swift
//  try_twitter_login
//
//  Created by Wataru Maeda on 2017/12/11.
//  Copyright © 2017 com.watarumaeda. All rights reserved.
//

import UIKit
import SafariServices
import TwitterKit

class ViewController: UIViewController {

  @IBOutlet var profileImageView: UIImageView! {
    didSet {
      profileImageView.clipsToBounds = true
      profileImageView.contentMode = .scaleAspectFill
      profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
    }
  }
  @IBOutlet var userNameLabel: UILabel! {
    didSet {
      userNameLabel.isUserInteractionEnabled = false
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initTwitterLoginButton()
  }
  
  func initTwitterLoginButton() {
    let logInButton = TWTRLogInButton(logInCompletion: { session, error in
      if (session != nil) {
        
        print("[userID]: \(String(describing: session?.userID))");
        print("[userName]: \(String(describing: session?.userName))");
        print("[authToken]: \(String(describing: session?.authToken))");
        print("[authTokenSecret]: \(String(describing: session?.authTokenSecret))");
        
        // Show User Name
        if let userName = session?.userName {
          self.userNameLabel.text = userName
          self.userNameLabel.textColor = .black
        }
        
        // Show Profile Image
        if let userId = session?.userID {
          let twitterClient = TWTRAPIClient(userID: userId)
          twitterClient.loadUser(withID: userId, completion: { (user, error) in
            guard let profileUrl = user?.profileImageURL else { return }
            print("[profileImageURL]: \(profileUrl))");
            self.setProfileImage(stringUrl: profileUrl)
          })
        }
        
      } else {
        print("error: \(String(describing: error?.localizedDescription))");
      }
    })
    let centerY = userNameLabel.frame.maxY + logInButton.frame.size.height / 2 + 40
    logInButton.center = CGPoint(x: view.frame.size.width / 2, y: centerY)
    view.addSubview(logInButton)
  }
  
  func setProfileImage(stringUrl: String) {
    guard let url = URL(string: stringUrl) else { return }
    getDataFromUrl(url: url) { data, response, error in
      guard let data = data, error == nil else { return }
      print(response?.suggestedFilename ?? url.lastPathComponent)
      DispatchQueue.main.async() {
        self.profileImageView.image = UIImage(data: data)
      }
    }
  }
  
  func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
      completion(data, response, error)
      }.resume()
  }
}
