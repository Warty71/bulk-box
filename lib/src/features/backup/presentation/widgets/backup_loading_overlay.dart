import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bulk_box/src/core/constants/dimensions.dart';

const _importMessages = [
  'Bro, these cards are kinda sus 👀',
  'Summoning your collection from the Shadow Realm 🌑',
  'Did you really need 3 copies of that? 🤔',
  'Heart of the Cards: engaged ❤️',
  'These prices are actually insane 💸',
  'Checking for counterfeit holo swirls 🔍',
  'Blue-Eyes spotted in the wild 🐉',
  'Hope you didn\'t sleeve these in penny sleeves 😤',
  'Not a coincidence, it\'s skill. Trust. 🎯',
  'Activating Pot of Greed... drawing 2 cards 🏺',
];

const _exportMessages = [
  'Packing your cards very carefully 📦',
  'Writing "DO NOT BEND" on the envelope ✉️',
  'One last look before they go...',
  'This collection better be insured 💰',
  'Sealing the deck box with extra tape 🔒',
  'Telling your cards they\'re going on a trip 🧳',
];

class BackupLoadingOverlay extends StatefulWidget {
  const BackupLoadingOverlay.importing({super.key})
      : title = 'Importing…',
        messages = _importMessages;

  const BackupLoadingOverlay.exporting({super.key})
      : title = 'Exporting…',
        messages = _exportMessages;

  final String title;
  final List<String> messages;

  @override
  State<BackupLoadingOverlay> createState() => _BackupLoadingOverlayState();
}

class _BackupLoadingOverlayState extends State<BackupLoadingOverlay> {
  late int _index;
  late final List<String> _shuffled;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _shuffled = List.of(widget.messages)..shuffle();
    _index = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 2200), (_) {
      setState(() => _index = (_index + 1) % _shuffled.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusLg),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.xl,
              vertical: Dimensions.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: colorScheme.primary),
                const SizedBox(height: Dimensions.md),
                Text(
                  widget.title,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: Dimensions.sm),
                SizedBox(
                  width: 240,
                  height: 44,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    ),
                    child: Text(
                      _shuffled[_index],
                      key: ValueKey(_index),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
