import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:youatecone/capture/capture_attributes.dart';
import 'package:youatecone/capture/capture_detials_view_model.dart';
import 'package:youatecone/main.dart';

class CaptureDetails extends StatefulWidget {
  @override
  _CaptureDetailsState createState() => _CaptureDetailsState();
}

class _CaptureDetailsState extends State<CaptureDetails> {
  CaptureDetailsViewModel _model = CaptureDetailsViewModel(api: youAteApi);

  @override
  void initState() {
    _model.updateContents();
    _model.addListener(_onModelUpdated);

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
    return Scaffold(
      appBar: _buildHeader(context),
      body: SingleChildScrollView(child: _buildContents(context)),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return AppBar(
      title: Text('Capture'),
      leading: IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
    );
  }

  Widget _buildContents(BuildContext context) {
    if (_model.loading) _buildLoadingIndicator();

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
        child: CaptureAttributeSelector(option: _model.options[index]),
      ),
      itemCount: _model.options.length,
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(child: CircularProgressIndicator());
  }
}

class CaptureAttributeSelector extends StatefulWidget {
  final CaptureAttributeOption option;

  const CaptureAttributeSelector({Key key, this.option}) : super(key: key);

  @override
  _CaptureAttributeSelectorState createState() => _CaptureAttributeSelectorState();
}

class _CaptureAttributeSelectorState extends State<CaptureAttributeSelector> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final answers = widget.option.answers.map((a) => _buildAnswer(a)).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(widget.option.question),
      SizedBox(height: 8),
      Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(8),
        child: Wrap(children: answers, spacing: 8, runSpacing: 8),
      ),
    ]);
  }

  Widget _buildAnswer(String answer) {
    return AnimatedSelection(child: Chip(label: Text(answer)));
  }
}

class AnimatedSelection extends StatefulWidget {
  final Widget child;

  const AnimatedSelection({Key key, this.child}) : super(key: key);

  @override
  _AnimatedSelectionState createState() => _AnimatedSelectionState();
}

class _AnimatedSelectionState extends State<AnimatedSelection> with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 100))
      ..addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation curve = CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut);
    final animation = Tween<double>(begin: 1.0, end: 1.25).animate(curve);

    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      child: Transform.scale(scale: animation.value, child: widget.child),
    );
  }
}
