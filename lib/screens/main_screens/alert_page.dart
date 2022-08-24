import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/Resusable.dart';

class AlertPage extends StatefulWidget {
  @override
  _AlertPageState createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final c = RefreshController();
  @override
  void initState() {
    context.read<Controller>().getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: SmartRefresher(
            controller: c,
            onRefresh: () =>
                context.read<Controller>().getNotifications(ctl: c),
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Center(
                            child: AutoSizeText('Alert',
                                minFontSize: 12,
                                maxFontSize: 18,
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, color: Color(0xff0D30D9)),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ]),
                  SizedBox(height: 25.0),
                  Expanded(
                    child: context.watch<Controller>().alertList.length > 0
                        ? SingleChildScrollView(
                            child: Column(
                            children: [
                              ...List.generate(
                                  context.watch<Controller>().alertList.length,
                                  (index) => AlertList(context, index))
                            ],
                          ))
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
