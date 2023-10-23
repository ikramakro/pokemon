import 'package:animate_do/animate_do.dart';
import 'package:assesmant_task/core/constant/colors.dart';
import 'package:assesmant_task/core/model/user_model.dart';
import 'package:assesmant_task/screen/auth/sign_up_screen.dart';
import 'package:assesmant_task/screen/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserModel user = UserModel();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _formKey.currentState!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context);

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            // Color(0xffe5eec1),
            ksecondrayColor,
            kprimary1Color
          ],
              stops: const [
            0.5,
            1.0
          ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              tileMode: TileMode.decal)),
      child: Padding(
        padding: const EdgeInsets.all(30.0).w,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FadeInDown(
                  duration: const Duration(milliseconds: 1600),
                  child: Image.asset('assets/lock.png')),
              FadeInDown(
                  duration: const Duration(milliseconds: 1600),
                  child: Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: Text(
                        "Login with your Credentials",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              SizedBox(height: 0.025.sh),
              FadeInUp(
                  duration: const Duration(milliseconds: 1800),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          keyboardType: TextInputType.emailAddress,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                          name: 'email',
                          decoration: InputDecoration(
                              labelText: 'Email Address',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              )),
                          onChanged: (email) => user.email = email!,
                        ),
                        const SizedBox(height: 10),
                        FormBuilderTextField(
                          name: 'password',
                          decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                              )),
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(8)
                          ]),
                          onChanged: (password) => user.password = password!,
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 1900),
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.signIn(user: user);
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            const Color(0xff2f9395),
                            const Color(0xff2f9395).withAlpha(100),
                          ])),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 0.02.sh,
              ),
              FadeInUp(
                  duration: const Duration(milliseconds: 2000),
                  child: TextButton(
                      onPressed: () {
                        Get.to(() => SignUpScreen());
                      },
                      child: const Text(
                        "Dont have an account?  Sign up",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ))),
              SizedBox(height: MediaQuery.of(context).size.height),
            ],
          ),
        ),
      ),
    ));
  }
}
