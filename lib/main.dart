import 'package:firestoreblocapp/tip_bloc.dart';
import 'package:firestoreblocapp/tip_repository.dart';
import 'package:firestoreblocapp/tip_row.dart';
import 'package:firestoreblocapp/tip_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Demo app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider<TipRepository>(
        create: (context) =>
        TipRepositoryMemory()
          ..refresh(),
        child: BlocProvider(
            create: (context) => TipBloc(RepositoryProvider.of(context)),
            child: MyHomePage(title: 'Flutter Demo Home Page')),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TipBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, data) {
            if (data is TipLoadingState) {
              return CircularProgressIndicator();
            } else if (data is TipHasDataState) {
              return ListView(
                  children: data.data
                      .map((item) =>
                      TipRow(
                        tip: item,
                      ))
                      .toList());
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
