# Chapter 2: Publishers & Subscribers

```swift
public func example(of description: String, action: () -> Void) {
    print("\n-------- Example of:", description, "------")
    action()
}
```

이 기능을 사용하여 이 책 전체에서 사용할 몇 가지 예를 캡슐화할 것입니다.

그러나, 이러한 예시를 가지고 놀기 전에, 먼저 Publisher, Subscriber 및 구독에 대해 배워야 합니다. 그것들은 Combine의 기초를 형성하고 일반적으로 비동기적으로 데이터를 보내고 받을 수 있게 해준다.

## Hello Publisher

Combine의 핵심은 Publisher 프로토콜이다. 이 프로토콜은 시간이 지남에 따라 일련의 값을 하나 이상의 Subscriber에게 전송할 수 있는 유형에 대한 요구 사항을 정의합니다. 즉, Publisher는 관심 있는 가치를 포함할 수 있는 이벤트를 게시하거나 방출한다.

이전에 Apple 플랫폼에서 개발한 적이 있다면, Publisher를 NotificationCenter와 비슷하다고 생각할 수 있습니다. 사실, NotificationCenter에는 이제 브로드캐스트 알림을 게시할 수 있는 Publisher 유형을 제공하는 publisher(for:object:)라는 메소드가 있습니다.

이것을 확인하려면, Starter Playground로 돌아가서 다음 코드로 바꾸세요:

```swift
example(of: "Publisher") {
  // 1
  let myNotification = Notification.Name("MyNotification")
// 2
  let publisher = NotificationCenter.default
    .publisher(for: myNotification, object: nil)
}
```

1. Notification name을 만들어라
2. NotificationCenter의 default에 액세스하고, publisher(for:object:) 메서드를 호출하고, 반환 값을 로컬 상수에 할당하십시오.

publisher(for:object:)를 Option+클릭하면 default NotificationCenter에서 알림을 브로드캐스트할 때 이벤트를 방출하는 Publisher를 반환하는 것을 볼 수 있습니다.

Pulisher는 두 종류의 이벤트를 방출한다:

1. Elements 라고 불리는 Values
2. Completion 이벤트

Publisher는 0개 이상의 값을 방출할 수 있지만 정상적인 completion 이벤트 또는 오류일 수 있는 하나의 완료 이벤트만 방출할 수 있습니다. Publisher가 completion 이벤트를 방출하면, 완료되고 더 이상 이벤트를 방출할 수 없습니다.

Publisher와 Subscriber에 대해 더 깊이 파고들기 전에, 먼저 Observer를 등록하여 알림을 받기 위해 전통적인 NotificationCenter API를 사용하는 예를 마칩니다. 또한 더 이상 그 알림을 받는 데 관심이 없을 때 그 관찰자의 등록을 취소할 것입니다.

그리고 이제 코드를 추가해보죠!

3. 기본 알림 센터로 핸들을 받으세요.

4. 이전에 만든 이름으로 알림을 들을 observer를 만드세요.

5. 그 이름으로 알림을 게시하세요.

6. 알림 센터에서 observer를 제거하세요.

## Hello Subscriber

Subscriber는 publisher로부터 입력을 받을 수 있는 유형에 대한 요구 사항을 정의하는 프로토콜입니다. 곧 publisher 및 subscriber 프로토콜을 준수하는 데 대해 더 깊이 파고들 것입니다; 지금은 기본 흐름에 집중할 것입니다.

새로운 코드를 추가해보자

```swift
example(of: "Subscriber") {
  let myNotification = Notification.Name("MyNotification")
  let publisher = NotificationCenter.default
    .publisher(for: myNotification, object: nil)
  let center = NotificationCenter.default
}
```

만약 지금 notification을 post한다면, publisher는 그것을 방출하지 않을 것입니다 - 그리고 그것은 기억해야 할 중요한 차이점입니다. publisher는 적어도 한 명의 subscriber가 있을 때만 이벤트를 방출한다.

## Subscribing with sink

이전 예제를 계속 진행하면서, publisher에 대한 구독을 만들기 위해 예시에 다음 코드를 추가하세요:

```swift
let subscription = publisher
  .sink { _ in
    print("Notification received from a publisher!")
  }
```

이 코드를 사용하면 publisher에서 sink를 호출하여 구독을 만들 수 있지만, 해당 메소드 이름의 모호함이 가라앉는 느낌을 주지 않도록 하십시오. sink를 Option-클릭하면 publisher의 출력을 처리하기 위해 클로저가 있는 subscriber를 쉽게 연결할 수 있는 방법을 제공한다는 것을 알 수 있습니다. 

이 예시에서, 당신은 그 클로저를 무시하고 대신 알림을 받았다는 것을 나타내기 위해 메시지를 인쇄합니다.

`sink` operator는 publisher가 방출하는 만큼의 값을 계속 받을 것이다. 이것은 무제한 수요로 알려져 있으며, 곧 더 많이 알게 될 것입니다. 그리고 이전 예제에서 그것들을 무시했지만, sink operator는 실제로 두 개의 클로저를 제공합니다: 하나는 completion 이벤트 수신을 처리하는 것이고, 하나는 수신 값을 처리하는 것입니다.

이것이 어떻게 작동하는지 보려면, 이 새로운 예시를 추가하세요:

```swift
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
}
```

여기서 우리는

1. primitive 값 유형에서 publisher를 만들 수 있는 `Just`를 사용하여 publisher를 만드세요.

2. publisher에 대한 구독을 만들고 수신된 각 이벤트에 대한 메시지를 인쇄하세요.

그렇다면 결과가 이렇게 나올 것이다!

