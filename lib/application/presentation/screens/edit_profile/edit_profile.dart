// import 'package:flip/application/presentation/utils/constants/constants.dart';
// import 'package:flip/application/presentation/widgets/elevated_button/elavated_button_widgets.dart';
// import 'package:flip/application/presentation/widgets/text_form_fields/textformfield_widget.dart';
// import 'package:flip/domain/models/user_model/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:image_gradient/image_gradient.dart';

// class EditProfile extends StatelessWidget {
//    EditProfile({super.key, required this.model});
//   final UserRepositoryModel model;

//   // final TextEditingController usernameController;
// // var usernameController =TextEditingController(text:model.username );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               SizedBox(
//                   height: screenFullHeight / 3.5,
//                   width: double.infinity,
//                   child: ImageGradient.linear(
//                     image: Image.asset(
//                       "assets/bearded-man-staying-nature.jpg",
//                       fit: BoxFit.cover,
//                     ),
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                     colors: const [
//                       Color.fromARGB(0, 149, 149, 149),
//                       Colors.white,
//                       Colors.white,
//                       Colors.white,
//                     ],
//                   )),
//               const Positioned(
//                   left: 20,
//                   bottom: 0,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: AssetImage('assets/testimage.jpeg'),
//                         radius: 50,
//                       )
//                     ],
//                   )),
             
//               Positioned(
//                 right: 1,
//                 child: IconButton(onPressed: (){}, icon: Icon(Iconsax.edit)))
//             ], 
//           ),
//           kHeight20,
//           TextFormFields(
//             padding: EdgeInsets.all(8),
//             controller: model.username,
//             hintText: 'Username', filledColor: Colors.grey.shade900, obscure: false),
//           TextFormFields(
//             padding: EdgeInsets.all(8),
//             hintText: 'Display Name', filledColor: Colors.grey.shade900, obscure: false),
//           TextFormFields(
//             padding: EdgeInsets.all(8),
//             hintText: 'Bio', filledColor: Colors.grey.shade900, obscure: false),
//             Spacer(),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButtonWidget(
                
//                 buttonTitle: Text('Save Updates'), style: TextStyle( ), buttonStyles: ButtonStyle()),
//             )
//             ,kHeight40
//         ],
//       ),
//     );
//   }
// }
