import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/light_provider.dart';
import '../widgets/light_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LightProvider>();

    return Scaffold(
      body: Center(
        child: provider.loading
            ? const CircularProgressIndicator()
            : provider.light == null
                ? const Text('Keine Lampe gefunden')
                : LightCard(),
      ),
    );
  }
}