import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'employer_settings.dart';
class EmployerSignUpSuccess extends StatelessWidget {
  const EmployerSignUpSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Center(
                  child: InkWell(
                    onTap: (){
                      Get.to(() =>  const EmployerSettings());
                    },
                    child: Image.asset('assets/signup succesful.png', alignment: Alignment.center,height: 180,width: 180,),
                  )
              );
            }
        ),

      ),
    );
  }
}
