import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewaste/models/notification_model.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class CustomPesanItem extends StatelessWidget {
  final NotificationModel notification;

  const CustomPesanItem({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: notification.image != null ? 175 : 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notification.date.toString().substring(0, 10) +
                ' | ' +
                notification.date.toString().substring(11, 16),
            style: primaryTextStyle.copyWith(
              fontSize: 8,
              fontWeight: light,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          notification.image != null
              ? Container(
                  height: 95,
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 3),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: notification.image.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : SizedBox(),
          Container(
            width: double.infinity,
            child: Text(
              notification.description.toString(),
              style: darkGreenTextStyle.copyWith(
                fontSize: notification.image != null ? 10 : 12,
                fontWeight: semiBold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Divider(
            thickness: 1,
            color: secondaryTextColor,
          ),
        ],
      ),
    );
  }
}
