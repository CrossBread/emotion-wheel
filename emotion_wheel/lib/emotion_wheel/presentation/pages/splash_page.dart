import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final Future<void> Function() onLoad;

  final VoidCallback onLoadComplete;

  const SplashPage({super.key, required this.onLoad, required this.onLoadComplete});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Loading...', style: Theme.of(context).textTheme.headlineLarge),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: LinearProgressIndicator(minHeight: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.onLoad().then((value) => widget.onLoadComplete());
  }
}
