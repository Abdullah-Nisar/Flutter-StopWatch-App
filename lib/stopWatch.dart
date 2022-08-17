import 'package:flutter/material.dart';
import 'dart:async';

import 'package:stop_watch/platform_alert.dart';

class StopWatch extends StatefulWidget {
  static const route = '/stopwatch';
  final String? name;
  final String? email;
  const StopWatch({Key? key, this.name, this.email}) : super(key: key);
  // StopWatch(this.name, this.email);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  bool isTicking = true;
  int milliseconds = 0;
  Timer? timer;

  void _onTick(Timer time) {
    setState(() {
      milliseconds += 100;
    });
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);

    setState(() {
      laps.clear();
      milliseconds = 0;
      isTicking = true;
    });
  }

  void _stopTimer() {
    timer?.cancel();
    setState(() {
      isTicking = false;
    });
    // final int totalRuntime =
    //     laps.fold(milliseconds, (total, lap) => total + lap);
    // final alert = PlatformAlert(
    //     'Run Completed', 'Total Run Time is ${_secondsText(totalRuntime)}');
    // alert.show(context);
    showBottomSheet(context: context, builder: _buildRunCompleteSheet);
  }

  Widget _buildRunCompleteSheet(BuildContext context) {
    final int totalRunTime =
        laps.fold(milliseconds, (total, lap) => total + lap);
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Container(
      color: Theme.of(context).cardColor,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Run Finished!',
              style: textTheme.headline6,
            ),
            Text('Total Run Time is ${_secondsText(totalRunTime)}')
          ],
        ),
      ),
    ));
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  final laps = <int>[];

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
  }

  Widget _buildCounter(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
          ),
          Text(
            _secondsText(milliseconds),
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: isTicking ? null : _startTimer,
                child: Text('Start'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.yellow)),
                  onPressed: isTicking ? _lap : null,
                  child: Text('Lap')),
              const SizedBox(
                width: 20,
              ),
              // Builder(
              //     builder: (context) => TextButton(
              //           onPressed: isTicking ? _stopTimer : null,
              //           child: Text('Stop'),
              //           style: ButtonStyle(
              //             backgroundColor:
              //                 MaterialStateProperty.all<Color>(Colors.red),
              //             foregroundColor:
              //                 MaterialStateProperty.all<Color>(Colors.white),
              //           ),
              //         ))
              TextButton(
                onPressed: isTicking ? _stopTimer : null,
                child: Text('Stop'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLapDisplay() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        for (int milliseconds in laps)
          ListTile(
            title: Text(_secondsText(milliseconds)),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('${widget.name}'),
          ),
        ),
        body: Column(
          children: [
            Expanded(child: _buildCounter(context)),
            Flexible(
              child: _buildLapDisplay(),
              flex: 2,
            )
          ],
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }
}
