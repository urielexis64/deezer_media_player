import 'package:deezer_media_player/blocs/home/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        return SliverToBoxAdapter(
          child: state.status == HomeStatus.selecting
              ? Container(
                  padding: EdgeInsets.all(15),
                  child: CupertinoTextField(
                    placeholder: 'Search...',
                    suffix: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: CupertinoButton(
                          color: Colors.blue,
                          padding: EdgeInsets.all(5),
                          borderRadius: BorderRadius.circular(30),
                          minSize: 25,
                          child: Icon(Icons.clear),
                          onPressed: () {}),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffdddddd)),
                  ))
              : null,
        );
      },
    );
  }
}
