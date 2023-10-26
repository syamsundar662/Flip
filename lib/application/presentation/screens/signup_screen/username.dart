import 'package:flip/application/presentation/screens/signup_screen/signup_screen.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/text_form_fields/textformfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsernameRegistration extends StatelessWidget {
  UsernameRegistration({super.key});

  final _formkey = GlobalKey<FormState>();

  final String nameee = 'syam';
  final usernameRegistrationCOntroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenFullHeight,
        width: double.infinity,
        decoration: const BoxDecoration(gradient: mainGradient),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: kPaddingForTextfield,
                child: Text(
                  'Create Username',
                  style: GoogleFonts.baloo2(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: kPaddingForTextfield,
                child: Text(
                  'Add your name so that friends can find you.',
                  style: GoogleFonts.baloo2(fontSize: 15, color: Colors.white),
                ),
              ),
              kHeight10,
              TextFormFields(
                controller: usernameRegistrationCOntroller,
                suffixIconWidget: const Icon(
                  Icons.done,
                  color: Colors.green,
                ),
                hintText: 'Username',
                filledColor: Colors.white.withOpacity(.2),
                obscure: false,
                validator: (vakue) {
                  if (vakue!.isEmpty) {
                    return 'Enter your username';
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 33, right: 33, top: 15),
                  child: ElevatedButtonWidget(
                      onEvent: () {
                        _formkey.currentState!.validate();
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=> SignUpScreen(userName: usernameRegistrationCOntroller.text,))); 
                      },
                      buttonTitle: const Text(
                        'Continue ',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: const TextStyle(),
                      buttonStyles: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.blue.shade900),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)))))),
              kHeight50,
            ],
          ),
        ),
      ),
    );
  }
}
