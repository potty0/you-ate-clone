import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youatecone/capture/capture_attributes.dart';
import 'package:youatecone/capture/capture_details_view_model.dart';
import 'package:youatecone/content/cler_content.dart';

class CaptureDetails extends StatefulWidget {
  @override
  _CaptureDetailsState createState() => _CaptureDetailsState();
}

class _CaptureDetailsState extends State<CaptureDetails> {
  CaptureDetailsViewModel _model = CaptureDetailsViewModel();

  @override
  void initState() {
    _model.addListener(_onModelUpdated);
    _model.updateContents();

    super.initState();
  }

  void _onModelUpdated() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        elevation: 12,
        leading: IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
        title: Text('Details'),
      ),
      body: CLERBuilder<CaptureDetailsViewModel>(
        model: _model,
        contentBuilder: (context, model) => _buildContents(context, model.sections),
      ),
    );
  }

  Widget _buildContents(BuildContext context, List<CaptureAttributeOption> sections) {
    return ListView.builder(
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(top: 8, bottom: 16),
        child: _buildSection(context, _model.sections[index]),
      ),
      itemCount: _model.sections.length,
    );
  }

  Widget _buildSection(BuildContext context, CaptureAttributeOption section) {
//    final item = section.answers.map((a) => Chip(label: Text(a))).toList();

    final items = List.generate(section.answers.length, (index) {
      return AnimatedSelection(
        onSelected: () => print('selected'),
        child: Chip(label: Text(section.answers[index])),
      );
    });

    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(blurRadius: 16, color: Colors.black26)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(section.question, style: theme.textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold)),
          Wrap(children: items, spacing: 8, runSpacing: 0),
        ],
      ),
    );
  }
}

class AnimatedSelection extends StatefulWidget {
  final VoidCallback onSelected;
  final Widget child;

  const AnimatedSelection({Key key, this.onSelected, this.child}) : super(key: key);

  @override
  _AnimatedSelectionState createState() => _AnimatedSelectionState();
}

class _AnimatedSelectionState extends State<AnimatedSelection> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Animation curve = CurvedAnimation(parent: _controller, curve: Curves.elasticInOut);
    final scaleAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(curve);

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: Transform.scale(scale: scaleAnimation.value, child: widget.child),
    );
  }
}
