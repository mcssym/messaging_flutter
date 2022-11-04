import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:messaging/messaging.dart';

import 'messaging_scope.dart';

/// Widget builder that will rebuild
class MessagingSubscriberBuilder extends StatefulWidget {
  /// Constructor
  const MessagingSubscriberBuilder({
    Key? key,
    required this.builder,
    required this.messageTypes,
    required this.subscriberKey,
    this.messaging,
    this.child,
  }) : super(key: key);

  /// Messaging instance
  ///
  /// If null then [MessagingScope] will be used
  final Messaging? messaging;

  /// Static child to pass to [builder]
  final Widget? child;

  /// List of message types to subscribe.
  final List<Type> messageTypes;

  /// Subscriber key to use
  final String subscriberKey;

  /// Widget builder
  final Widget Function(BuildContext context, Widget? child, Message? message)
      builder;

  @override
  State<MessagingSubscriberBuilder> createState() =>
      _MessagingSubscriberBuilderState();
}

class _MessagingSubscriberBuilderState extends State<MessagingSubscriberBuilder>
    implements MessagingSubscriber {
  late Messaging _messaging;

  Message? _message;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initMessaging();
  }

  void _initMessaging() {
    final messaging = widget.messaging ?? MessagingScope.of(context);
    if (messaging == null) {
      throw StateError(
          "The messaging instance can be retrieved from parameters or from MessagingScope");
    }

    _messaging = messaging;
    _subscribeAll();
  }

  @override
  void didUpdateWidget(covariant MessagingSubscriberBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messaging != widget.messaging) {
      _unsubscribeAll();
      _initMessaging();
    } else if (!listEquals(oldWidget.messageTypes, widget.messageTypes)) {
      _unsubscribeAll();
      _subscribeAll();
    }
  }

  void _unsubscribeAll() {
    _messaging.unsubscribeAll(this);
  }

  void _subscribeAll() {
    _messaging.subscribeAll(this, to: widget.messageTypes);
  }

  @override
  void dispose() {
    _unsubscribeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      widget.child,
      _message,
    );
  }

  @override
  Future<void> onMessage(Message message) async {
    _message = message;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  String get subscriberKey => widget.subscriberKey;
}
