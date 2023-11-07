import 'package:flip/application/presentation/screens/home_screen/widgets/main_card_buttons.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/utils/timestamp/time_stamp.dart';
import 'package:flip/data/firebase/post_data_resourse/post_data.dart';
import 'package:flip/domain/models/post_model/post_model.dart';
import 'package:flutter/material.dart';

class HomeMainFeedsCard extends StatelessWidget {
  const HomeMainFeedsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
        stream: Post().getAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
          }
          final data = snapshot.data;
          return ListView.builder(
            padding: EdgeInsets.all(8),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/IMG_2468.JPG'),
                          radius: 18,
                        ),
                        kWidth10,
                        Text(
                          'Faizy',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Icon(Icons.more_vert)
                      ],
                    ),
                    kHeight10,
                    data[index].imageUrls.isNotEmpty?
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          constraints:
                              BoxConstraints(maxHeight: screenFullHeight / 1.8),
                          width: double.infinity,
                          child: Image.network(
                            data[index].imageUrls[0],
                            fit: BoxFit.cover,
                          ),
                        )): Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color.fromARGB(20, 159, 159, 159),
                            ),
                            child:  Padding( 
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                 data[index].textContent,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                    const PostMainCommonButtons(),
                    const Row(
                      children: [
                        kWidth10,
                        Text(
                          '324 likes and ',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        // kWidth10,
                        Text(
                          '56 comments',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                   data[index].imageUrls.isNotEmpty? Padding(
                      padding: const EdgeInsets.only(left: 10.5, right: 10),
                      child: Text(
                        data[index].textContent,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ):SizedBox(), 
                    Padding(
                      padding: const EdgeInsets.only(left: 10.5),
                      child: Text(
                        timeAgo(data[index].timestamp),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                    const Divider(
                      thickness: .1,
                    )
                  ],
                );
              });
        });
  }
}

// data[index].imageUrls.isEmpty
                            // ? Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Text(
                            //       data[index].textContent,
                            //       style: const TextStyle(fontSize: 18),
                            //     ),
                            //   )
                            // : 