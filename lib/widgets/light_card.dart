import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/light_provider.dart';

class LightCard extends StatelessWidget {
  const LightCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LightProvider>();
    final light = provider.light!;

    return Container(
      width: 420,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: provider.toggle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: light.on
                    ? [
                        BoxShadow(
                          color: Colors.amber.withOpacity(.6),
                          blurRadius: 40,
                          spreadRadius: 10,
                        )
                      ]
                    : [],
              ),
              child: Icon(
                Icons.lightbulb,
                size: 120,
                color: light.on
                    ? Colors.amber
                    : Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            light.name,
            style: Theme.of(context)
                .textTheme
                .headlineMedium,
          ),

          const SizedBox(height: 12),

          Text(
            light.on
                ? '${((light.brightness / 255) * 100).round()} %'
                : 'AUS',
            style: Theme.of(context)
                .textTheme
                .titleLarge,
          ),

          const SizedBox(height: 24),

          Slider(
            value: light.brightness.toDouble(),
            min: 0,
            max: 255,
            onChanged: light.on
                ? provider.setBrightness
                : null,
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                size: 12,
                color: light.reachable
                    ? Colors.green
                    : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                light.reachable
                    ? 'Erreichbar'
                    : 'Nicht erreichbar',
              ),
            ],
          ),
        ],
      ),
    );
  }
}