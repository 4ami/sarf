part of '../history_lib.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(body: Center(child: Text('Expenses history'),),);
  }
}