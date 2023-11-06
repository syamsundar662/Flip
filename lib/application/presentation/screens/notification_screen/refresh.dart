import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshWid extends StatefulWidget {
  const RefreshWid({Key? key});

  @override
  State<RefreshWid> createState() => _RefreshWidState(); 
}

class _RefreshWidState extends State<RefreshWid> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async { 
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async { 
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(),
      body: SafeArea (
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
               Widget body;
              if (mode == LoadStatus.idle) {
                body = const Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = const Text("Load Failed! Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = const Text("release to load more");
              } else {
                body = const Text("No more Data"); 
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
              
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading, 
          child:ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(2),
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary.withOpacity(.3)),
            child: const Row(
              children: [
                kWidth10,
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/brunette-girl-walking-through-park-during-autumn.jpg'),
                  radius: 30,
                ),
                kWidth10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ntofitication'),
                    // Text('Message'),
                  ],
                ),
                Spacer(),
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/brunette-girl-walking-through-park-during-autumn.jpg'),
                  radius: 30,
                ),
                kWidth10
              ],
            ),
          );
        })  
        ),
      ),
    );
  }
}
