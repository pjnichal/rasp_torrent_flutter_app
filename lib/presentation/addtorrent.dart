import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rasp_torrent_flutter_app/business_logic/torrentoperationbloc/bloc/torrentoperationsbloc_bloc.dart';
import 'package:sizer/sizer.dart';

class AddTorrent extends StatelessWidget {
  final magnetlinkcontroller = TextEditingController();
  AddTorrent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Magnet Link",
          style: GoogleFonts.poppins(
            fontSize: 4.w,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(2.h),
                child: TextField(
                  controller: magnetlinkcontroller,
                  style: GoogleFonts.poppins(
                    fontSize: 4.w,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Colors.green,
                  maxLines: 15,
                  decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    hintText: "Past Magnet Link Here",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                ),
              ),
              BlocConsumer<TorrentOperationsBloc, TorrentOperationsState>(
                  listener: (_, state) {
                if (state is AddedTorrentSuccess) {
                  Navigator.of(context).pop();
                  // Navigator.of(context).pushNamedAndRemoveUntil(
                  //     '/',
                  //     (route) => route.isCurrent && route.settings.name == "/"
                  //         ? false
                  //         : true);
                }
              }, builder: (context, state) {
                return MaterialButton(
                  onPressed: () {
                    BlocProvider.of<TorrentOperationsBloc>(context)
                        .add(AddTorrentEvent(magnetlinkcontroller.text));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.green,
                  child: Text(
                    "Add To Downloads",
                    style: GoogleFonts.poppins(
                      fontSize: 5.w,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),
                  height: 6.h,
                  elevation: 10,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
