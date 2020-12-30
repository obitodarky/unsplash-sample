import 'package:bloc/bloc.dart';
import 'package:unsplash_sample/bloc/image_list/image_list_event.dart';
import 'package:unsplash_sample/bloc/image_list/image_list_state.dart';

class ImageListBloc extends Bloc<ImageEvent, ImageListState> {
  ImageListBloc({ImageListState initialState}) : super(initialState);


  ImageListState get initialState => InitialPhotoListState();

  @override
  Stream<ImageListState> mapEventToState(ImageEvent event) async* {
    yield InitialPhotoListState();
    try{
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (error, stacktrace){
      print("$error $stacktrace");
      yield state;
    }
  }

}