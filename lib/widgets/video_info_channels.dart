import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/videos_db.dart';
import '../providers/video_channel.dart';
import '../models/main_screen_arguments.dart';
import '../screens/movies_list_screen.dart';
import '../models/db_query_helper.dart';

class VideoInfoChannels extends StatelessWidget {
  const VideoInfoChannels({
    Key? key,
    required this.loadedvideo,
  }) : super(key: key);

  final Video loadedvideo;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: double.infinity),
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<VideoChannel>>(
          future: Provider.of<VideoChannels>(context)
              .fetchChannelsForVideo(loadedvideo.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              return Wrap(
                runAlignment: WrapAlignment.start,
                direction: Axis.horizontal,
                spacing: 20.0,
                children: <Widget>[
                  for (var item in snapshot.data!)
                    InkWell(
                      onTap: () {
                        Navigator.of(context).popAndPushNamed(
                          MovieListScreen.routeName,
                          arguments: MainScreenArguments(
                            channel: item.channelName,
                            mainScreenMode: MainScreenMode.channel,
                            orderBy: OrderBy.title,
                            sort: Sort.desc,
                          ),
                        );
                      },
                      child: Text(
                        item.channelName,
                        style: TextStyle(
                            //fontWeight: FontWeight.w600,
                            //fontSize: 20,
                            height: 3,
                            background: Paint()
                              ..strokeWidth = 18.0
                              ..color = const Color.fromARGB(255, 255, 186, 8)
                              ..style = PaintingStyle.stroke
                              ..strokeJoin = StrokeJoin.round),
                      ),
                    ),
                ],
                //
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                  strokeWidth: 1.0,
                ),
              );
            }
          }),
    );
  }
}
