// Also available at: https://www.jdoodle.com/ga/4jZI7%2Fi%2FaurJSOG9efQLxA%3D%3D
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Interactive Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: InteractiveHomePage(),
    );
  }
}

class InteractiveHomePage extends StatefulWidget {
  @override
  _InteractiveHomePageState createState() => _InteractiveHomePageState();
}

class _InteractiveHomePageState extends State<InteractiveHomePage> {
  Color _backgroundColor = Colors.white;
  final Color _defaultColor = Colors.white;
  final Color _changedColor = Colors.lightBlue.shade100;
  String _textFieldValue = '';

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 1)),
    );
  }

  void _handleLongPress() {
    setState(() {
      _backgroundColor = _changedColor;
    });
  }

  void _handleReset() {
    setState(() {
      _backgroundColor = _defaultColor;
    });
  }

  void _handleSingleTap() {
    _showSnackBar("Single Tap Detected");
  }

  void _handleDoubleTap() {
    _showSnackBar("Double Tap Detected");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(title: Text('Flutter Interaction Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Welcome to Flutter!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _showSnackBar("Button Clicked"),
                  child: Text('Click Me'),
                ),
                ElevatedButton(
                  onLongPress: _handleLongPress,
                  child: Text('Long Press Me'),
                ),
                ElevatedButton(
                  onPressed: _handleReset,
                  child: Text('Reset'),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // GestureDetector for tap/double-tap
            GestureDetector(
              onTap: _handleSingleTap,
              onDoubleTap: _handleDoubleTap,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Tap or Double Tap Here',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // TextField with onChanged and onSubmitted
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter something',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _textFieldValue = value;
                print("Live Input: $_textFieldValue");
              },
              onSubmitted: (value) {
                print("Submitted: $value");
              },
            ),
          ],
        ),
      ),
    );
  }
}
