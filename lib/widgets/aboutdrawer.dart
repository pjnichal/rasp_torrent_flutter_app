import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDrawer extends StatelessWidget {
  const AboutDrawer({Key? key}) : super(key: key);

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 20.h,
            child: Padding(
              padding: EdgeInsets.only(top: 13.h, left: 3.h),
              child: Text(
                "About devs",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/bg.jpg"), fit: BoxFit.cover),
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: CircleAvatar(
                  radius: 4.h,
                  backgroundImage: AssetImage("images/pravin.jpeg"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Text(
                  "Pravin Nichal",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          GestureDetector(
            onTap: () {
              _launchURL('https://www.instagram.com/pravin_nichal/');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: SizedBox(
                    width: 3.h,
                    height: 3.h,
                    child: Image.asset("images/instagram.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Text(
                    "Instagram",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 3.h),
          GestureDetector(
            onTap: () {
              _launchURL(
                  'https://www.linkedin.com/in/pravin-nichal-93080b1b4/}');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.h),
                  child: SizedBox(
                    width: 3.h,
                    height: 3.h,
                    child: Image.asset("images/linkedin.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Text(
                    "LinkedIn",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 1.h),
          Divider(),
        ],
      ),
    );
  }
}
