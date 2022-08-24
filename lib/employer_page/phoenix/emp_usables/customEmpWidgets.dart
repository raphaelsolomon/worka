import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:worka/phoenix/model/Constant.dart';

Widget ApplicationList(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CircleAvatar(radius: 14, backgroundColor: Colors.blue),
          Flexible(
            child: AutoSizeText(
              'Oluwatobi Ogunjimi applied to your Job posting UI/UX Designer job in Lagos,',
              minFontSize: 11,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400, color: Colors.black),
            ),
          ),
          Container()
        ]),
        SizedBox(height: 10.0),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(),
          Flexible(
            child: AutoSizeText(
              'September 2021',
              minFontSize: 11,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400, color: Colors.grey),
            ),
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text('Decline',
                    style: GoogleFonts.montserrat(color: Colors.red)),
              ),
              SizedBox(width: 10.0),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
                decoration: BoxDecoration(
                  color: DEFAULT_COLOR,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text('Accept',
                    style: GoogleFonts.montserrat(color: Colors.white)),
              ),
            ],
          )
        ]),
      ],
    );

Widget ShortListItem(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.transparent,
                  border: Border.all(
                      color: Color(0xff0D30D9).withOpacity(.15), width: 1.5)),
              child: CircleAvatar(
                backgroundImage: NetworkImage(''),
                backgroundColor: Colors.black26,
                radius: 20,
              ),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  'Uchiha Madara',
                  minFontSize: 11,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400, color: Colors.black),
                ),
                SizedBox(height: 10.0),
                AutoSizeText(
                  'UI/UX Designer',
                  minFontSize: 11,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400, color: DEFAULT_COLOR),
                ),
              ],
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: DEFAULT_COLOR,
          ),
          child: Text(
            'Accept',
            style: GoogleFonts.montserrat(color: Colors.white),
          ),
        )
      ],
    );
