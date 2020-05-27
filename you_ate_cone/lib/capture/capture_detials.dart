import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    final listOfOptions = _model.options.map((s) => s.answers);
    final allOptions = listOfOptions.expand((q) => q).toList();

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

class CaptureAttributeSelector extends StatelessWidget {
  final CaptureAttributeOption option;

  const CaptureAttributeSelector({Key key, this.option}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final answers = option.answers.map((a) => _buildAnswer(a)).toList();
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(option.question),
      SizedBox(height: 8),
      Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(8),
        child: Wrap(children: answers, spacing: 8, runSpacing: 8),
      ),
    ]);
  }

  Widget _buildAnswer(String answer) {
    return Chip(label: Text(answer));

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.green,
      ),
      child: Text(answer),
    );
  }
}
