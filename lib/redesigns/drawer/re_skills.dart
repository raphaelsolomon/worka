import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';

class RedesignExperience extends StatefulWidget {
  const RedesignExperience({super.key});

  @override
  State<RedesignExperience> createState() => _RedesignExperienceState();
}

class _RedesignExperienceState extends State<RedesignExperience> {
  final searchController = TextEditingController();
  List<String> skills = [];

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
                  Text('Add Skills',
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
                children: [
                  getCardForm('Search',
                      ctl: searchController, callBack: (s) {}),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                      child: Wrap(spacing: 12.0, children: [
                    ...List.generate(
                        skills.length,
                        (i) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            margin: const EdgeInsets.symmetric(vertical: 5.0),
                            decoration: BoxDecoration(
                                color: DEFAULT_COLOR.withOpacity(.2),
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    width: .5, color: DEFAULT_COLOR)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('${skills[i]}',
                                    style: GoogleFonts.lato(
                                        fontSize: 15.0, color: DEFAULT_COLOR)),
                                const SizedBox(width: 15.0),
                                GestureDetector(
                                  onTap: () => setState(() => skills.removeAt(i)),
                                  child: Text('x',
                                      style: GoogleFonts.lato(
                                          fontSize: 16.0, color: DEFAULT_COLOR)),
                                ),
                              ],
                            ))),
                  ])),
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

  getCardForm(hint, {ctl, callBack}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: DEFAULT_COLOR.withOpacity(.05)),
            child: TextField(
              controller: ctl,
              onChanged: (s) => callBack(s),
              style: GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
              maxLines: 1,
              decoration: InputDecoration(
                  hintText: hint,
                  suffixIcon:
                      Icon(Icons.search, color: Colors.black54, size: 18.0),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  hintStyle:
                      GoogleFonts.lato(fontSize: 14.0, color: Colors.black45),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          )
        ],
      ),
    );
  }
}
