import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worka/phoenix/model/Constant.dart';
import 'package:worka/screens/selection_page.dart';

class WalkThrough extends StatefulWidget {
  @override
  State<WalkThrough> createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GestureDetector(
                       onTap: () async {
                    _storeOnBoardInfo();
                    Get.to(() => SelectionPage());
                  },
                      child: Text('Skip',
                          style: GoogleFonts.lato(
                            fontSize: 14.5,
                            color: DEFAULT_COLOR,
                          )),
                    ),
                  )),
              
              Expanded(
                child: PageView.builder(
                  onPageChanged: (i) => setState(() => counter = i),
                  itemBuilder: ((context, index) => getPageItems(context)[counter]),
                  itemCount: getPageItems(context).length,
                ),
              ),
            ],
          ),
        ));
  }

List<Widget>getPageItems(BuildContext context) => [
       Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Image.asset('assets/illustration 1.png',
                  width: MediaQuery.of(context).size.width, height: 400.0, fit: BoxFit.contain,),
            ), 
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Get the right Job you deserve',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 22.0, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Easily Search for jobs and attend interviews on the go ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 14.5)),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(
                width: 20.0,
                height: 9.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100.0),
                    color: DEFAULT_COLOR),
              ),
              const SizedBox(width: 8.0,),
             Container(
                width: 9.0,
                height: 9.0,
                decoration:
                    BoxDecoration(
                      border: Border.all(width: .5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(100.0),
                    color: Colors.transparent),
              ),
              const SizedBox(width: 8.0,),
              Container(
                width: 9.0,
                height: 9.0,
                decoration:
                    BoxDecoration(
                      border: Border.all(width: .5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(100.0),
                    color: Colors.transparent),
              )
            ]),
            Spacer(),
            GestureDetector(
                  onTap: () {
                    setState(() => counter = counter + 1);
                  },
                   child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15.0),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: DEFAULT_COLOR
                   ), child: Center(child: Text('Next', style: GoogleFonts.lato(fontSize: 15.0, color: Colors.white),),)),
                 ),
                 Spacer(),
          ],
        ),
      
       Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Image.asset('assets/illustration 2.png',
                  width: MediaQuery.of(context).size.width, height: 400.0, fit: BoxFit.contain,),
            ), 
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Get the right Job you deserve',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 22.0, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Easily Search for jobs and attend interviews on the go ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 14.5)),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Container(
                width: 9.0,
                height: 9.0,
                decoration:
                    BoxDecoration(
                      border: Border.all(width: .5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(100.0),
                    color: Colors.transparent),
              ),
              const SizedBox(width: 8.0,),
              Container(
                width: 20.0,
                height: 9.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100.0),
                    color: DEFAULT_COLOR),
              ),
              const SizedBox(width: 8.0,),
              Container(
                width: 9.0,
                height: 9.0,
                decoration:
                    BoxDecoration(
                      border: Border.all(width: .5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(100.0),
                    color: Colors.transparent),
              )
            ]),
            Spacer(),
            GestureDetector(
                  onTap: () async {
                    setState(() => counter = counter + 1);
                  },
                   child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15.0),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: DEFAULT_COLOR
                   ), child: Center(child: Text('Next', style: GoogleFonts.lato(fontSize: 15.0, color: Colors.white),),)),
                 ),
                 Spacer(),
          ],
        ),

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Image.asset('assets/illustration 2.png',
                  width: MediaQuery.of(context).size.width, height: 400.0, fit: BoxFit.contain,),
            ), 
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('New Offers are waiting for you',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 22.0, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('job Offers uploaded from verified companies every minute',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(fontSize: 14.5)),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Container(
                width: 9.0,
                height: 9.0,
                decoration:
                    BoxDecoration(
                      border: Border.all(width: .5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(100.0),
                    color: Colors.transparent),
              ),
              const SizedBox(width: 8.0,),
              Container(
                width: 9.0,
                height: 9.0,
                decoration:
                    BoxDecoration(
                      border: Border.all(width: .5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(100.0),
                    color: Colors.transparent),
              ),
              const SizedBox(width: 8.0,),
              Container(
                width: 20.0,
                height: 9.0,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100.0),
                    color: DEFAULT_COLOR),
              ),
            ]),
            Spacer(),
            GestureDetector(
                  onTap: () async {
                    _storeOnBoardInfo();
                    Get.to(() => SelectionPage());
                  },
                   child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15.0),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: DEFAULT_COLOR
                   ), child: Center(child: Text('Get Started', style: GoogleFonts.lato(fontSize: 15.0, color: Colors.white),),)),
                 ),
                 Spacer(),
          ],
        ),
    ];
}