import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold( 
          appBar: AppBar( 
            title: const CupertinoSearchTextField(),
           
          ),
          body: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 2, mainAxisSpacing: 2,childAspectRatio: 1/1.5), 
                    itemBuilder: (BuildContext context,int index){
                      return Container(color: const Color.fromARGB(48, 93, 93, 93),);
                    }),
        ));
  }
}
 
