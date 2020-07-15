import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';
void main() => runApp(MyApp());

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }*/
  String qr;
  bool camState = false;
     void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Information passager : "+qr),
          content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Observation', hintText: 'Observation'),
              onChanged: (value) {
                qr = value;
              },
            ))
          ],
        ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Valider"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ), 
            new FlatButton(
              child: new Text("Annuller"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
 

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Plugin example app'),
      ),
      body: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
                child: camState
                    ? new Center(
                        child: new SizedBox(
                          width: 400.0,
                          height: 700.0,
                          child: new QrCamera(
                            onError: (context, error) => Text(
                                  error.toString(),
                                  style: TextStyle(color: Colors.red),
                                ),
                            qrCodeCallback: (code) {
                              setState(() {
                                qr = code;
                                camState = !camState;
                                _showDialog();
                              });
                            },
                            child: new Container(
                              decoration: new BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.orange, width: 10.0, style: BorderStyle.solid),
                              ),
                            ),
                          ),
                        ),
                      )
                    :  ListView(children: <Widget>[
                            Center(
                                child: Text(
                              'Liste des Voyageurs $qr' ,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            )
                            ),
                            DataTable(
                              columns: [
                                DataColumn(label: Text('Prénom et Nom')),
                                DataColumn(label: Text('Destination')),
                                DataColumn(label: Text('Téléphone')),
                                DataColumn(label: Text('Observation')),
                              ],
                              rows: [
                                DataRow(cells: [
                                  DataCell(Text('naby NDAIYE')),
                                  DataCell(Text('Thies')),
                                  DataCell(Text('772220594')),
                                  DataCell(Text('--')),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('naby NDAIYE')),
                                  DataCell(Text('Thies')),
                                  DataCell(Text('772220594')),
                                  DataCell(Text('--')),
                                ]),
                                DataRow(cells: [
                                  DataCell(Text('naby NDAIYE')),
                                  DataCell(Text('Thies')),
                                  DataCell(Text('772220594')),
                                  DataCell(Text('--')),
                                ]),
                              ],
                            ),
                          ],
                    )),
                    //new Center(child: new Text("Camera inactive"))),
            //new Text("QRCODE: $qr"),
                    ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              camState = !camState;
            });
          }),
    );
  }
}
