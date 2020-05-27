import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class CLERModel {
  bool get loading;

  bool get hasData;

  String get error;

  Future<void> updateContents();
}

typedef CLERWidgetBuilder<T> = Function(BuildContext context, T model);

class CLERBuilder<T extends CLERModel> extends StatelessWidget {
  final T model;

  final CLERWidgetBuilder contentBuilder;

  const CLERBuilder({Key key, this.model, this.contentBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.error != null) {
      return CoveringErrorContainer.fromModel(model);
    }

    if (model.loading) {
      return CoveringLoadingContainer();
    }

    return contentBuilder(context, model);
  }
}

class CoveringErrorContainer extends StatelessWidget {
  final bool loading;
  final String errorMessage;
  final VoidCallback onRetrySelected;

  const CoveringErrorContainer({
    Key key,
    this.loading,
    this.errorMessage,
    this.onRetrySelected,
  }) : super(key: key);

  factory CoveringErrorContainer.fromModel(CLERModel model) => CoveringErrorContainer(
        errorMessage: model.error,
        onRetrySelected: model.updateContents,
        loading: model.loading,
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Ooops', textAlign: TextAlign.center, style: theme.textTheme.headline3),
        SizedBox(height: 8),
        Text(errorMessage, textAlign: TextAlign.center),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text(loading ? 'Loading' : 'Retry'),
              onPressed: loading ? null : onRetrySelected,
              color: Colors.blue,
            ),
          ],
        )
      ],
    );
  }
}

class CoveringLoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
