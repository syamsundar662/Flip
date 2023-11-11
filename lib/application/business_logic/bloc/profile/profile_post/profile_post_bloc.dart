// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:flip/data/firebase/post_data_resourse/post_data.dart';
// import 'package:flip/domain/models/post_model/post_model.dart';

// part 'profile_post_event.dart';
// part 'profile_post_state.dart';

// class ProfilePostBloc extends Bloc<ProfilePostEvent, ProfilePostState> {
//   ProfilePostBloc() : super(ProfileInitial()) {
//     on<ProfilePostDataFetchEvent>(profileDataFetchEvent);
//   }

//   FutureOr<void> profileDataFetchEvent(ProfilePostDataFetchEvent event, Emitter<ProfilePostState> emit)async {
//     emit(ProfileFetchingState());
//     try{
//     final response = await Post().fetchPostDataByUser(event.id);
//     emit(ProfileFetchedState(model: response));
//     }catch (e){ 
//       emit(ProfileFetchingErrorState());
//     }
//   }
// }
