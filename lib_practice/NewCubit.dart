import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'NewsState.dart';
import 'Newsmodel.dart';

class NewCubit extends Cubit<NewsState> {
NewCubit():super(NewInitialState());
  Future<void>getNews()async{
    try{
      emit(NewLoadingState());
      final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=india=2026-10-19&sortBy=publishedAt&apiKey=3973b8d3bedd4072b61279dabb4d4789'));
      if(response.statusCode == 200){
        final Newmodal = jsonDecode(response.body);
        final NewSModal = Newsmodal.fromJson(Newmodal);
        emit(NewLoadedState(NewsModal: NewSModal));
      }
      else{
        emit(NewErrorState(error: response.body));
      }
  }
    catch(ex){
      emit(NewErrorState(error: ex.toString()));
    }
  }

}