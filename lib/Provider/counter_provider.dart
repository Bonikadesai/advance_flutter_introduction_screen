import 'package:contact_dairy_af/modals/counter_modals.dart';
import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  Counter counter = Counter(cnt: 0);

  void incrementCounter() {
    counter.cnt++;

    notifyListeners();
  }
}
