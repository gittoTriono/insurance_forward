import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../util/screen_size.dart' as screenSize;
import '../bloc/admin_dashboard_controller.dart';
import '../bloc/login_controller.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {


    AdminDashboardController _adminDashboardController = Get.put(AdminDashboardController());
    LoginController _loginController = Get.find();

    _adminDashboardController.userid.value = _loginController.check.value.userId;
    _adminDashboardController.token.value = _loginController.check.value.token;

    double _width = Get.width;


    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              SizedBox(
                width: screenSize.screenSizeIndex(_width) > 3?(_width-100)/3: _width,
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person_add_alt_1, color: Colors.teal),
                        title: const Text("Admin"),
                        subtitle: AutoSizeText("Admin user"),
                        trailing: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: (){
                            _adminDashboardController.pageView.value = 'ADMIN';
                            Get.toNamed('/dashboard/registration');
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: (){
                                _adminDashboardController.pageView.value = 'USERS_LIST_VIEW';
                                _adminDashboardController.usersView.value = "";
                                _adminDashboardController.getUser(_loginController.check.value.userId, _loginController.check.value.token, "PARKING_USER", 0, 20, "userId");
                              },
                              child: Text("USERS", style: Get.textTheme.titleMedium)),
                        ],

                      ),



                    ],
                  ),
                ),
              ),

              // ================================================

              SizedBox(
                width: screenSize.screenSizeIndex(_width) > 3?(_width-100)/3: _width,
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person_add_alt_1, color: Colors.orange),
                        title: const Text("Operation"),
                        subtitle: AutoSizeText("Operation User"),
                        trailing: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: (){
                            _adminDashboardController.pageView.value = 'FINANCE';
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: (){
                                _adminDashboardController.pageView.value = 'USERS_LIST_VIEW';
                                _adminDashboardController.usersView.value = "";
                                _adminDashboardController.getUser(_loginController.check.value.userId, _loginController.check.value.token, "PARKING_USER_FIN", 0, 20, "userId");
                              },
                              child: Text("USERS", style: Get.textTheme.titleMedium)),
                        ],

                      ),
                    ],
                  ),
                ),
              ),

              // =============================================================

              SizedBox(
                width: screenSize.screenSizeIndex(_width) > 3?(_width-100)/3: _width,
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person_add_alt_1, color: Colors.deepOrange),
                        title: const Text("Finance"),
                        subtitle: AutoSizeText("Finance User"),
                        trailing: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: (){
                            _adminDashboardController.pageView.value = 'ADMIN';
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: (){
                                _adminDashboardController.pageView.value = 'USERS_LIST_VIEW';
                                _adminDashboardController.usersView.value = "";
                                _adminDashboardController.getUser(_loginController.check.value.userId, _loginController.check.value.token, "PARKING_USER_ADMIN", 0, 20, "userId");
                              },
                              child: Text("USERS", style: Get.textTheme.titleMedium)),
                        ],

                      ),





                    ],
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
