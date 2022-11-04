# Messaging Flutter
<p align="center">              
<a href="https://img.shields.io/badge/License-MIT-green"><img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License"></a>              
<a href="https://github.com/mcssym/messaging_flutter/stargazers"><img src="https://img.shields.io/github/stars/mcssym/messaging_flutter?style=flat&logo=github&colorB=green&label=stars" alt="stars"></a>              
<a href="https://pub.dev/packages/messaging_flutter"><img src="https://img.shields.io/pub/v/messaging_flutter.svg?label=pub&color=orange" alt="pub version"></a>              
<a href="https://discord.gg/zN6FB8wMR6">              
 <img src="https://img.shields.io/discord/1036665678779920474.svg?color=7289da&label=Discord&logo=discord&style=flat-square" alt="Discord Badge"></a>              
</p>  

A flutter that allows to provide the messaging instance of package [messaging](https://pub.dev/packages/messaging) in your application and access its public APIs.

This package includes:
- `MessagingScopeProvider` to include at the top of the widget tree.
- `MessagingScope` accessible through context with `MessagingScope.of(context)` that allows to access your `messaging` instance APIs.
- `MessagingSubscriberBuilder` that allows to rebuild your widget every time a message you subscribed is published. 

## Installation
In your `pubspec.yaml`

```yaml
dependencies:
  messaging: <latest_version>
  messaging_flutter: <latest_version>
```
