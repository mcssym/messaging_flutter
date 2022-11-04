import 'package:flutter/widgets.dart';
import 'package:messaging/messaging.dart';

import 'messaging_scope.dart';

/// Provider of the [MessagingScope] that allows to simplify
/// management of the [Messaging] instance lifecycle.
class MessagingScopeProvider extends StatefulWidget {
  /// Constructor
  const MessagingScopeProvider({
    Key? key,
    required this.child,
    required this.messaging,
    required this.lifecycleHandling,
  }) : super(key: key);

  /// Handling configuration of [Messaging] lifecycle
  final MessagingLifecycleHandling lifecycleHandling;

  /// Messaging instance
  final Messaging messaging;

  /// Child
  final Widget child;

  @override
  State<MessagingScopeProvider> createState() => _MessagingScopeProviderState();
}

class _MessagingScopeProviderState extends State<MessagingScopeProvider>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    if (widget.lifecycleHandling.handleStart) {
      widget.messaging.start();
    }
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (!widget.lifecycleHandling.handlePauseAndResume) return;

    if (state == AppLifecycleState.resumed) {
      widget.messaging.resume();
      return;
    }

    if (state == AppLifecycleState.paused) {
      widget.messaging.pause();
      return;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (widget.lifecycleHandling.handleStop) {
      widget.messaging.stop();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MessagingScope(
      child: widget.child,
      messaging: widget.messaging,
    );
  }
}

/// Configuration of the handling of the [Messaging] instance
class MessagingLifecycleHandling {
  /// Defines if we should stop the messaging instance
  /// when the provider is disposed
  final bool handleStop;

  /// Defines if we should start the messaging instance
  /// when the provider is initializing its state
  final bool handleStart;

  /// Defines if we should pause/resume the messaging instance
  /// when the [AppLifecycleState] of the application changes.
  final bool handlePauseAndResume;

  /// Constructor
  const MessagingLifecycleHandling({
    required this.handleStop,
    required this.handleStart,
    required this.handlePauseAndResume,
  });
}
