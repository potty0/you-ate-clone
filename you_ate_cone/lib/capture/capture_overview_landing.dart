import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youatecone/capture/capture.dart';
import 'package:youatecone/capture/capture_detials.dart';
import 'package:youatecone/capture/capture_list.dart';
import 'package:youatecone/capture/capture_overview_landing_view_model.dart';
import 'package:youatecone/content/cler_content.dart';
import 'package:youatecone/main.dart';

class CaptureOverviewLanding extends StatefulWidget {
  @override
  _CaptureOverviewLandingState createState() => _CaptureOverviewLandingState();
}

class _CaptureOverviewLandingState extends State<CaptureOverviewLanding> {
  CaptureOverviewLandingViewModel _model = CaptureOverviewLandingViewModel(api: youAteApi);

  @override
  void initState() {
    _model.addListener(_onModelUpdated);
    _model.updateContents();

    super.initState();
  }

  @override
  void dispose() {
    _model.removeListener(_onModelUpdated);
    super.dispose();
  }

  void _onModelUpdated() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return CLERBuilder(
      model: _model,
      contentBuilder: (context, model) => CaptureList(
        listItems: model.itemDescriptions,
        onCaptureSelected: (capture) => _onCaptureSelected(context, capture),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _onCaptureSelected(BuildContext context, Capture capture) async {
    final route = MaterialPageRoute(builder: (context) => CaptureDetails(), fullscreenDialog: true);
    Navigator.of(context).push(route);
  }
}
