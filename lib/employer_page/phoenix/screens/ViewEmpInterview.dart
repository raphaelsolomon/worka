import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/src/provider.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/models/scriptModel.dart';

import '../../../phoenix/model/Constant.dart';

class ViewEmpInterview extends StatelessWidget {
  final String id;
  final String uid;
  const ViewEmpInterview(this.id, this.uid, {Key? key}) : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            maintainBottomViewPadding: true,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //custom app design
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: IconButton(
                            icon: Icon(Icons.keyboard_backspace),
                            color: Color(0xff0D30D9),
                            onPressed: () => Get.back(),
                          ),
                        ),
                        Flexible(
                          child: Text('Employee Interview',
                              style: GoogleFonts.montserrat(
                                  fontSize: 18, color: Color(0xff0D30D9)),
                              textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: IconButton(
                            icon: Icon(null),
                            color: Color(0xff0D30D9),
                            onPressed: null,
                          ),
                        ),
                      ]),
                  Expanded(
                      child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 20),
                    child: FutureBuilder(
                      future: context
                          .read<EmpController>()
                          .viewEmployeeInterview(context, id, uid),
                      builder: (ctx, AsyncSnapshot<ScriptModel?> snapshot) =>
                          _container(snapshot, context),
                    ),
                  )),
                ])));
  }

  Widget _container(AsyncSnapshot<ScriptModel?> snapshot, BuildContext c) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        return const Text('Error');
      } else if (snapshot.hasData) {
        List<QAndA> s = snapshot.data!.qAndA;
        return Column(
          children: [
            snapshot.data!.percent == -1
                ? SizedBox()
                : Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: DEFAULT_COLOR.withOpacity(.5), width: 1.0),
                        borderRadius: BorderRadius.circular(100.0)),
                    child: Center(
                      child: Text(
                        'Score : ${snapshot.data!.percent}',
                        style: GoogleFonts.poppins(
                            fontSize: 13, color: Colors.black87),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question : ${s[i].question.question}',
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.black87),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10.0),
                      Text('Answer : ${s[i].answer}',
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: DEFAULT_COLOR)),
                      SizedBox(height: 10.0),
                      Text(s[i].status == '' ? '' : 'Status : ${s[i].status}',
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: DEFAULT_COLOR)),
                      SizedBox(height: 25.0),
                    ],
                  ),
                ),
                itemCount: s.length,
              ),
            ),
          ],
        );
      } else {
        return Center(
            child: Text('No Applicant Yet',
                style: GoogleFonts.montserrat(
                    fontSize: 18, color: Color(0xff0D30D9))));
      }
    } else {
      return Text('State: ${snapshot.connectionState}');
    }
  }
}
