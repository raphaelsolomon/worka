import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../phoenix/CustomScreens.dart';
import '../../../phoenix/GeneralButtonContainer.dart';
import '../../../phoenix/Resusable.dart';
import '../../../phoenix/model/Constant.dart';
import '../../controller/empContoller.dart';

class ShortlistFinal extends StatefulWidget {
  final String id;
  final String uids;
  const ShortlistFinal(this.id, this.uids, {Key? key}) : super(key: key);

  @override
  State<ShortlistFinal> createState() => _ShortlistFinalState();
}

class _ShortlistFinalState extends State<ShortlistFinal> {
  bool isLoading = false;
  final cNote = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      maintainBottomViewPadding: true,
      child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  color: Color(0xff0D30D9),
                  onPressed: () => Get.back(),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Text('ShortList Request',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Color(0xff0D30D9)),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: IconButton(
                  icon: Icon(null),
                  color: Color(0xff0D30D9),
                  onPressed: null,
                ),
              ),
            ]),
            const SizedBox(height: 20.0),
            Expanded(
              child: SingleChildScrollView(
                child: CustomRichTextForm(
                    cNote, 'Note', 'Note', TextInputType.multiline,MediaQuery
                    .of(context).size.height~/ 21.9,
                    onChange: () => null),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 20.0),
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: DEFAULT_COLOR))
                    : GeneralButtonContainer(
                        name: 'Send Request',
                        color: Color(0xff0D30D9),
                        textColor: Colors.white,
                        onPress: () {
                          if (widget.uids.isEmpty) {
                            CustomSnack('Error', 'No Employee selected');
                            return;
                          }

                          if (cNote.text.trim().isEmpty) {
                            CustomSnack('Error', 'Enter a Request Note');
                            return;
                          }

                          context.read<EmpController>().employmentRequest(
                              context,
                              '${widget.id}',
                              widget.uids,
                              cNote.text.trim(), () {
                            setState(() {
                              isLoading = true;
                            });
                          }, () {
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        paddingBottom: 3,
                        paddingLeft: 10,
                        paddingRight: 10,
                        paddingTop: 5,
                      ))
          ]),
    ));
  }
}
