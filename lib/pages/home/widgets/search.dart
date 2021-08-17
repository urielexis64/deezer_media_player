import 'package:deezer_media_player/blocs/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Bloc bloc = HomeBloc.of(context);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        return SliverToBoxAdapter(
          child: state.status == HomeStatus.selecting
              ? Container(
                  padding: EdgeInsets.all(15),
                  child: CupertinoTextField(
                    controller: _searchController,
                    onChanged: (text) {
                      bloc.add(OnSearchEvent(text));
                    },
                    placeholder: 'Search...',
                    suffix: Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: TweenAnimationBuilder<double>(
                          tween: state.searchText.isNotEmpty
                              ? Tween<double>(begin: 0, end: 1)
                              : Tween<double>(begin: 1, end: 0),
                          duration: Duration(milliseconds: 400),
                          curve: Curves.elasticInOut,
                          builder: (context, value, child) {
                            return Transform.scale(
                              scale: value,
                              child: CupertinoButton(
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(5),
                                  borderRadius: BorderRadius.circular(30),
                                  minSize: 25,
                                  child: child!,
                                  onPressed: () {
                                    _searchController.clear();
                                    bloc.add(OnSearchEvent(''));
                                  }),
                            );
                          },
                          child: Icon(Icons.clear)),
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
