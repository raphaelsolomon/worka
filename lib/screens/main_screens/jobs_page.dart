import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:worka/phoenix/Resusable.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({Key? key}) : super(key: key);

  // const JobsPage({Key? key, required this.user}) : super(key: key);
  // final UserModel user;

  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  bool isFavorite = true;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: IconButton(
                  icon: const Icon(Icons.keyboard_backspace),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.0),
                child: IconButton(
                  icon: Icon(null),
                  color: Colors.black,
                  onPressed: null,
                ),
              )
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 150, 0),
              child: RichText(
                text: TextSpan(
                    text: 'Find the',
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                    children: [
                      TextSpan(
                          text: ' Job',
                          style: GoogleFonts.montserrat(
                              color: const Color(0xff0039A5),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1)),
                      TextSpan(
                          text: '\nyou dreamt of',
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1)),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 26, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xff0039A5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade700,
                        offset: const Offset(4.0, 4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0,
                      ),
                      const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/alert.png',
                                  ),
                                  Text(
                                    'Alerts',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5.0, 0, 0),
                          child: Text(
                            'You got an Interview by 10:00am\ntoday, Get Prepared!',
                            style: GoogleFonts.montserrat(
                                fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      color: const Color(0xffF5F5F5),
                      height: 70,
                      width: 1,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: CustomSearchForm(
                          'Search for jobs or position', TextInputType.text),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Icon(
                          Icons.align_vertical_center_outlined,
                          color: Colors.white,
                          size: 18,
                        )),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 0, 0),
                  child: Text(
                    'Recent Jobs',
                    style: GoogleFonts.montserrat(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
            moreJobsMethod(),
            moreJobsMethod(),
            moreJobsMethod(),
          ],
        ),
      ),
    );
  }

  Padding moreJobsMethod() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Container(
        width: 220,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 5.0, 4, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'UI/UX Designer',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                        backgroundColor:
                            const Color(0xff1B6DF9).withOpacity(.5),
                        radius: 13,
                        child: IconButton(
                          onPressed: () {
                            // setState(() {
                            //   isFavorite = !isFavorite;
                            // });
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite_border : Icons.favorite,
                            size: 11,
                          ),
                        )),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                child: Text(
                  '#250k-400k/month',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ReadMoreText(
                  'An expert who can design of functional and appealing user experience and interface design is urgently needed',
                  trimLines: 1,
                  colorClickableText: Color(0xff0039A5),
                  trimMode: TrimMode.Line,
                  style: TextStyle(
                      color: Colors.black, fontSize: 12, fontFamily: 'Lato'),
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 3, 0, 0),
                    child: Text(
                      'salary',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8.0, 3, 8, 0),
                    child: Text(
                      'Remote,\nNigeria',
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
