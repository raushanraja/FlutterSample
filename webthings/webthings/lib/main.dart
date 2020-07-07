import 'package:flutter/material.dart';
import 'package:webthings/services/locator.dart';
import 'package:webthings/theme/custom_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebThings',
      theme: ThemeData(
        primarySwatch: CustomColors.dark,
      ),
      home: MyHomePage(title: 'WebThings'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _buttonColor = CustomColors.dark[300];
  bool _state = false;
  static const String url = "http://192.168.0.24/things/switc/properties/on";
  void updateButton() {
    setState(() {
      print("Inside SetState");
      _buttonColor = _state ? CustomColors.info : CustomColors.dark[200];
      print("Exiting setState");
    });
  }

  Future<bool> getInitialState() async {
    var response = await http.get(url);
    return convert.jsonDecode(response.body)['on'];
  }

  void httprequest() async {
    print("Inside main func");
    var response =
        await http.put(url, body: "{\"on\":${_state ? false : true}}");
    // var response = await http.get(url);
    _state = convert.jsonDecode(response.body)['on'];
    updateButton();
    print("Exiting main func");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.dark,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () => httprequest(),
                  child: FutureBuilder(
                      initialData: false,
                      future: getInitialState(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _state = snapshot.data;
                          _buttonColor = _state
                              ? CustomColors.info
                              : CustomColors.dark[200];
                        }
                        return Container(
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: _buttonColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: SizedBox(
                            height: 180,
                            width: 150,
                            child: Container(
                              child: Icon(
                                Icons.lightbulb_outline,
                                color: Colors.white,
                                size: 80,
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
