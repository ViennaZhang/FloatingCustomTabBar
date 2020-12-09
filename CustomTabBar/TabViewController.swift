//
//  ViewController.swift
//  CustomTabBar
//
//  Created by Vienna Zhang on 12/6/20.
//

import UIKit

class TabViewController: UIViewController {
  var selectedIndex: Int = 0
  var previousIndex: Int = 0
  @IBOutlet var tabView: UIView!
  @IBOutlet var buttons: [UIButton]!
  var footerHeight: CGFloat = 50
  
  static let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
  static let calendarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalendarViewController")
  static let paymentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaymentViewController")
  static let messagesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MessagesViewController")
  static let accountVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountViewController")
  
  var viewControllers = [UIViewController]()
 


  override func viewDidLoad() {
    super.viewDidLoad()
    viewControllers.append(TabViewController.homeVC)
    viewControllers.append(TabViewController.calendarVC)
    viewControllers.append(TabViewController.paymentVC)
    viewControllers.append(TabViewController.messagesVC)
    viewControllers.append(TabViewController.accountVC)
    
    tabView.layer.cornerRadius = 20
    tabView.layer.borderWidth = 1
    tabView.layer.borderColor = UIColor.systemBlue.cgColor
    
    buttons[selectedIndex].isSelected = true
    tabChanged(buttons[selectedIndex])
  }
}

extension TabViewController {
  @IBAction func tabChanged(_ sender: UIButton) {
    previousIndex = selectedIndex
    selectedIndex = sender.tag
    
    buttons[previousIndex].isSelected = false
    let previousVC = viewControllers[previousIndex]
    
    previousVC.willMove(toParent: nil)
    previousVC.view.removeFromSuperview()
    previousVC.removeFromParent()
    
    sender.isSelected = true
    
    let vc = viewControllers[selectedIndex]
    vc.view.frame = UIApplication.shared.windows[0].frame
    vc.didMove(toParent: self)
    self.addChild(vc)
    self.view.addSubview(vc.view)
    
    self.view.bringSubviewToFront(tabView)
  }
}

