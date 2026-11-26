import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsappp/newsui.dart';

import 'NewCubit.dart';
import 'NewsState.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>NewCubit()..getNews(),
    child: MaterialApp(home: Newsapp(),),);
  }
}
class Newsapp extends StatelessWidget {
  const Newsapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NEWSAPP"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: BlocBuilder<NewCubit,NewsState>(builder: (context,states){
        if(states is NewLoadingState){
          Center(child: CircularProgressIndicator());
        }
        else if(states is NewErrorState){
          Center(child: Text(states.error));
        }
        else if(states is NewLoadedState){
          return ListView.builder(itemBuilder: (context,index){
            final data=states.NewsModal.articles![index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: data.urlToImage!.isEmpty?NetworkImage('https://newsapi.org/v2/everything?q=india=2026-10-19&sortBy=publishedAt&apiKey=3973b8d3bedd4072b61279dabb4d4789'):NetworkImage(data.urlToImage.toString())
              ),
              title:data.title!.isEmpty?Text('goo khaalo'):Text(data.title.toString()),
              subtitle: data.description!.isEmpty?Text('goo khaalo'):Text(data.description.toString()),
            );
          },itemCount: states.NewsModal.articles!.length,);
        }
        return Center(child: Text("BAND KARDE BOHOT HOGYA"));
      }),
    );
  }
}

