import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CounterModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    // First, increment the counter
    _counter++;

    // Then notify all the listeners.
    notifyListeners();
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CounterModel>(
      model: CounterModel(),
      child: ScopedModelDescendant<CounterModel>(
        rebuildOnChange: false,
        builder: (context, child, model) => Container(
          child: _buildCounterModelContents(context),
        ),
      ),
    );
  }

  Widget _buildCounterModelContents(BuildContext context) {
    print('current count:${ScopedModel.of<CounterModel>(context).counter}');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScopedModelDescendant<CounterModel>(
          builder: (context, child, model) => Text('${model.counter}'),
        ),
        Text("Another widget that doesn't depend on the CounterModel"),
        ScopedModelDescendant<CounterModel>(
          builder: (context, child, model) => MaterialButton(
            onPressed: model.increment,
            child: Text('increment'),
          ),
        ),
      ],
    );
  }
}
