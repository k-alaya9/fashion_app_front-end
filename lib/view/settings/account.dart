import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/account_controller.dart';

class AccountPage extends StatelessWidget {
  final AccountController controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          'Account',
          style: TextStyle(color: Colors.black, fontSize: 28),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('E-mail:', style: TextStyle(fontSize: 22)),
            SizedBox(height: 8.0),
            _buildTextField(controller.emailController, readOnly: true),
            SizedBox(height: 16.0),
            Text('Username:', style: TextStyle(fontSize: 22)),
            SizedBox(height: 8.0),
            _buildTextField(controller.usernameController),
            SizedBox(height: 16.0),
            Text('Password:', style: TextStyle(fontSize: 22)),
            SizedBox(height: 8.0),
            _buildTextField(controller.passwordController, obscureText: true),
            SizedBox(height: 32.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Success', 'Account details saved!',
                        snackPosition: SnackPosition.BOTTOM);
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,

                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller,
      {bool readOnly = false, bool obscureText = false}) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      ),
      style: TextStyle(fontSize: 22),
    );
  }
}