```
-------- Example of: Just ------
Received value Hello world!
Received completion finished
```

Just를 Option-클릭하면 빠른 도움말은 각 subscriber에게 출력을 한 번 방출한 다음 완료하는 publisher라고 설명합니다.

예시의 끝에 다음 코드를 추가하여 다른 subscriber를 추가해 보자:

```swift
_ = just
  .sink(
    receiveCompletion: {
      print("Received completion (another)", $0)
    },
    receiveValue: {
      print("Received value (another)", $0)
  })
```

playground로 실행해보면 단어 그대로 실제다, Just는 행복하게 각각의 새로운 subscriber에게 출력을 정확히 한 번 방출한 다음 끝난다.

## Subscribing with assign(to:on:)

sink 말고도, 내장 assign(to:on:) operator를 사용하면 수신된 값을 객체의 KVO 호환 속성에 할당할 수 있습니다.

이것이 어떻게 작동하는지 보려면 이 예시를 추가하세요:

```swift
example(of: "assign(to:on:)") {
  // 1
  class SomeObject {
    var value: String = "" {
didSet {
        print(value)
      }
} }
// 2
  let object = SomeObject()
  // 3
  let publisher = ["Hello", "world!"].publisher
// 4
  _ = publisher
    .assign(to: \.value, on: object)
}
```

위에서:

1. 새 값을 인쇄하는 didSet 속성 observer가 있는 속성을 가진 클래스를 정의하세요.

2. 그 클래스의 인스턴스를 만드세요.

3. 문자열 배열에서 publisher를 만드세요.

4. publisher를 구독하고, 받은 각 값을 객체의 value 속성에 할당하세요.

출력되는 값을 봐보자:

```
-------- Example of: assign(to:on:) ------
Hello
world!
```

## Hello Cancellable

subscriber가 완료되고 더 이상 publisher로부터 값을 받고 싶지 않을 때, 리소스를 확보하고 네트워크 연결과 같은 해당 활동이 발생하는 것을 막기 위해 구독을 취소하는 것이 좋습니다.

구독은 `AnyCancellable`의 인스턴스를 "취소 토큰"으로 반환하므로, 구독을 완료하면 구독을 취소할 수 있습니다. AnyCancellable은 `Cancellable` 프로토콜을 준수하며, 이를 위해 정확히 cancel() 메서드가 필요합니다.

다음 코드를 추가하여 이전부터 구독자 예제를 완료하세요:

```
// 1
center.post(name: myNotification, object: nil)
// 2
subscription.cancel()
```

이 코드로, 당신은:

1. 알림을 게시하세요 (이전과 동일).

2. 구독을 취소하세요. 구독 프로토콜이 Cancellable에서 상속되기 때문에 구독에서 cancel()을 호출할 수 있습니다.

playground를 실행해보면. 당신은 다음을 보게 될 것입니다:

```
-------- Example of: Subscriber ------
Notification received from a publisher!
```

구독에서 cancel()을 명시적으로 호출하지 않으면 publisher가 완료될 때까지 또는 일반 메모리 관리로 인해 저장된 구독이 초기화되지 않을 때까지 계속됩니다. 그 시점에서 그것은 당신을 위해 구독을 취소할 것입니다.

> **Note:** playground의 구독에서 반환 값을 무시해도 괜찮습니다(예: _ = just.sink...). 
> 그러나, 한 가지 주의 사항: 전체 프로젝트에 구독을 저장하지 않으면, 프로그램 흐름이 생성된 범위를 벗어나자마자 해당 구독이 취소됩니다!

이것들은 시작하기에 좋은 예이지만, 무대 뒤에서 더 많은 일이 일어나고 있다. 커튼을 들어 올리고 Combine에서 publisher, subscriber 및 구독의 역할에 대해 자세히 알아볼 때입니다.

## Understanding what’s going on

그들은 사진이 천 단어의 가치가 있다고 말하므로, publisher와 subsscriber 간의 상호 작용을 설명하기 위해 하나를 시작합시다:

![2-1](https://github.com/gaeng2y/Combine-Study/blob/main/Lectures/Chapter_02/2-1.png?raw=true)

이 UML 다이어그램을 살펴보세요:

1. subscriber는 publisher를 구독한다.
2. publisher는 구독을 만들어 subscriber에게 제공합니다.
3. subscriber는 값을 요청합니다.
4. publisher는 값을 보냅니다.
5. publisher는 completion를 보낸다.

`Publisher` 프로토콜과 가장 중요한 extension을 살펴보자:

```swift
public protocol Publisher {
  // 1
  associatedtype Output
  // 2
  associatedtype Failure : Error
// 4
  func receive<S>(subscriber: S)
    where S: Subscriber,
    Self.Failure == S.Failure,
    Self.Output == S.Input
}
extension Publisher {
  // 3
  public func subscribe<S>(_ subscriber: S)
    where S : Subscriber,
    Self.Failure == S.Failure,
    Self.Output == S.Input
}
```

자세히 살펴보겠습니다:

1. publisher가 생산할 수 있는 값의 유형.

2. publisher가 생성할 수 있는 오류의 유형, 또는 게시자가 오류를 생성하지 않는 경우 Never를 생성하십시오.

3. subscriber는 publisher에서 subscribe(_:)을 호출하여 첨부합니다.

4. Subscribe(_:)의 구현은 receive(subscriber:)를 호출하여 subscriber를 publisher에게 연결하세요, 즉 구독을 만드세요.

associated types은 subscriber를 만들기 위해 subscriber가 일치해야 하는 게시자의 인터페이스입니다.
















































