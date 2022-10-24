import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';

class RedesignAvailability extends StatefulWidget {
  const RedesignAvailability({super.key});

  @override
  State<RedesignAvailability> createState() => _RedesignAvailabilityState();
}

class _RedesignAvailabilityState extends State<RedesignAvailability> {
  bool isAvailable = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.menu,
                        color: DEFAULT_COLOR,
                      )),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text('Availability',
                      style: GoogleFonts.lato(
                          fontSize: 15.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500))
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose Your Availaility',
                    style:
                        GoogleFonts.lato(fontSize: 15.0, color: Colors.black54),
                  ),
                  const SizedBox(height: 15.0),
                  getCardForm(isAvailable, 'Available to work Fulltime or Parttime', callBack: () {
                    setState(() {
                      isAvailable = true;
                    });
                  }),
                  const SizedBox(height: 15.0),
                  getCardForm(isAvailable == false, 'Not Available to work Fulltime', callBack: () {
                    setState(() {
                      isAvailable = false;
                    });
                  }),
                  const SizedBox(
                    height: 30.0,
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: DEFAULT_COLOR),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: GoogleFonts.lato(
                                fontSize: 15.0, color: Colors.white),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  getCardForm(b, text, {callBack}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(
        onTap: () => callBack(),
        child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    color: b ? Colors.black54 : DEFAULT_COLOR, width: 1.0),
                color: DEFAULT_COLOR.withOpacity(.05)),
            child: Row(children: [
              Icon(
                Icons.shield_outlined,
                color: b ? DEFAULT_COLOR : Colors.black45,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Flexible(
                child: Text('$text',
                    style: GoogleFonts.lato(
                        fontSize: 15.0,
                        color: b ? DEFAULT_COLOR : Colors.black54)),
              )
            ])),
      ),
    );
  }
}
