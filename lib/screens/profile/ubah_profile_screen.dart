import 'dart:async';
import 'dart:io';

import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/providers/auth_provider.dart';
import 'package:ewaste/theme.dart';
import 'package:ewaste/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class UbahProfileScreen extends StatefulWidget {
  const UbahProfileScreen({Key? key}) : super(key: key);

  @override
  State<UbahProfileScreen> createState() => _UbahProfileScreenState();
}

class _UbahProfileScreenState extends State<UbahProfileScreen> {
  @override
  // IMAGE PICKER

  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // final imageTemporary = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() => this.image = imagePermanent);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  // SELECT SOURCE PICK IMAGE
  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: Text('Camera'),
              onPressed: () => pickImage(ImageSource.camera),
            ),
            CupertinoActionSheetAction(
              child: Text('Gellery'),
              onPressed: () => pickImage(ImageSource.gallery),
            ),
          ],
        ),
      );
    } else {
      return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Iconsax.camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.camera);
                },
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Iconsax.image),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();

    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    // TEXT EDITING CONTROLLER
    TextEditingController emailController =
        TextEditingController(text: user.email);
    TextEditingController namaController =
        TextEditingController(text: user.name);
    TextEditingController noHpController =
        TextEditingController(text: user.noHp);
    TextEditingController alamatController =
        TextEditingController(text: user.alamat);

    // PHOTO PROFILE
    Widget photoProfile() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            image != null
                ? Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(image!),
                      ),
                    ),
                  )
                : Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(user.profilePhotoUrl.toString()),
                      ),
                    ),
                  ),
            GestureDetector(
              onTap: () => showImageSource(context),
              child: Text(
                'Ubah Foto',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Ubah Profile',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              photoProfile(),
              CustomTextForm(
                label: 'Nama',
                controller: namaController,
              ),
              CustomTextForm(
                label: 'Email',
                controller: emailController,
                type: TextInputType.emailAddress,
              ),
              CustomTextForm(
                label: 'Nomor Telepon',
                controller: noHpController,
                type: TextInputType.phone,
              ),
              CustomTextForm(
                label: 'Alamat',
                controller: alamatController,
                type: TextInputType.streetAddress,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: CustomButton(
          text: 'Simpan',
          color: primaryColor,
          press: () {},
        ),
      ),
    );
  }
}

class CustomTextForm extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final type;

  const CustomTextForm({
    Key? key,
    required this.label,
    required this.controller,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 30),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgorundFieldColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        keyboardType: type,
        controller: controller,
        style: primaryTextStyle.copyWith(
          fontSize: 14,
          fontWeight: semiBold,
        ),
        decoration: InputDecoration(
          label: Text(label),
          labelStyle: secondaryTextStyle.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
