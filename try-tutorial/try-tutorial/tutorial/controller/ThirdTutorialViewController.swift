//
//  ThirdTutorialViewController.swift
//  try-tutorial
//
//  Created by Wataru Maeda on 2018-07-03.
//  Copyright © 2018 com.watarumaeda. All rights reserved.
//

import UIKit

class ThirdTutorialViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  fileprivate var pager: TutorialPager!
  fileprivate var downArrowView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    title = "最近のスキンケア"
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    title = ""
  }
}

// MARK: TableView

extension ThirdTutorialViewController: UITableViewDelegate, UITableViewDataSource {
  
  func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    UIView.animate(withDuration: 0, animations: {
      self.tableView.reloadData()
    }) { finished in
      if finished {
        self.setupPager()
        self.showSpeechBaloon()
      }
    }
  }
  
  func resizeTableView() {
    var frame = tableView.frame
    frame.size.height = tableView.frame.size.height - pager.frame.size.height
    print(tableView.frame.size.height)
    print(pager.frame.size.height)
    tableView.frame = frame
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    return cell ?? UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 1918
  }
}

// MARK: - Page Control

extension ThirdTutorialViewController {
  
  func setupPager() {
    
    // get pager from xib
    let nib = UINib(nibName: "TutorialPager", bundle: nil)
    let subviews = nib.instantiate(withOwner: self, options: nil)
    pager = subviews.first as! TutorialPager
    pager.frame = CGRect(x: 0, y: view.frame.size.height,
                         width: view.frame.size.width, height: 178)
    
    // add skip action
    pager.skipButton.addTarget(self,action: #selector(tappedSkip), for: .touchUpInside)
    
    // setup shadow
    pager.layer.shadowColor = UIColor.lightGray.cgColor
    pager.layer.shadowOffset = CGSize(width: 0, height: -1);
    pager.layer.masksToBounds = false
    pager.layer.shadowOpacity = 0.2
    
    // setup contents
    pager.setupContents(3)
    
    view.addSubview(pager)
    
    // animation
    var pagerOrigin = pager.frame.origin
    pagerOrigin.y = view.frame.size.height - 178
    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
      self.pager.frame.origin = pagerOrigin
    }, completion: { _ in
      self.resizeTableView()
    })
  }
  
  @objc func tappedSkip() {
    UIView.animate(withDuration: 0.2, animations: {
      self.downArrowView.alpha = 1
    }) { _ in
      self.downArrowView.isHidden = true
    }
    
    // scroll to bottom
    tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
    
    // setup contents
    pager.setupContents(4)
  }
}

// MARK: - Speech Baloon

extension ThirdTutorialViewController {
  
  func showSpeechBaloon() {
    
    // base view
    downArrowView = UIView()
    downArrowView.backgroundColor = .white
    downArrowView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    downArrowView.layer.borderColor = UIColor(red:0.984, green:0.506, blue:0.522, alpha:1.000).cgColor
    downArrowView.layer.borderWidth = 2
    downArrowView.layer.cornerRadius = 5
    downArrowView.isHidden = true
    
    // attach image button to the view
    let arrowButton = UIButton()
    arrowButton.frame = CGRect(x: 13, y: 13, width: 24, height: 24)
    arrowButton.setImage(#imageLiteral(resourceName: "tuto-down-arrow"), for: .normal)
    arrowButton.imageView?.contentMode = .scaleAspectFit
    arrowButton.addTarget(self, action: #selector(tappedArrow), for: .touchUpInside)
    self.downArrowView.addSubview(arrowButton)
    
    // attatch baloon
    let nib = UINib(nibName: "TutorialSpeechBaloon", bundle: nil)
    let subviews = nib.instantiate(withOwner: self, options: nil)
    let speechBaloonView = subviews.first as! TutorialSpeechBaloon
    speechBaloonView.frame = CGRect(x: 30,
                                    y: 25 - self.view.frame.size.width / 3,
                                    width: self.view.frame.size.width / 3,
                                    height: self.view.frame.size.width / 3)
    speechBaloonView.label.text = "メイクの方法を\n見てみよう"
    self.downArrowView.addSubview(speechBaloonView)
    self.downArrowView.alpha = 0
    
    // position base view
    self.downArrowView.center = CGPoint(x: self.view.center.x,
                                        y: self.view.frame.size.height - 178 - 30)
    
    self.downArrowView.isHidden = false
    self.view.addSubview(self.downArrowView)
    
    // animation
    UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {
      
      // fade in animation
      self.downArrowView.alpha = 1
      
    }, completion: nil)
    
    // shake animation
    let animation = CAKeyframeAnimation(keyPath:"transform")
    let angle = 0.05 as CGFloat
    animation.values = [CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0),
                        CATransform3DMakeRotation(-angle, 0.0, 0.0, 1.0)]
    animation.autoreverses = true
    animation.duration = 0.2
    animation.repeatCount = 2
    self.downArrowView.layer.add(animation, forKey: "position")
  }
  
  @objc func tappedArrow() {
    
    UIView.animate(withDuration: 0.2, animations: {
      self.downArrowView.alpha = 1
    }) { _ in
      self.downArrowView.isHidden = true
    }
    
    // scroll to bottom
    tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
    
    // setup contents
    pager.setupContents(4)
  }
}
