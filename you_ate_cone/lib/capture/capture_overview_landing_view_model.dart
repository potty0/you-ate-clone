import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:youatecone/capture/capture.dart';
import 'package:youatecone/content/cler_content.dart';
import 'package:youatecone/services/you_ate_api.dart';

bool _didThrow = false;

class CaptureDaySummary {
  final List<Capture> captures;

  final DateTime day;
  final double onTrackPercentage;

  int get numberOfMeals => captures.length;

  CaptureDaySummary({this.captures, this.day, this.onTrackPercentage});

  @override
  String toString() => '${day.year}.${day.month}.${day.day} on track:${onTrackPercentage * 100}% captures:$captures';
}

class NeighbourAwareCaptureItem {
  final Capture capture;
  final bool prevOffTrack;
  final bool nextOffTrack;

  NeighbourAwareCaptureItem({this.capture, this.prevOffTrack, this.nextOffTrack});
}

enum CaptureItemType { capture, summary }

class CaptureItemDesc {
  final CaptureItemType type;

  final dynamic item;

  NeighbourAwareCaptureItem get capture => item as NeighbourAwareCaptureItem;

  CaptureDaySummary get summary => item as CaptureDaySummary;

  CaptureItemDesc(this.type, this.item);

  factory CaptureItemDesc.fromCapture(NeighbourAwareCaptureItem capture) =>
      CaptureItemDesc(CaptureItemType.capture, capture);

  factory CaptureItemDesc.fromSummary(CaptureDaySummary summary) => CaptureItemDesc(CaptureItemType.summary, summary);
}

class CaptureOverviewLandingViewModel extends ChangeNotifier with CLERModel {
  final YouAteApi api;

  CaptureOverviewLandingViewModel({@required this.api});

  @override
  bool get loading => _loading;

  @override
  String get error => _error;

  @override
  bool get hasData => captures.isNotEmpty;

  List<Capture> get captures => _captures ?? [];

  List<CaptureItemDesc> get itemDescriptions => _itemDescriptions;

  List<Capture> _captures;
  List<CaptureItemDesc> _itemDescriptions;

  bool _loading = false;
  String _error;

  Future<void> updateContents() async {
    if (_captures != null) return;
    _setLoadingAndNotify(true);

    try {
      _captures = await api.getCaptures();
      final summaries = _calculateDaySummaries(_captures);

      _itemDescriptions = _buildCaptureItemList(summaries);
      _error = null;
    } catch (e) {
      _itemDescriptions = null;
      _error = 'Could not get captures. Please try again later.';
    } finally {
      _setLoadingAndNotify(false);
    }
  }

  List<CaptureDaySummary> _calculateDaySummaries(List<Capture> captures) {
    if (captures.isEmpty) return [];

    List<CaptureDaySummary> summaries = [];

    final capture = captures.first;
    DateTime referenceDay = capture.timestamp;
    List<Capture> capturesOnCurrentDay = [capture];

    CaptureDaySummary createSummaryFromCurrentState() {
      final onTrackPercentage = _calculateOnTrackPercentage(capturesOnCurrentDay);
      return CaptureDaySummary(
        captures: List<Capture>.from(capturesOnCurrentDay),
        day: DateTime(referenceDay.year, referenceDay.month, referenceDay.day),
        onTrackPercentage: onTrackPercentage,
      );
    }

    for (int i = 1; i < captures.length; ++i) {
      final c = captures[i];
      final sameDay = _onSameDay(c.timestamp, referenceDay);

      if (sameDay) {
        capturesOnCurrentDay.add(c);
      } else {
        final summary = createSummaryFromCurrentState();
        summaries.add(summary);

        capturesOnCurrentDay.clear();
        capturesOnCurrentDay.add(c);
        referenceDay = c.timestamp;
      }
    }

    if (capturesOnCurrentDay.isNotEmpty) {
      final summary = createSummaryFromCurrentState();
      summaries.add(summary);
    }

    return summaries;
  }

  double _calculateOnTrackPercentage(List<Capture> captures) {
    if (captures.isEmpty) return 0;

    final onTrackCount = captures.where((c) => !c.offTrack).length;
    return onTrackCount / captures.length;
  }

  List<CaptureItemDesc> _buildCaptureItemList(List<CaptureDaySummary> summaries) {
    List<CaptureItemDesc> items = [];

    summaries.forEach((summary) {
      items.add(CaptureItemDesc.fromSummary(summary));

      List<NeighbourAwareCaptureItem> captures = [];
      final itemCount = summary.captures.length;

      for (int i = 0; i < summary.captures.length; ++i) {
        final capture = summary.captures[i];

        final prevOffTrack = i == 0 ? null : summary.captures[i - 1].offTrack;
        final nextOffTrack = i == itemCount - 1 ? null : summary.captures[i + 1].offTrack;

        final neighbourAwareCapture = NeighbourAwareCaptureItem(
          capture: capture,
          prevOffTrack: prevOffTrack,
          nextOffTrack: nextOffTrack,
        );
        captures.add(neighbourAwareCapture);
      }

      items.addAll(captures.map((c) => CaptureItemDesc.fromCapture(c)));
    });

    return items;
  }

  void _setLoadingAndNotify(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}

bool _onSameDay(DateTime a, DateTime b) {
  return a.day == b.day && a.month == b.month && a.year == b.year;
}
