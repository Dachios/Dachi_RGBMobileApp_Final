// Dachi Sirbiladze
// Mobile App Development Final Project - RGB Color Picker
// 01/17/2024

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // This was required to get clipboard functioning.
import 'dart:math'; //for random number generations

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RGB Color Picker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'RGB Color Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Random object for the random button
  Random random = Random();

  // Value holders for Red, Green, and Blue
  double _redValue = 0;
  double _greenValue = 0;
  double _blueValue = 0;


  @override
  Widget build(BuildContext context) {

    // I didn't have to do this, but I did it in case I needed to refer to their components later.
    Slider rSlider;
    Slider gSlider;
    Slider bSlider;

    // Scaler affects the randomize button, the RGB values displayed, and the copy to clipboard RGB buttons.
    const valueText = TextScaler.linear(2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // Android icon, as well as a square, for some visual variety.
            Icon(
              Icons.adb_outlined,
              color: Color.fromARGB(255, _redValue.round(), _greenValue.round(), _blueValue.round()),
              size: 150.0,

            ),
            Container(
              color: Color.fromARGB(255, _redValue.round(), _greenValue.round(), _blueValue.round()),
              width: 150,
              height: 150,
            ),

            // Red slider
            rSlider = Slider(
              value: _redValue,
              thumbColor: Colors.red,
              activeColor: Colors.redAccent,
              inactiveColor: Colors.grey,
              max: 255,
              divisions: 255,
              label: _redValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _redValue = value;
                });
              },
            ),

            // Green Slider
            gSlider = Slider(
              value: _greenValue,
              thumbColor: Colors.green,
              activeColor: Colors.greenAccent,
              inactiveColor: Colors.grey,
              max: 255,
              divisions: 255,
              label: _greenValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _greenValue = value;
                });
              },
            ),

            // Blue Slider
            bSlider = Slider(
              value: _blueValue,
              thumbColor: Colors.blue,
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.grey,
              max: 255,
              divisions: 255,
              label: _blueValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _blueValue = value;
                });
              }
            ),
            const Spacer(),

            // Randomize button
            ElevatedButton(
                onPressed: () => {
                  setState(() {
                    _redValue = random.nextInt(255) + 1;
                    _greenValue = random.nextInt(255) + 1;
                    _blueValue = random.nextInt(255) + 1;
                  })
                },
                child: const Text(
                  'Randomize',
                  textScaler: valueText,
                )
            ),
            const Spacer(),

            // Row element to keep the RGB values displayed neatly
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                const Spacer(),
                Text(
                  'R - ' + _redValue.round().toString(),
                  textScaler: valueText,
                ),
                const Spacer(),
                Text(
                  'G - ' + _greenValue.round().toString(),
                  textScaler: valueText,
                ),
                const Spacer(),
                Text(
                  'B - ' + _blueValue.round().toString(),
                  textScaler: valueText,
                ),
                const Spacer()
              ]
            ),
            const Spacer(),

            // Another row element for the copy buttons.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(),

                // Copy to Clipboard
                ElevatedButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: _redValue.round().toString() + ' ' + _greenValue.round().toString() + ' ' + _blueValue.round().toString()));
                      //print('copied to clipboard');

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Copied RGB values ' + _redValue.round().toString() + ' ' + _greenValue.round().toString() + ' ' + _blueValue.round().toString() + ' to keyboard'),
                            duration: const Duration(milliseconds: 1500)

                        ),
                      );
                    },
                    child: const Icon(Icons.assignment)
                ),
                const Spacer(),

                // Copy R-value to Clipboard
                ElevatedButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: _redValue.round().toString() ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Copied R Value ' + _redValue.round().toString()),
                            duration: const Duration(milliseconds: 1000)
                        ),
                      );
                    },
                    child: const Text(
                      'R',
                      textScaler: valueText,
                    )
                ),
                const Spacer(),

                // Copy G-value to Clipboard
                ElevatedButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: _greenValue.round().toString() ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Copied G Value ' + _greenValue.round().toString()),
                            duration: const Duration(milliseconds: 1000)
                        ),
                      );
                    },
                    child: const Text(
                      'G',
                      textScaler: valueText,
                    )
                ),
                const Spacer(),

                // Copy B-value to clipboard
                ElevatedButton(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: _blueValue.round().toString() ));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Copied B Value ' + _blueValue.round().toString()),
                            duration: const Duration(milliseconds: 1000)
                        ),
                      );
                    },
                    child: const Text(
                      'B',
                      textScaler: valueText,
                    )
                ),
                const Spacer(),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
