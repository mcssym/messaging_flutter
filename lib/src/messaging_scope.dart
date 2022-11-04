import 'package:flutter/widgets.dart';
import 'package:messaging/messaging.dart';

/// Scope that allows to access public api of [Messaging] instance
/// where in the tree.
class MessagingScope extends InheritedWidget implements Messaging {
  /// Constructor
  const MessagingScope({
    Key? key,
    required Widget child,
    required this.messaging,
  }) : super(key: key, child: child);

  /// Messaging instance
  final Messaging messaging;

  /// Access to the [MessagingScope] in the tree
  static MessagingScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MessagingScope>();
  }

  @override
  bool updateShouldNotify(MessagingScope oldWidget) {
    return true;
  }

  @override
  IterableWrapper<MessagingGuard> get guards => messaging.guards;

  @override
  ToggableLog get log => messaging.log;

  @override
  IterableWrapper<MessagingObserver> get observers => messaging.observers;

  @override
  void pause() {
    messaging.pause();
  }

  @override
  PublishResult publish(Message message) {
    return messaging.publish(message);
  }

  @override
  Future<PublishResult> publishNow(Message message,
      {PublishNowErrorHandlingStrategy strategy =
          PublishNowErrorHandlingStrategy.continueDispatch}) {
    return messaging.publishNow(message, strategy: strategy);
  }

  @override
  MessageQueue get queue => messaging.queue;

  @override
  void resume() {
    messaging.resume();
  }

  @override
  Future<void> start() {
    return messaging.start();
  }

  @override
  void stop() {
    messaging.stop();
  }

  @override
  bool get stopped => messaging.stopped;

  @override
  MessageStore get store => messaging.store;

  @override
  void subscribe(MessagingSubscriber subscriber, {required Type to}) {
    messaging.subscribe(subscriber, to: to);
  }

  @override
  void subscribeAll(MessagingSubscriber subscriber,
      {required Iterable<Type> to}) {
    messaging.subscribeAll(subscriber, to: to);
  }

  @override
  void unsubscribe(MessagingSubscriber subscriber, {required Type to}) {
    messaging.unsubscribe(subscriber, to: to);
  }

  @override
  void unsubscribeAll(MessagingSubscriber subscriber) {
    messaging.unsubscribeAll(subscriber);
  }
}
