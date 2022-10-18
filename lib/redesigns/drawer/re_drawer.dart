import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../phoenix/model/Constant.dart';

class ReDrawer extends StatelessWidget {
  const ReDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 110,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: DEFAULT_COLOR.withOpacity(.03),
                radius: 30,
                child: Image.network(
                  '',
                  width: 20.0,
                  height: 20.0,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                width: 25.0,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Clinton Okeowo',
                      style: GoogleFonts.lato(
                          fontSize: 17.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Info@FkliyNetwork.inc,',
                      style: GoogleFonts.lato(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
              child: Column(
            children: [
              items(),
              const SizedBox(height: 10.0),
              items(icons: Icons.shopping_bag, text: 'Jobs'),
              const SizedBox(height: 10.0),
              items(icons: Icons.laptop, text: 'Interviews'),
              const SizedBox(height: 10.0),
              items(icons: Icons.settings, text: 'Settings'),
              const SizedBox(height: 10.0),
              items(icons: Icons.headphones, text: 'Help Center'),
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_sharp,
                color: DEFAULT_COLOR,
                size: 16.0,
              ),
              Text('Sign Out',
                  style:
                      GoogleFonts.lato(fontSize: 14.0, color: Colors.black54))
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text('Version 1.0.2021',
              style: GoogleFonts.lato(fontSize: 13.0, color: Colors.black54))
        ],
      ),
    );
  }
}

Widget items({icons = Icons.person, text = 'Company Profile', callBack}) {
  return InkWell(
    onTap: () => callBack(),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(.6),
              offset: Offset(0.0, 1.0),
              blurRadius: 9.0,
              spreadRadius: 1.0
            )
          ]),
          child: Row(children: [
            Icon(icons, size: 18.0, color: DEFAULT_COLOR,),
            const SizedBox(width: 18.0,),
            Text('$text', style: GoogleFonts.lato(fontSize: 15.0, color: Colors.black54))
          ]),
    ),
  );
}
