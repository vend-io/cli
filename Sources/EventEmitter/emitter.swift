// https://gist.github.com/pgherveou/95c2fea6c2591b124882

private var autoId: Int = 1

// MARK: Subscription Protocol

protocol Subscription {
  func remove()
}

// MARK: AbstractSubscription<T>

class AbstractSubscription<T>: Subscription {

  // MARK: typealias

  typealias Handler = (T) -> Void

  // MARK: properties

  let handler: Handler

  private let emitter: EventEmitter
  private var eventType: String
  internal let key: Int

  // MARK: initializers

  init(emitter: EventEmitter, eventType: String,  handler: Handler) {
    autoId = autoId + 1
    key = autoId
    self.eventType = eventType
    self.emitter = emitter
    self.eventType = eventType
    self.handler = handler
  }

  // MARK: Methods

  func remove() {
    emitter.subscriptions[eventType]?.removeValue(forKey: key)
  }
}

// MARK: Emitter

class EventEmitter {

  // MARK: properties

  private var currentSubscription: Subscription?
  internal var subscriptions: [String: [Int:Subscription]] = [:]

  // MARK: methods
  @discardableResult
  func on<T>(eventType: String, _ handler: @escaping (T) -> Void) -> Subscription {
    var eventSubscriptions: [Int:Subscription]

    if let values = subscriptions[eventType] {
      eventSubscriptions = values
    } else {
      eventSubscriptions = [:]
    }

    let subscription = AbstractSubscription<T>(
      emitter: self,
      eventType: eventType,
      handler: handler
    )

    eventSubscriptions[subscription.key] = subscription
    subscriptions[eventType] = eventSubscriptions
    return subscription
  }

  func once<T>(event: String, handler: @escaping (T) -> Void) {
    on(eventType: event) { (data: T) -> Void in
      self.currentSubscription?.remove()
      handler(data)
    }
  }

  func removeAllListeners(eventType: String?) {
    if let eventType = eventType {
      subscriptions.removeValue(forKey: eventType)
    } else {
      subscriptions.removeAll()
    }
  }

  func emit<T>(event: String, data: T) {
    if let subscriptions = subscriptions[event] {
      for (_, subscription) in subscriptions {
        currentSubscription = subscription
        (subscription as! AbstractSubscription<T>).handler(data)
      }
    }
  }
}