import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/admin_dashboard_controller.dart';
import '../bloc/login_controller.dart';
import '../bloc/theme_controller.dart';
import '../util/theme.dart';


class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});
  
  @override
  Widget build(BuildContext context) {

    ThemeController themeController = Get.find();

    return MaterialApp(
      title: 'Dashboard'.tr,
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: themeController.themeSetting.value=='isLight'? ThemeMode.light: ThemeMode.dark,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Registration'.tr, style: Get.theme.textTheme.titleLarge!.copyWith(
              color: Get.theme.colorScheme.onPrimary,
            ))),
            leading: GetPlatform.isWeb?SizedBox(width: 0, height: 0,):IconButton(
              onPressed: () { Get.back(); },
              icon: Icon(Icons.arrow_back),),
          ),
          body: userRegistration(),
        ),
      ),
    );
  

  }
}

Widget userRegistration(){

  AdminDashboardController _adminDashboardController = Get.find();

  if (_adminDashboardController.pageView.value == 'ADMIN') {
    return UserRegistration("Admin User Registration", "Admin User", Get.width, Get.height, "ROLE_ADMIN", "BACKEND", "ADMIN_USER", "SYSTEM_ACTIVE", "PH");
  } else {
    return Container();
  }
}



class UserRegistration extends StatelessWidget {
  const UserRegistration(
      this.title,
      this.description,
      this.width,
      this.height,
      this.roles,
      this.type,
      this.userType,
      this.status,
      this.partner,
      {super.key});

  final String title;
  final String description;
  final double width;
  final double height;
  final String roles;
  final String type;
  final String userType;
  final String status;
  final String partner;


  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();

    AdminDashboardController _adminDashboardController = Get.find();
    LoginController _loginController = Get.find();

    var cred = _adminDashboardController.credential;

    bool isNumeric(String s) {
      int? num = int.tryParse(s);
      if(num == null ) {
        return false;
      } else {
        return true;
      }
    }

    return Container(
      width: width,
      height: height*0.87,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
      color: Color.fromARGB(55, 99, 99, 99),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(64),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(245, 255, 255, 255),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top:16.0, bottom:8),
                                child: Text(title, style: TextStyle(color: Colors.teal, fontSize: 18),),
                              ))),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom:8),
                                child: Text(description, style: TextStyle(color: Colors.grey[500], fontSize: 14),),
                              ))),
                        ],
                      ),

                      /*const Padding(
                      padding: EdgeInsets.only(top:32.0, bottom: 32),
                      child: Divider(
                        height: 1,
                      ),
                    ),
*/
                      SizedBox(width:0, height: 42,),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(16,8,16,0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.email, color: Colors.grey),
                            labelText: "Email",
                            hintText: "Enter value email like yourname@mail.com",
                            hintStyle: TextStyle(color:Colors.grey[400]),
                            //errorText: "isi alamat email",
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            cred.value.userId = value;
                          },
                          style: TextStyle(color:Colors.grey[700], fontSize: 14),
                          onSaved: (value){
                            cred.value.userId = value!;
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Fill in your email";
                            } else if(!value.contains("@")) {
                              return "Enter a valid email address";
                            } else if(!value.contains(".")){
                              return "Enter a valid email address";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(16,8,16,0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.person, color: Colors.grey),
                            labelText: "Nama",
                            hintText: "Masukkan nama anda",
                            hintStyle: TextStyle(color:Colors.grey[400]),
                            //errorText: "Ketik nama anda",
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            cred.value.name = value;
                            //memberBloc.credentialChange(cred);
                            //print("onChanged name : ${cred.name}");
                          },
                          style: TextStyle(color:Colors.grey[900], fontSize: 14),
                          onSaved: (value){
                            cred.value.name = value!;
                            //print("onSaved name : ${cred.name}");
                          },
                          validator: (value){
                            if(value!.isEmpty){
                              return "Isi nama anda";
                            } else if(value.length<3) {
                              return "isi nama lengkap";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.fromLTRB(16,8,16,0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            icon: const Icon(Icons.phone_android,  color: Colors.grey,),
                            labelText: "Mobile Phone Number",
                            hintText: "Enter your Mobile Phone Number",
                            hintStyle: TextStyle(color:Colors.grey[400]),
                            errorText: null,
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            cred.value.alias = value;
                          },
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 14,
                          ),
                          onSaved: (value){
                            cred.value.alias = value!;
                          },
                          validator: (value){
                            if(isNumeric(value!) && value.length>=10) {
                              return null;
                            } else {
                              return "Masukkan nomor HP yang benar";
                            }
                          },
                        ),
                      ),

                      SizedBox(height: 48, width: 0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          ElevatedButton(
                              onPressed: (){
                                _adminDashboardController.pageView.value="CREDENTIAL_OFF";
                              },
                              child: Text("Cancel", style: Get.theme.textTheme.bodyMedium!.copyWith(
                                color: Get.theme.colorScheme.onPrimary,
                              ))),

                          SizedBox(width: 32, height: 0,),

                          ElevatedButton(
                            child: Text("Submit", style: Get.theme.textTheme.bodyMedium!.copyWith(
                            color: Get.theme.colorScheme.onPrimary,
                            ),),
                            onPressed: (){

                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _adminDashboardController.pageView.value="CREDENTIAL_ONGOING";

                                cred.value.roles = roles; // "ROLE_PARK-USER";
                                cred.value.imei = "NA";
                                cred.value.enabled = true;
                                cred.value.accountNonExpired = false;
                                cred.value.dob="01-01-01";
                                cred.value.pob="ID";
                                cred.value.chain="NA";
                                cred.value.classification=partner;
                                cred.value.expired=false;
                                cred.value.locked=false;
                                cred.value.partner="PH";
                                cred.value.status=status; //"SYSTEM_BACKEND";
                                cred.value.trial=0;
                                cred.value.type=type; //"PARKING_USER";
                                cred.value.userTypes=userType;"PARKING_USER";

                                _adminDashboardController.submitUserRegistration(cred.value, _loginController.check.value.token, _loginController.check.value.userId);
                              }

                            },
                          ),
                        ],
                      ),

                      SizedBox(width: 0, height: 16,)

                    ],
                  ),
                ),

              ],

            ),
          ),
        ),
      ),
    );
  }
}
