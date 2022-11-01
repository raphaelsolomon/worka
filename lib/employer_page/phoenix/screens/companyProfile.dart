// import 'package:async/async.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/src/provider.dart';
// import 'package:worka/employer_page/controller/empContoller.dart';
// import 'package:worka/models/compModel.dart';
// import 'package:worka/phoenix/CustomScreens.dart';
// import 'package:worka/phoenix/model/Constant.dart';

// import 'editCompany.dart';

// class CompanyProfile extends StatefulWidget {
//   CompanyProfile({Key? key}) : super(key: key);

//   @override
//   State<CompanyProfile> createState() => _CompanyProfileState();
// }

// class _CompanyProfileState extends State<CompanyProfile> {
//   AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Container(
//         child: Column(children: [
//           SizedBox(height: 5.0),
//           Row(children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 0.0),
//               child: IconButton(
//                 icon: Icon(Icons.keyboard_backspace),
//                 color: Color(0xff0D30D9),
//                 onPressed: () => Get.back(),
//               ),
//             ),
//             const SizedBox(
//                 width: 20.0,
//               ),
//             Text('Company profile',
//                 style: GoogleFonts.lato(
//                     fontSize: 15.0, color: Colors.black87)),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 0.0),
//               child: IconButton(
//                 icon: Icon(null),
//                 color: DEFAULT_COLOR,
//                 onPressed: () => null,
//               ),
//             )
//           ]),
//           SizedBox(height: 10.0),
//           FutureBuilder(
//             future: fetchData(context),
//             builder: (ctx, snapshot) => _container(snapshot),
//           )
//         ]),
//       )),
//     );
//   }

//   fetchData(BuildContext context) {
//     return this._asyncMemoizer.runOnce(() async {
//       return await context.read<EmpController>().getEmployerDetails(context);
//     });
//   }

//   Widget _container(snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Expanded(child: Center(child: CircularProgressIndicator()));
//     } else if (snapshot.connectionState == ConnectionState.done) {
//       if (snapshot.hasError) {
//         return Expanded(child: Center(child: const Text('Error')));
//       } else if (snapshot.hasData) {
//         CompModel _compModel = snapshot.data;
//         return _item(_compModel);
//       } else {
//         return Expanded(child: Center(child: const Text('Empty data')));
//       }
//     } else {
//       return Text('State: ${snapshot.connectionState}');
//     }
//   }

