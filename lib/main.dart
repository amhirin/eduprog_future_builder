import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eduprog FutureBuilder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Eduprog Flutter FutureBuilder'),
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
  final String _url_target = 'http://nabita.info/test/request.php?mtd=eduprog';

  Future<String> httpGet(String url) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load get');
    }
  }

  Widget widgetFutureBuilder(){
    return FutureBuilder<String>(
        future: httpGet(this._url_target),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasData) {
                String _data = snapshot.data;
                return Center(
                  child: Text(_data),
                );
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Terjadi masalah saat load data..')
                );
              }
              break;
            default:
              break;
          }
        }
      );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widgetFutureBuilder(),
            SizedBox(height: 20,),
            RaisedButton(
              onPressed: () {
                //. reload
                setState(() {

                });
              },
              child: const Text(
                  'Refresh Data',
                  style: TextStyle(fontSize: 20)
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
