import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youatecone/capture/capture_list.dart';

class CaptureOverviewLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: CaptureList(captures: []));
  }
}
