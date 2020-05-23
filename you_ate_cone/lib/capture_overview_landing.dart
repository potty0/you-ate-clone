import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CaptureOverviewLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final offTrack = index % 2 == 0;

          final prevOffTrack = index == 0 ? null : !offTrack;
          final nextOffTrack = index == 99 ? null : !offTrack;

          return CaptureItem(
            offTrack: index % 2 == 0,
            previousOffTrack: prevOffTrack,
            nextOffTrack: nextOffTrack,
          );
        },
        separatorBuilder: (context, index) => Divider(thickness: 0, height: 0),
        itemCount: 100,
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
      height: 125.0 + 16 * 2,
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
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        _buildTopCurve(),
        _buildBottomCurve(),
      ]),
      _buildImage(),
    ]);
  }

  Widget _buildTopCurve() {
    PathState state = PathState.kept;
    if (previousOffTrack != null && previousOffTrack != offTrack) {
      state = offTrack ? PathState.opening : PathState.closing;
    }

    return Container(
      height: 16,
      color: Colors.yellow,
      child: CustomPaint(painter: _OffRoutePathPainter(top: true, state: state)),
    );
  }

  Widget _buildBottomCurve() {
    PathState state = PathState.kept;
    if (nextOffTrack != null && nextOffTrack != offTrack) {
      state = offTrack ? PathState.opening : PathState.closing;
    }

    return Container(
      height: 16,
      color: Colors.yellow,
      child: CustomPaint(painter: _OffRoutePathPainter(top: false, state: state)),
    );
  }

  Widget _buildStraightTrackPath() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 4, color: Colors.grey[300]),
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

enum PathState { opening, closing, kept }

class _OffRoutePathPainter extends CustomPainter {
  final bool top;
  final double offset;
  final PathState state;

  _OffRoutePathPainter({this.top = true, this.state = PathState.kept, this.offset = 30});

  @override
  void paint(Canvas canvas, Size size) {
    print('_OffRoutePathPainter paint:$size');

    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    Path path = Path();

    path.moveTo(size.width / 2, 0);

    final c0x = 0.0;
    final c0y = size.height * 0.75;

    final c1x = -offset;
    final c1y = size.height * 0.25;

    final bx = -offset;
    final by = size.height;

    path.cubicTo(c0x, c0y, c1x, c1y, bx, by);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_OffRoutePathPainter oldDelegate) => oldDelegate.top != top;
}
