import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:location_tracking_new/providers/location_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentPosition = ref.watch(positionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocator Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            currentPosition.when(
              data: (data) {
                return Column(
                  children: [
                    Text(
                      'Your current latitude is: ${data?.latitude}',
                    ),
                    Text(
                      'Your current longitude is: ${data?.longitude}',
                    )
                  ],
                );
              },
              error: (error, stackTrace) {
                debugPrint("$error");
                return Container();
              },
              loading: () => Container(),
            )
          ],
        ),
      ),
    );
  }
}
