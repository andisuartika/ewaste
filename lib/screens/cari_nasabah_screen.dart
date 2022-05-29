import 'package:ewaste/models/user_model.dart';
import 'package:ewaste/services/user_service.dart';
import 'package:ewaste/widgets/user_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme.dart';

class CariNasabahScreen extends StatefulWidget {
  const CariNasabahScreen({Key? key}) : super(key: key);

  @override
  State<CariNasabahScreen> createState() => _CariNasabahScreenState();
}

class _CariNasabahScreenState extends State<CariNasabahScreen> {
  // TEXTEDITING CONTROLLER
  TextEditingController searchController = TextEditingController(text: '');

  // DATA NASABAH
  List<UserModel> nasabah = [];
  List<UserModel> _search = [];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    fetchData();

    super.initState();
  }

  Future<Null> fetchData() async {
    setState(() {
      isLoading = true;
    });
    nasabah.clear();
    var users = await UserService().getUsers(search: '');
    setState(() {
      nasabah = users;
      isLoading = false;
    });
  }

  void searching(String search) async {
    setState(() {
      isLoading = true;
    });
    _search.clear();
    if (searchController.text.isEmpty) {
      var users = await UserService().getUsers(search: '');
      setState(() {
        nasabah = users;
        isLoading = false;
      });
    }
    var users = await UserService().getUsers(search: searchController.text);
    setState(() {
      nasabah = users;
      isLoading = false;
    });
  }

  bool _onSearch = false;

  @override
  Widget build(BuildContext context) {
    // HEADER
    Widget header() {
      return AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Cari Nasabah',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
      );
    }

    // SEARCH
    Widget search() {
      return Container(
        height: _onSearch ? 90 : 210,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: _onSearch ? 0 : 30,
          left: 30,
          right: 30,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: _onSearch
              ? BorderRadius.only()
              : BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.03),
              spreadRadius: 5,
              blurRadius: 0,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            _onSearch
                ? SizedBox()
                : Text(
                    'Cari Nasabah  dengan nama yang sudah terdaftar pada aplikasi E-Waste.',
                    style: whiteTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                      height: 1.3,
                    ),
                  ),
            SizedBox(
              height: _onSearch ? 10 : 25,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icon_search.svg',
                      width: 20,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: primaryTextStyle,
                        controller: searchController,
                        onTap: () {
                          setState(() {
                            _onSearch = true;
                            print(_onSearch);
                          });
                        },
                        onChanged: searching,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Nama nasabah',
                          hintStyle: hintTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // RESULT
    Widget result() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _onSearch ? 'Hasil pencarian' : 'Nasabah',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: nasabah.length,
                      itemBuilder: (context, index) => UserListitem(
                        nasabah: nasabah[index],
                      ),
                    ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgorundColor,
      body: Column(
        children: [
          header(),
          search(),
          Expanded(
            child: result(),
          ),
        ],
      ),
    );
  }
}
