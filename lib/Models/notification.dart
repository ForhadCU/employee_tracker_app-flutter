import 'package:flutter/material.dart';

class NotificationModel extends StatefulWidget {
  final String avatarurl;
  final String desc;
  final String title;
  final int userid;
  final int noticeid;
  final String noticeimgurl;
  final String subtitle;
  final String status;

  NotificationModel(
      {Key? key,
      required this.avatarurl,
      required this.desc,
      required this.title,
      required this.userid,
      required this.noticeid,
      required this.noticeimgurl,
      required this.subtitle,
      required this.status
      })
      : super(key: key);

  @override
  State<NotificationModel> createState() => _NotificationModelState();
}

class _NotificationModelState extends State<NotificationModel> {
  @override
  Widget build(BuildContext context) {
    print("\x1b[32m Build: Models/notification_model.dart \x1b[0m");
    return Container(
      child: GFCard(
        color: widget.status == 'unread' ? Colors.blueGrey.shade200 : Colors.grey.shade50,
        margin: EdgeInsets.all(6),
        boxFit: BoxFit.cover,
        titlePosition: GFPosition.start,
        image: Image.asset(
          "lib/assets/images/flutter_img.png",
          // widget.noticeimgurl,
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        showImage: true,
        title: GFListTile(
          avatar: GFAvatar(
            backgroundImage: AssetImage('lib/assets/images/img_avatar.png'),
          ),
          titleText: widget.title,
          subTitleText: widget.subtitle,
        ),
        content: Text(widget.desc),
      ),
    );
  }
}
