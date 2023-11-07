import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/data/firebase/post_data_resourse/post_data.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flutter/material.dart';

class PostSection extends StatelessWidget {
   PostSection({super.key});
  final id =FirebaseAuth.instance.currentUser!.uid; 

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
      stream: Post().fetchDataByUser(id),
      builder: (context, snapshot) { 
        if(snapshot.connectionState==ConnectionState.waiting || snapshot.hasError){
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        final data = snapshot.data;
        int postsWithNoImages = data?.where((post) => post.imageUrls.isEmpty).length ?? 0;

        return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),  
            shrinkWrap: true,
            itemCount: snapshot.data!.length - 5,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
            itemBuilder: (context, index) {
              
              return data![index].imageUrls[0].isNotEmpty? Container( 
                
                decoration: BoxDecoration(  
                  image: DecorationImage(image:  
                  NetworkImage(data[index].imageUrls[0]) ,fit: BoxFit.cover),
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10)),
              ):SizedBox();
            });
      }
    );
  }   
}
