import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/authors.dart';
import '../widgets/authors_screen/author_screen_videos_list.dart';
import 'movies_list_screen.dart';

class AuthorScreen extends StatelessWidget {
  const AuthorScreen({Key? key}) : super(key: key);
  static const routeName = '/author';

  Offstage authorInfo(String caption, String infoText) {
    return Offstage(
        offstage: infoText == ' ' || infoText == '0',
        child: Text('$caption: $infoText'));
  }

  @override
  Widget build(BuildContext context) {
    final authorId = ModalRoute.of(context)?.settings.arguments as int;
    final loadedAuthor =
        Provider.of<Authors>(context, listen: false).readAuthorById(authorId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        title: Center(
          child: Image.asset(
            "assets/images/logo.png",
            //fit: BoxFit.cover,
            scale: 1.5,
          ),
        ),
      ),
      body: PageStorage(
        bucket: bucketGlobal,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(loadedAuthor.imageUrl)),
                    ),
                    Flexible(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            authorInfo('Full Name', loadedAuthor.fullName),
                            authorInfo('Name', loadedAuthor.name),
                            authorInfo('Hometown', loadedAuthor.hometown),
                            authorInfo('Country', loadedAuthor.country),
                            authorInfo('Followers',
                                loadedAuthor.noFollowers.toString()),
                            authorInfo('Video Views',
                                loadedAuthor.videoViews.toString()),
                            authorInfo('Profile Views',
                                loadedAuthor.profileViews.toString()),
                            authorInfo('Number of videos',
                                loadedAuthor.moviesCount.toString()),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(thickness: 1.0, height: 2.0),
              Expanded(child: AuthorScreenVideosList(authorId: authorId)),
            ],
          ),
        ),
      ),
    );
  }
}
