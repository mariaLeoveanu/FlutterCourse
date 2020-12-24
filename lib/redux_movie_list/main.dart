import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project1/redux_movie_list/actions/actions.dart';
import 'package:project1/redux_movie_list/components/quality_component.dart';
import 'package:project1/redux_movie_list/model/model.dart';
import 'package:project1/redux_movie_list/middleware/middleware.dart';
import 'package:project1/redux_movie_list/redux/reducers.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project1/redux_movie_list/components/movie_list_component.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = Store<AppState>(appReducer,
        middleware: <dynamic Function(Store<AppState>, dynamic, dynamic Function(dynamic))>[appStateMiddleware],
        initialState: AppState.initialState());

    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: StoreBuilder<AppState>(
              //onInit: (Store<AppState> store) => store.dispatch(GetMoviesAction(store.state.currentPage)),
              builder: (BuildContext context, Store<AppState> store) => MyHomePage(store)),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage(this.store);

  final Store<AppState> store;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(store.state.currentPage.toString()),
        ),
        body: StoreConnector<AppState, MovieListModel>(
          converter: (Store<AppState> store) => MovieListModel.fromStore(store),
          builder: (BuildContext buildContext, MovieListModel model) => Container(
              child: Column(
            children: <Widget>[
              QualityContainer(store),
              Expanded(child: MovieListContainer(store)),
              RaisedButton(
                onPressed: () => store.dispatch(GetMoviesAction(store.state.currentPage)),
                child: const Text('Load Movies'),
              )
            ],
          )),
        ));
  }
}
