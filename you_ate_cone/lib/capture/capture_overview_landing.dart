import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youatecone/you_ate_theme.dart';

const _CaptureImageSize = Size(125, 125);
const double _PathHeight = 32;
const double _PathWidth = 4;
const double _OffTrackOffset = 30;

class CaptureOverviewLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [false, true, true, false, false, true, true, false, false];
    final itemCount = items.length;

    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final offTrack = items[index];

          final prevOffTrack = index == 0 ? null : items[index - 1];
          final nextOffTrack = index == itemCount - 1 ? null : items[index + 1];

          return CaptureItem(
            offTrack: offTrack,
            previousOffTrack: prevOffTrack,
            nextOffTrack: nextOffTrack,
          );
        },
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
      _buildStraightTrack(offTrack: false),
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

    if (previousOffTrack == offTrack && !offTrack) return Container();

    Widget pathComponent;

    if (previousOffTrack == offTrack && offTrack) {
      pathComponent = _buildStraightTrack(offTrack: true);
    } else {
      bool opening = (previousOffTrack != offTrack && !previousOffTrack);
      pathComponent = CustomPaint(painter: _OffRouteCurvedPathPainter(top: true, opening: opening));
    }

    return SizedBox(
      height: _PathHeight / 2,
      child: pathComponent,
    );
  }

  Widget _buildBottomPathSegment() {
    if (nextOffTrack == null) return Container();

    if (nextOffTrack == offTrack && !offTrack) return Container();

    Widget pathComponent;

    if (nextOffTrack == offTrack && offTrack) {
      pathComponent = _buildStraightTrack(offTrack: true);
    } else {
      bool opening = (nextOffTrack != offTrack && nextOffTrack);
      pathComponent = CustomPaint(painter: _OffRouteCurvedPathPainter(top: false, opening: opening));
    }

    return SizedBox(
      height: _PathHeight / 2,
      child: pathComponent,
    );
  }

  Widget _buildStraightTrack({bool offTrack}) {
    final color = offTrack ? ColorPalette.sandyBrown : ColorPalette.mercury;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: EdgeInsets.only(right: offTrack ? _OffTrackOffset * 2 : 0),
        child: Container(width: _PathWidth, color: color),
      ),
    ]);
  }

  Widget _buildImage() {
    final double padding = offTrack ? _OffTrackOffset * 2 : 0;

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
              boxShadow: [BoxShadow(blurRadius: 16, color: Colors.black38)],
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

class _OffRouteCurvedPathPainter extends CustomPainter {
  final bool top;
  final double offset;
  final bool opening;

  final Color startColor;
  final Color endColor;

  _OffRouteCurvedPathPainter({
    this.startColor = ColorPalette.bananaMania,
    this.endColor = ColorPalette.sandyBrown,
    @required this.top,
    @required this.opening,
    this.offset = _OffTrackOffset,
  });

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

    final a = opening ? startColor : endColor;
    final b = opening ? endColor : startColor;

    final gradient = LinearGradient(
      colors: [a, b],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      tileMode: TileMode.repeated,
    );

    final shader = gradient.createShader(Offset.zero & Size(0, _PathHeight));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _PathWidth
      ..shader = shader;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_OffRouteCurvedPathPainter oldDelegate) => oldDelegate.top != top;
}
