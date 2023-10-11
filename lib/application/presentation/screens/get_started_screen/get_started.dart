import 'package:flip/application/presentation/screens/signup_screen/signup_screen.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/elavated_button_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

bool selected = true;

class _GetStartedScreenState extends State<GetStartedScreen> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: mainGradient),
        child: Column(
          children: [
            SizedBox(
              height: screenFullHeight / 3,
              width: screenFullWidth,
              child:AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Align(
                    alignment: const Alignment(0.0, 1.5),
                    child: Text(
                      'Flip',
                      style: GoogleFonts.baloo2(
                          fontSize: 60, 
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            const Spacer(),
            SizedBox(
              height: screenFullHeight * .05,
              width: double.infinity,
              child: Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                    height: screenFullHeight * .2,
                    child: AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation( 
                            curve: Curves.easeIn, 
                            parent: ModalRoute.of(context)?.animation ?? 
                                AnimationController(vsync: ScaffoldState()),
                          ),
                        ),
                        child: Padding(
                          padding: kPaddingForTextfield,
                          child: ElevatedButtonWidget( 
                             style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),  
                            buttonStyles: ButtonStyle(
                              
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 255, 255, 255)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                    ),
                            onEvent: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute (
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                              setState(() {
                                selected = false;
                              });
                            },
                            
                            buttonTitle: 'Get Started', 
                         
                           
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            kHeight40,
            kHeight40,
          ],
        ),
      ),
    );
  }
} 
