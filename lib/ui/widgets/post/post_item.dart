import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:rohy/constants.dart';

class PostItemWidget extends StatelessWidget {
  const PostItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class PostItemDetailsWidget extends StatelessWidget {
  const PostItemDetailsWidget(
      {Key? key,
      required this.author,
      required this.title,
      required this.avatar,
      required this.description,
      required this.date, required this.photo})
      : super(key: key);

  final String author;
  final String? title;
  final String avatar;
  final String description;
  final DateTime date;
  final String? photo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(children: [
              ListTile(
                  title: Text(
                    author,
                    style: postHeaderTitleStyle,
                  ),
                  subtitle: Text(
                    title!,
                    style: postTitleStyle,
                  ),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(avatar),
                  ))
            ,
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, bottom: 10, right: 5),
                      child: ReadMoreText(
                        description,
                        trimLines: 1,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Voir plus',
                        trimExpandedText: 'Voir moins',
                        moreStyle:postContentStyle,
                        lessStyle: postContentStyle,
                      )
                  )),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.network(
                  photo!,
                  fit: BoxFit.cover,
                ),
              )
            ])
          ]),
    );
  }
}
