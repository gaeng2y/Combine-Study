//
//  ViewController.swift
//  HelloPublishers
//
//  Created by Mohammad Azam on 9/1/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import UIKit
import Combine

class StringSubscriber: Subscriber {
    
    func receive(subscription: Subscription) {
        print("Received Subscription")
        subscription.request(.max(3)) // backpressure
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("Received Value", input)
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Completed")
    }
    
    
    typealias Input = String
    typealias Failure = Never
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let publisher = ["A","B","C","D","E","F","G","H","I","J","K"].publisher
        
        let subscriber = StringSubscriber()
        
        publisher.subscribe(subscriber)
        
    }
   

}

