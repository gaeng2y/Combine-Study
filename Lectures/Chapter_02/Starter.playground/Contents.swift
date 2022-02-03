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

example(of: "Subscriber") {
    let myNotification = Notification.Name("MyNotification")
    let publisher = NotificationCenter.default
        .publisher(for: myNotification, object: nil)
    let center = NotificationCenter.default
    
    // 1
    let subscription = publisher
        .sink { _ in
            print("Notification received from a publisher!")
        }
    
    // 2
    center.post(name: myNotification, object: nil)
    // 3
    subscription.cancel()
}

example(of: "Just") {
    // 1
    let just = Just("Hello world!")
    // 2
    _ = just
        .sink(
            receiveCompletion: {
                print("Received completion", $0)
            },
            receiveValue: {
                print("Received value", $0)
            })
    
    _ = just
      .sink(
        receiveCompletion: {
          print("Received completion (another)", $0)
        },
        receiveValue: {
          print("Received value (another)", $0)
      })
}
