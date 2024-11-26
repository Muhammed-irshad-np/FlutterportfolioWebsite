---
title: Main doc
---
# This is the demo doc for flutter main file

<SwmSnippet path="/lib/main.dart" line="5">

---

## You could find the main file here <SwmPath>[lib/main.dart](/lib/main.dart)</SwmPath>&nbsp;

This is the entry point of  a flutter project <SwmToken path="/lib/main.dart" pos="6:2:2" line-data="void main() {">`main`</SwmToken>

&nbsp;

\`

```dart

void main() {
  runApp(const MyApp());
}
```

---

</SwmSnippet>

<SwmSnippet path="/lib/main.dart" line="10">

---

&nbsp;

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderConfigs().providerlist,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const HomepageView(),
      ),
    );
  }
}
```

---

</SwmSnippet>

<SwmMeta version="3.0.0" repo-id="Z2l0aHViJTNBJTNBRmx1dHRlcnBvcnRmb2xpb1dlYnNpdGUlM0ElM0FNdWhhbW1lZC1pcnNoYWQtbnA=" repo-name="FlutterportfolioWebsite"><sup>Powered by [Swimm](https://app.swimm.io/)</sup></SwmMeta>
