import 'dart:async';
import 'dart:collection';

/// Simple rate limiter that ensures requests don't exceed a rate limit
class RateLimiter {
  final int maxRequests;
  final Duration timeWindow;
  final Queue<DateTime> _requestTimes = Queue<DateTime>();

  RateLimiter({
    required this.maxRequests,
    required this.timeWindow,
  });

  /// Waits if necessary to respect rate limit, then records the request
  Future<void> waitIfNeeded() async {
    final now = DateTime.now();

    // Remove old request times outside the time window
    while (_requestTimes.isNotEmpty &&
        now.difference(_requestTimes.first) >= timeWindow) {
      _requestTimes.removeFirst();
    }

    // If we're at the limit, wait until we can make another request
    if (_requestTimes.length >= maxRequests) {
      final oldestRequest = _requestTimes.first;
      final waitTime = timeWindow - now.difference(oldestRequest);
      if (waitTime > Duration.zero) {
        await Future.delayed(waitTime);
        // Remove the oldest after waiting
        _requestTimes.removeFirst();
      }
    }

    // Record this request
    _requestTimes.add(DateTime.now());
  }
}
