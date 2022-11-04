import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:messaging/messaging.dart';
import 'package:messaging_flutter/src/messaging_scope.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Messaging>(), MockSpec<Message>()])
import 'messaging_scope_test.mocks.dart';

void main() {
  group('MessagingScope', () {
    test(
        'will call start of messaging instance when calling start of MessagingScope',
        () async {
      final messaging = MockMessaging();
      final scope = MessagingScope(
        child: const SizedBox(),
        messaging: messaging,
      );

      when(messaging.start())
          .thenAnswer((realInvocation) => Future<void>.value());
      await scope.start();

      verify(messaging.start()).called(1);
    });
    test(
        'will call stop of messaging instance when calling stop of MessagingScope',
        () {
      final messaging = MockMessaging();
      final scope = MessagingScope(
        child: const SizedBox(),
        messaging: messaging,
      );

      when(messaging.stop()).thenAnswer((realInvocation) {});
      scope.stop();

      verify(messaging.stop()).called(1);
    });
    test(
        'will call pause of messaging instance when calling pause of MessagingScope',
        () {
      final messaging = MockMessaging();
      final scope = MessagingScope(
        child: const SizedBox(),
        messaging: messaging,
      );

      when(messaging.pause()).thenAnswer((realInvocation) {});
      scope.pause();

      verify(messaging.pause()).called(1);
    });
    test(
        'will call resume of messaging instance when calling resume of MessagingScope',
        () {
      final messaging = MockMessaging();
      final scope = MessagingScope(
        child: const SizedBox(),
        messaging: messaging,
      );

      when(messaging.resume()).thenAnswer((realInvocation) {});
      scope.resume();

      verify(messaging.resume()).called(1);
    });
    test(
        'will call publish of messaging instance when calling publish of MessagingScope',
        () {
      final messaging = MockMessaging();
      final scope = MessagingScope(
        child: const SizedBox(),
        messaging: messaging,
      );

      when(messaging.publish(any))
          .thenReturn(const PublishResult(published: true));
      scope.publish(MockMessage());

      verify(messaging.publish(argThat(isA<MockMessage>()))).called(1);
    });
    test(
        'will call publishNow of messaging instance when calling publishNow of MessagingScope',
        () async {
      final messaging = MockMessaging();
      final scope = MessagingScope(
        child: const SizedBox(),
        messaging: messaging,
      );

      when(messaging.publishNow(any)).thenAnswer((realInvocation) =>
          Future<PublishResult>.value(const PublishResult(published: true)));
      await scope.publishNow(MockMessage());

      verify(messaging.publishNow(argThat(isA<MockMessage>()))).called(1);
    });
  });
}
