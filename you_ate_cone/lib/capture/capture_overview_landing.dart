import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youatecone/capture/capture.dart';
import 'package:youatecone/capture/capture_detials.dart';
import 'package:youatecone/capture/capture_list.dart';
import 'package:youatecone/capture/capture_overview_landing_view_model.dart';
import 'package:youatecone/main.dart';
import 'package:youatecone/services/login_assistant.dart';
import 'package:youatecone/utils/cler_builder.dart';

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
      contentBuilder: (context, model) {
        return CaptureList(
          listItems: _model.itemDescriptions,
          onCaptureSelected: (capture) => _onCaptureSelected(context, capture),
        );
      },
    );
  }

  Future<void> _onCaptureSelected(BuildContext context, Capture capture) async {
    final assistant = LoginService.of(context);

    if (assistant.loggedIn || true) {
      final dialog = CupertinoAlertDialog(
        title: Text('Some title'),
        content: Text('Some text indicating the content'),
        actions: [
          CupertinoDialogAction(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );

      showCupertinoDialog(context: context, builder: (context) => dialog);
    } else {
      final route = MaterialPageRoute(builder: (context) => CaptureDetails(), fullscreenDialog: true);
      Navigator.of(context).push(route);
    }
  }
}
