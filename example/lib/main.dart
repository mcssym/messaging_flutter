import 'package:flutter/material.dart';
import 'package:messaging/messaging.dart';
import 'package:messaging_flutter/messaging_flutter.dart';

void main() {
  final Messaging messaging = Messaging();
  runApp(MyApp(
    messaging: messaging,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.messaging,
  });

  final Messaging messaging;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MessagingScopeProvider(
        messaging: messaging,
        lifecycleHandling: const MessagingLifecycleHandling(
          handlePauseAndResume: true,
          handleStart: true,
          handleStop: true,
        ),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    int counter = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messaging flutter Demo'),
      ),
      body: Center(
        child: MessagingSubscriberBuilder(
          messageTypes: const <Type>[CounterMessage],
          subscriberKey: '',
          builder: (context, child, message) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Message of type ${message.runtimeType} received',
                ),
                if (message is CounterMessage)
                  Text(
                    '${message.counter}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _publishMessage(counter++),
        tooltip: 'Publish new message',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _publishMessage(int counter) {
    MessagingScope.of(context)?.publish(CounterMessage(counter));
  }
}

class CounterMessage extends Message {
  final int counter;

  CounterMessage(this.counter);
}
