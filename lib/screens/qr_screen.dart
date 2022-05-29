import 'package:ewaste/screens/detail_nasabah_screen.dart';
import 'package:ewaste/screens/home/main_screen.dart';
import 'package:ewaste/services/transaksi_service.dart';
import 'package:ewaste/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  bool _flashOn = false;
  bool _frontCam = false;
  bool isLoading = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(
            top: 50,
            left: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(
                        pageIndex: 0,
                      ),
                    ),
                    (route) => false);
              },
              child: Container(
                width: 35,
                height: 35,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: whiteColor,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/icon_close.svg',
                  color: primaryTextColor,
                  height: 10,
                ),
              ),
            ),
          ),
          isLoading
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: whiteColor,
                    ),
                  ),
                )
              : SizedBox(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 55,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _flashOn = !_flashOn;
                      });
                      _controller!.toggleFlash();
                    },
                    child: Container(
                      width: 120,
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: _flashOn ? primaryColor : greenTextColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            _flashOn
                                ? 'assets/icon_flash.svg'
                                : 'assets/icon_flash_slash.svg',
                            color: whiteColor,
                          ),
                          Text(
                            _flashOn ? 'Flash on' : 'Flash off',
                            style: whiteTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _frontCam = !_frontCam;
                      });
                      _controller!.flipCamera();
                    },
                    child: Container(
                      width: 120,
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: _frontCam ? greenTextColor : primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/icon_cam.svg',
                            color: whiteColor,
                            width: 20,
                          ),
                          Text(
                            _frontCam ? 'Front cam' : 'Back cam',
                            style: whiteTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: semiBold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 250,
              margin: EdgeInsets.only(top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Scan QR Code',
                    style: whiteTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: bold,
                    ),
                  ),
                  Text(
                    'scan qr code nasabah untuk melakukan menabung sampah',
                    style: whiteTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRviewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: primaryColor,
          borderRadius: 12,
          borderLength: 50,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.65,
        ),
      );
  void onQRviewCreated(QRViewController controller) {
    setState(() {
      this._controller = controller;
    });
    controller.scannedDataStream.listen((value) async {
      if (mounted) {
        _controller!.dispose();
        setState(() {
          isLoading = true;
        });
        var user =
            await TransaksiService().getUser(kode: value.code.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailNasabahScreen(
              nasabah: user,
            ),
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}
