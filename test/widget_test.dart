// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

void main() {
//  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(App());
//
//    // Verify that our counter starts at 0.
//    expect(find.text('0'), findsOneWidget);
//    expect(find.text('1'), findsNothing);
//
//    // Tap the '+' icon and trigger a frame.
//    await tester.tap(find.byIcon(Icons.add));
//    await tester.pump();
//
//    // Verify that our counter has incremented.
//    expect(find.text('0'), findsNothing);
//    expect(find.text('1'), findsOneWidget);
//  });

  test(('copy array'), () {
    var a = [1000000000, 2, 3];
    var b = [...a];
    a[0] = 111;
    print(a);
    print(b);

    var aa = ['我还没改名1', '我还没改名2','我还没改名3'];
    var bb = [...aa];
    aa[0] = '我已经改名啦1';
    print(aa);
    print(bb);

//    var aa = [Person('11'),Person('22'),Person('33')];

    var aaa = [
      Person('111'),
      Person('222'),
      Person('222')
    ];
    var bbb = [...aaa];
    aaa[0].name = '我要改名了';
    print(aaa);
    print(bbb);
  });
}

class Person {
  String name;

  Person(this.name);

  @override
  String toString() {
    return 'Person{name: $name}';
  }
}
