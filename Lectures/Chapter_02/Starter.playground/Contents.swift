import UIKit
import Combine
import Foundation

var subscriptions = Set<AnyCancellable>()

example(of: "Publisher") {
    // 1
    let myNotification = Notification.Name("MyNotification")
    
    // 2
//    let publisher = NotificationCenter.default.publisher(for: myNotification, object: nil)
    
    // 3
    let center = NotificationCenter.default
    // 4
    let observer = center.addObserver(
      forName: myNotification,
      object: nil,
      queue: nil) { notification in
        print("Notification received!")
    }
    // 5
    center.post(name: myNotification, object: nil)
    // 6
    center.removeObserver(observer)
}
