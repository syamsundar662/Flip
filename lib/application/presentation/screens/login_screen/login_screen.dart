import 'package:flip/application/presentation/screens/home_screen/home.dart';
import 'package:flip/application/presentation/screens/signup_screen/signup_screen.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/elavated_button_widgets.dart';
import 'package:flip/application/presentation/widgets/textformfield_widget.dart';
import 'package:flip/data/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey =GlobalKey<FormState>();

  bool isVisible = false;
  bool obscureTxt = true;
   @override 
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {
        setState(() {
          isVisible = true;
        });
      }
    }); 
  }

  @override
  Widget build(BuildContext context) {
     size(context);
    return Scaffold(
      body: Container(
        height: screenFullHeight,
        width: screenFullWidth,
        decoration: const BoxDecoration(
          gradient: mainGradient 
          
        ),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView( 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ 
                 SizedBox(
                    height: screenFullHeight / 2,
                    width: screenFullWidth,
                    child:  AnimatedOpacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 700),
                    child: Align(
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 1),
                          end: Offset.zero, 
                        ).animate(
                          CurvedAnimation(
                            curve: Curves.easeInOut,
                            parent: ModalRoute.of(context)?.animation ??
                                AnimationController(vsync: ScaffoldState()),
                          ),
                        ),
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
                  ), 
               AnimatedOpacity(
                 opacity: isVisible ? 1 : 0,
                  duration: const Duration(milliseconds: 700),
                 child: SlideTransition(
                   position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        curve: Curves.easeInOut,
                        parent: ModalRoute.of(context)?.animation ??
                            AnimationController(vsync: ScaffoldState()),
                      ),
                    ),
                   child: TextFormFields(
                    obscure: false,
                    controller: gmailController ,
                     validator: (value){
                      if(value==null){
                        return 'enter value';
                      }else{
                        return null;
                      }
                      
                    },
                     filledColor: Color.fromARGB(50, 158, 158, 158),
                    hintText: 'Enter your gmail',),
                 ),
               ), 
              kHeight10, 
               AnimatedOpacity(
                 opacity: isVisible ? 1 : 0,
                  duration: const Duration(milliseconds: 700),
                 child: SlideTransition(
                   position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate( 
                      CurvedAnimation(
                        curve: Curves.easeInOut,
                        parent: ModalRoute.of(context)?.animation ??
                            AnimationController(vsync: ScaffoldState()),
                      ),
                    ),
                   child: TextFormFields(
                      obscure: obscureTxt,
                      validator: (value) {
                        if (value == null) {
                          return 'Enter a password';
                        } else {
                          return null;
                        }
                      },
                      filledColor: const Color.fromARGB(50, 158, 158, 158),
                      hintText: 'Enter a password',
                      controller: passwordController,
                      suffixIconWidget: obscureTxt? IconButton(
                        
                        highlightColor: Colors.transparent ,
                        onPressed: (){
                        setState(() { 
                          obscureTxt =false; 
                        });

                      }, icon: Icon(Icons.visibility_outlined),
                       color: Color.fromARGB(102, 255, 255, 255)) :
                      
                      IconButton(
                        highlightColor: Colors.transparent ,
                        onPressed:(){
                        setState(() {
                        obscureTxt = true; 
                          
                        });
                      }, 
                        icon :Icon(Icons.visibility_off_outlined,),
                        color: Color.fromARGB(102, 255, 255, 255)
                        ),
                      )
                 ),
               ),
              kHeight10,
               AnimatedOpacity(
                opacity: isVisible? 1:0,
                duration: Duration(milliseconds: 1000 ),
                 child: SlideTransition(
                   position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(
                        CurvedAnimation(
                          curve: Curves.easeInOut,
                          parent: ModalRoute.of(context)?.animation ??
                              AnimationController(vsync: ScaffoldState()),
                        ),
                      ),
                   child: Padding(
                    padding: kPaddingForTextfield,
                    child:  ElevatedButtonWidget(
                          onEvent: () async{
                            _formkey.currentState!.validate(); 
                            await AuthRepository().signIn(gmailController.text, passwordController.text);
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
                              
                              }, 
                          buttonTitle:Text("Login",style: TextStyle(color: Colors.white  ),),
                          style: const TextStyle(color: Colors.white),
                          buttonStyles: ButtonStyle( 
                              backgroundColor: const MaterialStatePropertyAll(
                                  Color.fromARGB(255, 41, 87, 195)),
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)))),
                        ),
                               ),
                 ),
               ),
              kHeight40,
              kHeight40,
              kHeight40,
              kHeight40,
              InkWell(
                            onTap: (){
                              Navigator.push(context, CupertinoPageRoute(builder: (context)=>SignUpScreen()));
                            },
                            child: const Text(
                              'Dont have an account? Create.',
                              style: TextStyle(fontSize: 14, color: Colors.white),
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