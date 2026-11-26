import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsappp/cubits/newsstates1.dart';
import 'package:http/http.dart' as http;
import 'package:newsappp/newmodel.dart';

class Newscubit extends Cubit<Newsstates> {
  Newscubit() : super(Newsinitialstates());

  Future<void> getNews() async {
    try {
      emit(Newsloadingstates());
      final response = await http.get(
        Uri.parse(
          'https://newsapi.org/v2/everything?q=tesla&from=2026-10-19&sortBy=publishedAt&apiKey=3973b8d3bedd4072b61279dabb4d4789',
        ),
      );
      if (response.statusCode == 200) {
        final newmodel = jsonDecode(response.body);
        final newsssmodel = newsmodel.fromJson(newmodel);
        emit(Newsloadedstates(newsModel: newsssmodel));
      } else {
        emit(Newserrorstates(error: response.body));
      }
    } catch (ex) {
      emit(Newserrorstates(error: ex.toString()));
    }
  }
}
