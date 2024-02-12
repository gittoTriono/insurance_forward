import '../bloc/login_controller.dart';
import '../bloc/reset_controller.dart';
import '../util/style.dart';
import 'custom_main_page_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Drawer getDrawer(BuildContext context){

  LoginController _loginController = Get.find();
  ResetController _resetController = Get.find();

  return Drawer(
    child: Container(
      color: Colors.white,
      child: ListView(
        children: [

          const SizedBox(height: 24, width: 0,),

          GetX<LoginController>(
              builder: (_controller) {

                if(_controller.imageData.value.available==true && _controller.login.value.isTrue){
                  return Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),

                      child: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(100),
                          child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.memory(_controller.imageData.value.img, width: 100, height: 100,))),
                      ),
                  );

                } else {
                  return Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),

                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.asset("assets/images/logo_square.png"))),

                    ),
                  );
                }
              }
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
            child: Divider(
              color: lightGrey,
            ),
          ),

          GetX<LoginController>(
            builder: (_controller) {

              if(_controller.login.value.isTrue){
                return ListTile(
                  title: drawerTextButton(const Icon(Icons.person), "profile-picture".tr, "/avatar"),
                );
              } else {
                return const SizedBox(width: 0, height: 0,);
              }
            }
          ),


          /*GetX<LoginController>(
            builder: (_controller) {

            if(_controller.login.value.isTrue){
              return ListTile(
                title: TextButton(
                  style: drawerTextButtonStyle(),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.refresh_outlined)),
                      ),

                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Text("reset-password".tr))),
                    ],
                  ),
                  onPressed: (){
                    _loginController.views.value = "MAIN_PAGE_OFF";
                    _resetController.views.value = "RESET_VIEW";
                    Get.back();
                  },
                ),
              );
            } else {
              return const SizedBox(width: 0, height: 0,);
            }


            }
          ),*/

          GetX<LoginController>(
              builder: (_controller) {

                if(_controller.login.value.isTrue){
                  return ListTile(
                    title: TextButton(
                      style: drawerTextButtonStyle(),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Icon(Icons.shuffle)),
                          ),

                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Text("change_pass_button".tr))),
                        ],
                      ),
                      onPressed: (){

                        Get.back();
                      },
                    ),
                  );
                } else {
                  return const SizedBox(width: 0, height: 0,);
                }


              }
          ),


        ],
      ),
    ),
  );

}