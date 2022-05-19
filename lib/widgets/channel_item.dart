import 'package:flutter/material.dart';
import 'package:jugglingtv/models/db_query_helper.dart';
import 'package:jugglingtv/models/main_screen_arguments.dart';
import 'package:provider/provider.dart';
import '../models/videos_db.dart';
import '../screens/movies_list_screen.dart';

class ChannelItem extends StatelessWidget {
  const ChannelItem({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.description,
  }) : super(key: key);

  final String name;
  final String imageUrl;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(MovieListScreen.routeName,
                    arguments: MainScreenArguments(
                      channel: name,
                      mainScreenMode: MainScreenMode.channel,
                      orderBy: OrderBy.title,
                      sort: Sort.desc,
                    ));
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          title: Text(
            name,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline1?.fontFamily,
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            description,
            softWrap: true,
            maxLines: 2,
          ),
          backgroundColor: Colors.black54,
        ),
      ),
    );
  }
}
