import 'package:cached_network_image/cached_network_image.dart';
import 'package:ewaste/models/nasabah_model.dart';
import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/screens/home/input_sampah_screen.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class UserListitem extends StatelessWidget {
  final UserModel nasabah;
  const UserListitem({
    Key? key,
    required this.nasabah,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InputSampahScreen(nasabah: nasabah)));
          },
          child: Container(
            width: double.infinity,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                nasabah.profilePhotoPath == null
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              'http://wastebali.com/storage/usersProfile/user.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: nasabah.profilePhotoUrl.toString(),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    // width: 240,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nasabah.name.toString(),
                          style: primaryTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: medium,
                          ),
                        ),
                        Text(
                          nasabah.alamat.toString(),
                          style: secondaryTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: regular,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          thickness: 0.7,
          color: secondaryTextColor,
        )
      ],
    );
  }
}
