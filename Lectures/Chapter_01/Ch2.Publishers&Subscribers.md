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

6. 알림 센터에서 관찰자를 제거하세요.
