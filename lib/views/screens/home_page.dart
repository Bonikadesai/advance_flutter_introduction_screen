import 'package:contact_dairy_af/Provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/theme_provider.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: Icon(Icons.sunny),
          ),
        ],
      ),
      floatingActionButton: Consumer<CounterProvider>(
        builder: (context, counterProvider, _) => FloatingActionButton(
          onPressed: () {
            counterProvider.incrementCounter();
          },
          child: Icon(Icons.add),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${Provider.of<CounterProvider>(context, listen: true).counter.cnt}",
              style: TextStyle(
                fontSize: 65,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
