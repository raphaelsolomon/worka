import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worka/screens/login_screen.dart';
class SignUpSuccess extends StatelessWidget {
  const SignUpSuccess({Key? key}) : super(key: key);

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
                    Get.to(() =>  const LoginScreen());
                  },
                  child: Image.asset('assets/signup succesful.png', alignment: Alignment.center,height: 220,width: 220,),
                )
              );
          }
        ),

      ),
    );
  }
}
