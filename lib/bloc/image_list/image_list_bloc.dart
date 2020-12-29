import 'package:bloc/bloc.dart';
import 'package:unsplash_sample/bloc/infinite_list/image_list_event.dart';
import 'package:unsplash_sample/bloc/infinite_list/image_list_state.dart';

class ImageListBloc extends Bloc<ImageEvent, ImageListState> {
  static final ImageListBloc _imageListBlocSingleton = ImageListBloc._internal();
  factory ImageListBloc(){
    return _imageListBlocSingleton;
  }

  ImageListBloc._internal();

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