//   Widget _item(CompModel compModel) {
//     var item = compModel.industry!.split(',').join(', ');
//     return Expanded(
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             imageView('${compModel.companyLogo}', context),
//             SizedBox(height: 20.0),
//             Container(
//                 margin: EdgeInsets.symmetric(horizontal: 13.0),
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             fit: FlexFit.tight,
//                             child: Center(
//                               child: AutoSizeText(
//                                   '${compModel.companyName!.capitalizeFirst}\n${compModel.firstName!.capitalizeFirst} ${compModel.lastName!.capitalizeFirst}\n${compModel.position!.capitalizeFirst}',
//                                   style: GoogleFonts.montserrat(
//                                       fontSize: 20,
//                                       height: 1.4,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w700),
//                                   textAlign: TextAlign.center),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () => Get.to(() => EditCompany(compModel)),
//                             child: Icon(
//                               Icons.edit,
//                               color: DEFAULT_COLOR,
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 10.0),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.location_on,
//                             color: DEFAULT_COLOR,
//                             size: 19.0,
//                           ),
//                           const SizedBox(width: 10.0),
//                           Text('${compModel.location}',
//                               style: GoogleFonts.montserrat(
//                                   fontSize: 14, color: Colors.black87),
//                               textAlign: TextAlign.left),
//                         ],
//                       ),
//                       SizedBox(height: 5.0),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.email,
//                             color: DEFAULT_COLOR,
//                             size: 19.0,
//                           ),
//                           const SizedBox(width: 10.0),
//                           Text('info@gmail.com',
//                               style: GoogleFonts.montserrat(
//                                   fontSize: 14, color: Colors.black87),
//                               textAlign: TextAlign.left),
//                         ],
//                       ),
//                       SizedBox(height: 5.0),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.phone,
//                             color: DEFAULT_COLOR,
//                             size: 19.0,
//                           ),
//                           const SizedBox(width: 10.0),
//                           Text('${compModel.phone}',
//                               style: GoogleFonts.montserrat(
//                                   fontSize: 14, color: Colors.black87),
//                               textAlign: TextAlign.left),
//                         ],
//                       ),
//                       SizedBox(height: 5.0),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.open_in_browser,
//                             color: DEFAULT_COLOR,
//                           ),
//                           const SizedBox(width: 10.0),
//                           Text(
//                               compModel.companyWebsite == ''
//                                   ? 'No Website'
//                                   : '${compModel.companyWebsite}',
//                               style: GoogleFonts.montserrat(
//                                   fontSize: 14, color: Colors.black87),
//                               textAlign: TextAlign.left),
//                         ],
//                       ),
//                       SizedBox(height: 20.0),
//                       Container(
//                           padding: const EdgeInsets.all(8.0),
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               color: Colors.blue.withOpacity(.1),
//                               borderRadius: BorderRadius.circular(5.0)),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 0.0),
//                                   child: Text(
//                                     'Company Profile',
//                                     style: GoogleFonts.montserrat(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w500),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 SizedBox(height: 5.0),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 0.0),
//                                   child: Row(
//                                     children: [
//                                       Flexible(
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             if (compModel.companyProfile ==
//                                                 '') {
//                                               Get.to(
//                                                   () => EditCompany(compModel));
//                                             }
//                                           },
//                                           child: Text(
//                                               compModel.companyProfile != ''
//                                                   ? '${compModel.companyProfile}'
//                                                   : 'update company profile',
//                                               style: GoogleFonts.montserrat(
//                                                   fontSize: 14,
//                                                   color: Colors.black54),
//                                               textAlign: TextAlign.start),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ])),
//                       SizedBox(height: 13.0),
//                       Container(
//                           padding: const EdgeInsets.all(8.0),
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               color: Colors.blue.withOpacity(.1),
//                               borderRadius: BorderRadius.circular(5.0)),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 0.0),
//                                   child: Text(
//                                     'Hired',
//                                     style: GoogleFonts.montserrat(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w500),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 SizedBox(height: 5.0),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 0.0),
//                                   child: Text(
//                                       '${compModel.hired} numbers of hires',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 14, color: Colors.black54),
//                                       textAlign: TextAlign.start),
//                                 ),
//                               ])),
//                       SizedBox(height: 13.0),
//                       Container(
//                           padding: const EdgeInsets.all(8.0),
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               color: Colors.blue.withOpacity(.1),
//                               borderRadius: BorderRadius.circular(5.0)),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 0.0),
//                                   child: Text(
//                                     'Industry',
//                                     style: GoogleFonts.montserrat(
//                                         fontSize: 16,
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w500),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 SizedBox(height: 5.0),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 0.0),
//                                   child: Text('${item}',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 14, color: Colors.black54),
//                                       textAlign: TextAlign.start),
//                                 ),
//                               ])),
//                       SizedBox(height: 13.0),
//                       Container(
//                           padding: const EdgeInsets.all(8.0),
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                               color: Colors.blue.withOpacity(.1),
//                               borderRadius: BorderRadius.circular(5.0)),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 0.0),
//                                   child: Text('Review',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 16,
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w500),
//                                       textAlign: TextAlign.center),
//                                 ),
//                                 SizedBox(height: 5.0),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 0.0),
//                                   child: Text(
//                                       '${compModel.reviews!} of 5.0 Ratings',
//                                       style: GoogleFonts.montserrat(
//                                           fontSize: 12, color: Colors.black54),
//                                       textAlign: TextAlign.start),
//                                 ),
//                                 SizedBox(height: 5.0),
//                                 RatingBar.builder(
//                                   initialRating:
//                                       double.parse(compModel.reviews!),
//                                   minRating: 1,
//                                   itemSize: 15.0,
//                                   direction: Axis.horizontal,
//                                   allowHalfRating: true,
//                                   itemCount: 5,
//                                   updateOnDrag: false,
//                                   itemPadding:
//                                       EdgeInsets.symmetric(horizontal: 0.0),
//                                   itemBuilder: (context, _) =>
//                                       Icon(Icons.star, color: Colors.amber),
//                                   onRatingUpdate: (rating) => null,
//                                 ),
//                                 SizedBox(
//                                   height: 10.0,
//                                 )
//                               ])),
//                     ]))
//           ],
//         ),
//       ),
//     );
//   }
// }
