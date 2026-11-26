import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsappp/cubits/newsstates1.dart';

import 'cubits/newscubit2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context)=>Newscubit()..getNews(),
        child: MaterialApp(home: NewsApp(), debugShowCheckedModeBanner: false));
  }
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewsApp"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<Newscubit,Newsstates>(
        builder: (context,state){
          if(state is Newsloadingstates){
            return Center(child: CircularProgressIndicator(),);
          }
          else if(state is Newserrorstates){
            return Center(child: Text(state.error),);
          }
          else if(state is Newsloadedstates){
            return ListView.builder(itemBuilder: (context,index){
              final data=state.newsModel.articles![index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: data.urlToImage!.isEmpty?NetworkImage('https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg'):NetworkImage(data.urlToImage.toString()),
                ),
                title: data.title!.isEmpty?Text('Test'):Text(data.title.toString()),
                subtitle: data.description!.isEmpty?Text('Teststs'):Text(data.description.toString()),
              );
            },itemCount: state.newsModel.articles!.length,);
          }
          return Center(child: Text('No Data Found'),);
        },
      )
    );
  }
}


