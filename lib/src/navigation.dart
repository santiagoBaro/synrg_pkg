import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationHistory {
  NavigationHistory(this.path, this.params);

  final String path;
  final Map<String, String> params;
}

class SynrgNavigation {
  SynrgNavigation._privateConstructor();

  List<NavigationHistory> history = [];

  static final SynrgNavigation instance = SynrgNavigation._privateConstructor();

  void push(
    BuildContext context,
    String name, {
    Map<String, String> params = const {},
  }) {
    history.add(NavigationHistory(name, params));
    context.goNamed(name, pathParameters: params);
  }

  void go(
    BuildContext context,
    String name, {
    Map<String, String> params = const {},
  }) {
    history = [];
    context.goNamed(name, pathParameters: params);
  }

  void pop(BuildContext context) {
    if (history.isNotEmpty) {
      history.removeLast();
      if (history.isNotEmpty) {
        final last = history.last;
        context.goNamed(last.path, pathParameters: last.params);
      } else {
        context.goNamed('SessionModule', pathParameters: {'state': 'init'});
      }
    } else {
      context.goNamed('SessionModule', pathParameters: {'state': 'init'});
    }
  }
}
