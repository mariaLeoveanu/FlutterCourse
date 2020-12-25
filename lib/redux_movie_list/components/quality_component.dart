import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/redux_movie_list/actions/actions.dart';
import 'package:project1/redux_movie_list/model/model.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class QualityContainer extends StatelessWidget {
  const QualityContainer(this.store);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, QualityModel>(
      converter: (Store<AppState> store) => QualityModel.fromStore(store),
      builder: (BuildContext context, QualityModel model) {
        return DropdownButton<String>(
            value: store.state.quality,
            items: <String>['All', '720p', '1080p', '2160p', '3D']
                .map((String value) => DropdownMenuItem<String>(child: Text(value), value: value))
                .toList(),
            onChanged: (String selectedValue) {
              store.dispatch(UpdateQuality(selectedValue));
              store.dispatch(GetMoviesAction(store.state.currentPage));
            });
      },
    );
  }
}

class QualityModel {
  QualityModel(this.quality);

  String quality;

  static QualityModel fromStore(Store<AppState> store) {
    return QualityModel(store.state.quality);
  }
}
