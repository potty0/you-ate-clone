import 'package:flutter/cupertino.dart';
import 'package:youatecone/capture/capture_attributes.dart';
import 'package:youatecone/services/you_ate_api.dart';

class CaptureDetailsViewModel extends ChangeNotifier {
  final YouAteApi api;

  bool get loading => _loading;

  List<CaptureAttributeOption> get options => _options ?? [];

  List<CaptureAttributeOption> _options;
  bool _loading = false;

  CaptureDetailsViewModel({this.api});

  Future<void> updateContents() async {
    if (_options != null || _loading) return;

    _setLoadingAndNotify(true);

    _options = await api.getCaptureAttributeOptions();

    _setLoadingAndNotify(false);
  }

  void _setLoadingAndNotify(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}
