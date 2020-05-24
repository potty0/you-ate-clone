import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youatecone/capture/capture.dart';
import 'package:youatecone/capture/capture_detials.dart';
import 'package:youatecone/capture/capture_list.dart';
import 'package:youatecone/capture/capture_overview_landing_view_model.dart';

class CaptureOverviewLanding extends StatefulWidget {
  @override
  _CaptureOverviewLandingState createState() => _CaptureOverviewLandingState();
}

class _CaptureOverviewLandingState extends State<CaptureOverviewLanding> {
  CaptureOverviewLandingViewModel _model = CaptureOverviewLandingViewModel();

  @override
  void initState() {
    _model.addListener(_updateContents);
    _model.updateContents();

    super.initState();
  }

  @override
  void dispose() {
    _model.removeListener(_updateContents);
    super.dispose();
  }

  void _updateContents() => setState(() {});

  @override
  Widget build(BuildContext context) {
    if (_model.loading) return _buildLoadingIndicator();

    return Container(
      child: CaptureList(
        listItems: _model.itemDescriptions,
        onCaptureSelected: (capture) => _onCaptureSelected(context, capture),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  void _onCaptureSelected(BuildContext context, Capture capture) {
    final route = MaterialPageRoute(builder: (context) => CaptureDetails(), fullscreenDialog: true);
    Navigator.of(context).push(route);
  }
}
