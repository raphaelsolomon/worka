import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worka/employer_page/controller/empContoller.dart';
import 'package:worka/employer_page/phoenix/screens/editCompany.dart';
import 'package:worka/models/compModel.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';

class ReCompanyProfile extends StatefulWidget {
  const ReCompanyProfile({super.key});

  @override
  State<ReCompanyProfile> createState() => _ReCompanyProfileState();
}

class _ReCompanyProfileState extends State<ReCompanyProfile> {
  int counter = 0;
  final controller = RefreshController();
  CompModel? compModel = null;
  bool isLoading = true;

  fetchData(BuildContext context) async {
    return await context.read<EmpController>().getEmployerDetails(context);
  }

  @override
  void initState() {
    fetchData(context).then((value) {
      setState(() {
        compModel = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
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
                            Icons.keyboard_backspace,
                            color: DEFAULT_COLOR,
                          )),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text('Company Profile',
                          style: GoogleFonts.lato(
                              fontSize: 15.0, color: Colors.black87))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                    child: isLoading
                        ? Center(
                            child:
                                CircularProgressIndicator(color: DEFAULT_COLOR),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: SmartRefresher(
                              header: WaterDropHeader(),
                              controller: controller,
                              onRefresh: () => fetchData(context).then((value) {
                                setState(() {
                                  compModel = value;
                                  controller.refreshCompleted();
                                });
                              }),
                              child: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 5.0),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                              width: .9,
                                              color: Colors.transparent)),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor:
                                                DEFAULT_COLOR.withOpacity(.03),
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                              '${context.watch<Controller>().avatar}',
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 25.0,
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${compModel!.companyName},',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 16.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  '${compModel!.position},',
                                                  style: GoogleFonts.lato(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () => Get.to(() =>
                                                  EditCompany(compModel!)),
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.black87,
                                              ))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 25.0),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 15.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12, width: .5),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text('Contact Information',
                                          style: GoogleFonts.lato(
                                              fontSize: 15.0,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on,
                                            color: Colors.black87, size: 18.0),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('${compModel!.location},',
                                            style: GoogleFonts.lato(
                                                fontSize: 14.0,
                                                color: Colors.black54))
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Icon(Icons.email_rounded,
                                            color: Colors.black87, size: 18.0),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('${compModel!.companyEmail}',
                                            style: GoogleFonts.lato(
                                                fontSize: 14.0,
                                                color: Colors.black54))
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Icon(Icons.phone,
                                            color: Colors.black87, size: 18.0),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('${compModel!.phone}',
                                            style: GoogleFonts.lato(
                                                fontSize: 14.0,
                                                color: Colors.black54))
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      children: [
                                        Icon(Icons.network_cell,
                                            color: Colors.black87, size: 18.0),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('${compModel!.companyWebsite}',
                                            style: GoogleFonts.lato(
                                                fontSize: 14.0,
                                                color: DEFAULT_COLOR))
                                      ],
                                    ),
                                    const SizedBox(height: 25.0),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 15.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12, width: .5),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Text('About',
                                          style: GoogleFonts.lato(
                                              fontSize: 15.0,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    const SizedBox(height: 15.0),
                                    Text('${compModel!.companyProfile}',
                                        style: GoogleFonts.lato(
                                            fontSize: 14.0,
                                            color: Colors.black54)),
                                    const SizedBox(height: 20.0),
                                    Text('Overall Ratings',
                                        style: GoogleFonts.lato(
                                            fontSize: 15.0,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    Text('${compModel!.reviews} of 5.0 Ratings',
                                        style: GoogleFonts.lato(
                                            fontSize: 14.0,
                                            color: Colors.black54)),
                                    const SizedBox(
                                      height: 7.0,
                                    ),
                                    RatingBar.builder(
                                      initialRating:
                                          double.parse('${compModel!.reviews}'),
                                      minRating: 1,
                                      itemSize: 15.0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      updateOnDrag: false,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 0.0),
                                      itemBuilder: (context, _) =>
                                          Icon(Icons.star, color: Colors.amber),
                                      onRatingUpdate: (rating) => null,
                                    ),
                                    const SizedBox(height: 40.0),
                                  ])),
                            )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
