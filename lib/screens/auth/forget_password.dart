import 'package:appwise_ecom/customs/custom_button.dart';
import 'package:appwise_ecom/customs/custom_field.dart';
import 'package:appwise_ecom/utils/text_utility.dart';
import 'package:appwise_ecom/validation/basic_validation.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  // void forgetPassword() async {
  //   try {
  //     if (_formKey.currentState!.validate()) {
  //       setLoader(ref, true);
  //       final Map<String, dynamic> body = {
  //         "name": nameController.text,
  //         "mobile": contactController.text,
  //         "email": emailController.text,
  //         "password": passwordController.text,
  //       };

  //       ApiResponse response = await RequestUtils().postRequest(
  //         url: ServiceUrl.singupUrl,
  //         body: body,
  //       );

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         context.pushReplacementNamed(RoutePath.loginScreen);
  //       }

  //       Utils.snackBar(response.message!, context);
  //       setLoader(ref, false);
  //     }
  //   } catch (e) {
  //     print(e);
  //     setLoader(ref, false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AppText(
                text: 'Forgot Password',
                fontsize: 34,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  customField(controller: emailController, labelText: 'Email', validator: validateEmail),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'SEND',
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
