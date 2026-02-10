import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:bulk_box/src/features/ygo_cards/data/services/archetype_backfill_service.dart';

class SyncPill extends StatefulWidget {
  const SyncPill({super.key});

  @override
  State<SyncPill> createState() => _SyncPillState();
}

class _SyncPillState extends State<SyncPill> {
  bool _visible = false;
  bool _done = false;
  int _current = 0;
  int _total = 0;

  @override
  void initState() {
    super.initState();
    _runBackfill();
  }

  Future<void> _runBackfill() async {
    final service = GetIt.instance<ArchetypeBackfillService>();

    var hasWork = false;

    await service.backfill(
      onProgress: (done, total) {
        if (!hasWork) {
          hasWork = true;
          // Wait one frame so the widget renders off-screen first,
          // enabling the slide-in animation.
          Future.delayed(const Duration(milliseconds: 50), () {
            if (mounted) setState(() => _visible = true);
          });
        }
        if (mounted) {
          setState(() {
            _current = done;
            _total = total;
          });
        }
      },
    );

    if (hasWork && mounted) {
      setState(() => _done = true);
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) setState(() => _visible = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedSlide(
      offset: _visible ? Offset.zero : const Offset(0.0, -2.0),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 350),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _done
                ? [
                    Icon(Icons.check_circle,
                        size: 16, color: theme.colorScheme.primary),
                    const SizedBox(width: 6),
                    Text('Chain resolved!',
                        style: theme.textTheme.labelSmall),
                  ]
                : [
                    SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _total > 0
                          ? 'Resolving card effects... $_current/$_total'
                          : 'Resolving card effects...',
                      style: theme.textTheme.labelSmall,
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
