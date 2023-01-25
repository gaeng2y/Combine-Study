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
        
        let publisher = NotificationCenter.default.publisher(for: notification, object: nil)
        
        let subscription = publisher
            .sink { _ in
            print("Notification recevied")
        }
        
        NotificationCenter.default.post(name: notification, object: nil)
        
      
       
    }


}

