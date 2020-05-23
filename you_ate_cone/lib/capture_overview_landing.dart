import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CaptureOverviewLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemBuilder: (context, index) => CaptureItem(
          offTrack: index % 2 == 0,
        ),
        separatorBuilder: (context, index) => Divider(thickness: 0, height: 0),
        itemCount: 100,
      ),
    );
  }
}

class CaptureItem extends StatelessWidget {
  final bool offTrack;

  const CaptureItem({Key key, this.offTrack = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(flex: 2, child: Container()),
          Flexible(flex: 5, child: buildCapture()),
          Flexible(flex: 2, child: _buildTimeIndicator()),
        ],
      ),
    );
  }

  Widget buildCapture() {
    return Stack(fit: StackFit.expand, children: [
      _buildStraightPath(),
      _buildImage(),
    ]);
  }

  Widget _buildStraightPath() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 8, color: Colors.grey[300]),
    ]);
  }

  Widget _buildImage() {
    const double offTrackOffset = 40;
    final double padding = offTrack ? offTrackOffset * 2 : 0;

    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(right: padding),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
              boxShadow: [BoxShadow(blurRadius: 20, spreadRadius: 1, color: Colors.black45)],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Text('HH:mm', textAlign: TextAlign.right),
        )
      ],
    );
  }
}
