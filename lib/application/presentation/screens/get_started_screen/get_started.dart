import 'package:flip/application/presentation/screens/signup_screen/signup_screen.dart';
import 'package:flip/application/presentation/screens/signup_screen/widgets/animations.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/elavated_button_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key});

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
                  duration: Duration(milliseconds: 500),
                  child: Align(
                    alignment: Alignment(0.0, 1.5),
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
            Spacer(),
            SizedBox(
              height: screenFullHeight * .05,
              width: double.infinity,
              child: Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                    height: screenFullHeight * .2,
                    child: AnimatedOpacity(
                      opacity: _isVisible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 500),
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0, 1),
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
                            onEvent: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpScreen(),
                                ),
                              );
                              setState(() {
                                selected = false;
                              });
                            },
                            buttonTitle: 'Get Started',
                            style: const TextStyle(),
                            buttonStyles: const ButtonStyle(),
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




// class _GetStartedScreenState extends State<GetStartedScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(gradient: mainGradient),
//         child: Column(
//           children: [
//             SizedBox(
//                 height: screenFullHeight / 3,
//                 width: screenFullWidth,
//                 child:  FlipAlignAnimation(animationWidget: Text(
//           'Flip', 
//           style: GoogleFonts.baloo2(
//               fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white),
//         ),)),
//         Spacer(),
//             SizedBox(
//               height: screenFullHeight*.05,
//               width: double.infinity,
//               child: selected? SizedBox(
//                 height: screenFullHeight*.2 ,                child: Padding(
//                   padding: kPaddingForTextfield,
//                   child: ElevatedButtonWidget(
//                     onEvent: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen()));
//                       setState(() {
//                         selected = false;
//                       });
//                     },
//                     buttonTitle: 'Get Started',style: const TextStyle(),buttonStyles: const ButtonStyle(),),
//                 ),
//               ):Container()
//             ),
//             kHeight40,
//             kHeight40,
//           ],
//         ), 
//       ),
//     );
//   }
// }