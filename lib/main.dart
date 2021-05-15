import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:test_reactive_forms/example_one.dart';
import 'package:test_reactive_forms/example_three.dart';
import 'package:test_reactive_forms/example_two.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      home: MyHomePage(title: 'Reactive Forms Rocks!!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with RestorationMixin {
  RestorableInt selectedPage = RestorableInt(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTabController(
          length: 3,
          initialIndex: selectedPage.value,
          child: Container(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                      elevation: 0,
                      margin: EdgeInsets.only(bottom: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: tab(
                                context,
                                label: 'Ejemplo 1',
                                value: 0),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: tab(
                                context,
                                label: 'Ejemplo 2',
                                value: 1),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: tab(
                                context,
                                label: 'Ejemplo 3',
                                value: 2),
                          ),
                        ],
                      )),
                  Expanded(
                      child: _getPage(context))
                ]),
          )),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  // TODO: implement restorationId
  String get restorationId => "home";

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    this.registerForRestoration(selectedPage, "last_selected");
  }

  Widget tab(BuildContext context, {icon, label, value}) {
    final selectedStyle = Border(
        bottom: BorderSide(color: Theme.of(context).accentColor, width: 2));
    var width =MediaQuery.of(context).size.width - 8;
    var height = min(18, ((width / 2) * 24) / width).floorToDouble();
    return Material(
        color: Theme.of(context).backgroundColor,
        shape: selectedPage.value == value ? selectedStyle : null,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: TextButton(
              onPressed: () {
                setState(() {
                  selectedPage.value = value;
                });
              },
              child: Text(
                label,
                style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: height),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
        ));
  }

  Widget _getPage(BuildContext context) {
    switch(selectedPage.value){
      case 0 : return ExampleOne();
      case 1 : return ExampleTwo();
      default : return ExampleThree();
    }
  }
}
