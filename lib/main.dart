import 'package:flutter/material.dart';
import 'package:jugglingtv/screens/movies_list_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart';
import './screens/video_screen.dart';
import './db/videos_database.dart';
import './models/videos_db_model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'jugglingtv';

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VideosDatabase.instance),
      ],
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primaryColor: Colors.lightGreen,
          // fontFamily: 'Quicksand',
        ),
        home: const MovieListScreen(),
        routes: {
          VideoScreen.routeName: (context) => const VideoScreen(),
        },
      ),
    );
  }
}
