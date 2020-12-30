import 'package:bloc/bloc.dart';
import 'package:unsplash_sample/bloc/search_image/index.dart';


class SearchImageBloc extends Bloc<ImageSearchEvent, SearchImageListState> {
  bool isFetching;

  SearchImageBloc({SearchImageListState initialState}) : super(initialState);


  @override
  Stream<SearchImageListState> mapEventToState(ImageSearchEvent event) async* {
    try{
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (error, stacktrace){
      print("$error $stacktrace");
      yield state;
    }
  }
}