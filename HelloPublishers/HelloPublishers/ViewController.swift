//
//  ViewController.swift
//  HelloPublishers
//
//  Created by Mohammad Azam on 9/1/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notification = Notification.Name("MyNotification")
        
        let center = NotificationCenter.default
        
        let observer = center.addObserver(forName: notification, object: nil, queue: nil) { notification in
            print("Notification recevied!")
        }
        
        center.post(name: notification, object: nil)
        
        center.removeObserver(observer)
 
        
        
    }


}

