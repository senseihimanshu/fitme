import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
// import 'package:sensors/sensors.dart';
import 'package:expo_sensors/accelerometer.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fit Me',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Fit Me'),
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
  int _counter = 0;
  var _subscription;
  String _stepCountValue = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

//
  void setUpPedometer() {
    Pedometer pedometer = new Pedometer();
    _subscription = pedometer.stepCountStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onData(int stepCountValue) async {
    setState(() => _stepCountValue = "$stepCountValue");
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

  void _onCancel() => _subscription.cancel();
//

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpPedometer();
    print(this._stepCountValue);

    //sensors
    

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
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_stepCountValue',
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              child: Text('Login'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => {},
            ),
            RaisedButton(
              child: Text('Signup'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => {},
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
