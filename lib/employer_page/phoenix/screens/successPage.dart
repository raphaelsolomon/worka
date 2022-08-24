import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/models/Createdinterview.dart';
import 'package:worka/phoenix/CustomScreens.dart';
import 'package:worka/phoenix/GeneralButtonContainer.dart';
import 'package:worka/phoenix/dashboard_work/preview.dart';
import 'package:worka/phoenix/model/Constant.dart';

class InterviewSuccessPage extends StatelessWidget {
  final String title;
  final Createdinterview id;
  const InterviewSuccessPage(this.title, this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        width: 1.0, color: Colors.blue.withOpacity(.2))),
                child: Image.asset('assets/succ.png'),
              ),
              SizedBox(height: 20.0),
              Text('${title}',
                  style: GoogleFonts.montserrat(
                      color: DEFAULT_COLOR, fontSize: 18)),
              SizedBox(
                height: 50.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: GeneralButtonContainer(
                  name: 'Continue',
                  color: Color(0xff0D30D9),
                  textColor: Colors.white,
                  onPress: () {
                    Get.off(() => Screens(interviewStep7(
                        context, id.interviewUid!, id.note!,
                        type: id.interviewType)));
                  },
                  paddingBottom: 3,
                  paddingLeft: 20,
                  paddingRight: 20,
                  paddingTop: 5,
                ),
              ),
            ],
          ),
        ));
  }
}
