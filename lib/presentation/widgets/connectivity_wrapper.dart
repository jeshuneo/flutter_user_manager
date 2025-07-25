import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        final isOffline = snapshot.data == ConnectivityResult.none;

        return Stack(
          children: [
            child,
            if (isOffline)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(8),
                  child: const Text(
                    'No Internet Connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
