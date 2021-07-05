import 'package:flutter/material.dart';

class Utils {
  // Convert List<M> to List<Widget> where M is any type.
  static List<Widget> modelBuilder<M>(
      List<M> models, Widget Function(int index, M model) builder) {
    return models
        .asMap()
        .map<int, Widget>(
            (index, model) => MapEntry(index, builder(index, model)))
        .values
        .toList();
  }
}
