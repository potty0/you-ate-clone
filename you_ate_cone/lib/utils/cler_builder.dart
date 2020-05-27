import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class CLERModel {
  bool get loading;

  bool get hasData;

  bool get hasError;

  String get error;

  Future<void> updateContents();
}

typedef CLERWidgetBuilder<T>(BuildContext context, T model);

class CLERBuilder<T extends CLERModel> extends StatelessWidget {
  final T model;

  final CLERWidgetBuilder<T> contentBuilder;
  final CLERWidgetBuilder<T> loadingBuilder;
  final CLERWidgetBuilder<T> errorBuilder;

  const CLERBuilder({
    Key key,
    this.model,
    this.contentBuilder,
    this.loadingBuilder,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.hasError) {
      final builder = errorBuilder ?? (context, m) => CoveringErrorIndicator.fromModel(model);
      return builder(context, model);
    }

    if (model.loading && !model.hasData) {
      final builder = loadingBuilder ?? (context, m) => CoveringLoadingIndicator();
      return builder(context, model);
    }

    return contentBuilder(context, model);
  }
}

class CoveringLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class CoveringErrorIndicator extends StatelessWidget {
  final bool loading;
  final String error;
  final VoidCallback onRetrySelected;

  const CoveringErrorIndicator({Key key, this.loading, this.error, this.onRetrySelected}) : super(key: key);

  factory CoveringErrorIndicator.fromModel(CLERModel model) {
    return CoveringErrorIndicator(
      loading: model.loading,
      onRetrySelected: model.updateContents,
      error: model.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Ooops', style: theme.textTheme.headline3, textAlign: TextAlign.center),
        Text(error, style: theme.textTheme.bodyText1, textAlign: TextAlign.center),
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          MaterialButton(
            color: Colors.blue,
            onPressed: loading ? null : onRetrySelected,
            child: Text(loading ? 'Loading' : 'Retry'),
          ),
        ])
      ],
    );
  }
}
