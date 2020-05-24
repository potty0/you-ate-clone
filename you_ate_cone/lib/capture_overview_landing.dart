import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _CaptureImageSize = Size(125, 125);
const double _PathHeight = 32;
const double _PathWidth = 4;

class CaptureOverviewLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemCount = 3;

    return Container(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final offTrack = index % 2 != 0;

          final prevOffTrack = index == 0 ? null : !offTrack;
          final nextOffTrack = index == itemCount - 1 ? null : !offTrack;

          return CaptureItem(
            offTrack: offTrack,
            previousOffTrack: prevOffTrack,
            nextOffTrack: nextOffTrack,
          );
        },
        separatorBuilder: (context, index) => Divider(thickness: 0, height: 0),
        itemCount: itemCount,
      ),
    );
  }
}

class CaptureItem extends StatelessWidget {
  final bool offTrack;
  final bool previousOffTrack;
  final bool nextOffTrack;

  const CaptureItem({
    Key key,
    this.offTrack = false,
    this.previousOffTrack = false,
    this.nextOffTrack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _CaptureImageSize.height + _PathHeight,
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
      _buildStraightTrackPath(),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTopPathSegment(),
          _buildBottomPathSegment(),
        ],
      ),
      _buildImage(),
    ]);
  }

  Widget _buildTopPathSegment() {
    if (previousOffTrack == null) return Container();

    bool opening = (previousOffTrack != offTrack && !previousOffTrack);

    return SizedBox(
      height: _PathHeight / 2,
      child: CustomPaint(painter: _OffRouteCurvedPathPainter(top: true, opening: opening)),
    );
  }

  Widget _buildBottomPathSegment() {
    if (nextOffTrack == null) return Container();

    bool opening = (nextOffTrack != offTrack && nextOffTrack);

    return SizedBox(
      height: _PathHeight / 2,
      child: CustomPaint(painter: _OffRouteCurvedPathPainter(top: false, opening: opening)),
    );
  }

  Widget _buildStraightTrackPath() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: _PathWidth, color: Colors.grey[300]),
    ]);
  }

  Widget _buildImage() {
    const double offTrackOffset = 30;
    final double padding = offTrack ? offTrackOffset * 2 : 0;

    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(right: padding),
          child: Container(
            width: _CaptureImageSize.width,
            height: _CaptureImageSize.width,
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

enum PathState { opening, closing, kept }

class _OffRouteCurvedPathPainter extends CustomPainter {
  final bool top;
  final double offset;
  final bool opening;

  _OffRouteCurvedPathPainter({@required this.top, @required this.opening, this.offset = 30});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    Path path = Path();

    double start = size.width / 2;
    double dx = -offset;

    const double h = _PathHeight;

    if (!opening) {
      start = (size.width / 2) - offset;
      dx = offset;
    }

    canvas.translate(0, top ? -h / 2 : 0);

    path.moveTo(start, 0);

    final c0x = start;
    final c0y = h * 0.75;

    final c1x = start + dx;
    final c1y = h * 0.25;

    final bx = start + dx;
    final by = h;

    path.cubicTo(c0x, c0y, c1x, c1y, bx, by);

    Color a;
    Color b;

    if (top) {
      a = opening ? Colors.yellow : Colors.red;
      b = opening ? Colors.red : Colors.yellow;
    } else {
      a = opening ? Colors.yellow : Colors.red;
      b = opening ? Colors.red : Colors.yellow;
    }

    final gradient = LinearGradient(
      colors: [a, b],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.repeated,
    );

    final shader = gradient.createShader(Offset(start + dx, 0) & Size(0, _PathHeight));

    final paint = Paint()
      ..color = top ? Colors.blue : Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = _PathWidth
      ..shader = shader;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_OffRouteCurvedPathPainter oldDelegate) => oldDelegate.top != top;
}
