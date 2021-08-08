import 'package:deezer_media_player/blocs/home/bloc.dart';
import 'package:deezer_media_player/flutter_inner_drawer.dart';
import 'package:deezer_media_player/pages/home/widgets/artist_picker.dart';
import 'package:deezer_media_player/pages/home/widgets/home_bottom_bar.dart';
import 'package:deezer_media_player/pages/home/widgets/home_header.dart';
import 'package:deezer_media_player/pages/home/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<InnerDrawerState> _drawerStateKey = GlobalKey();
  final HomeBloc _bloc = HomeBloc();

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: InnerDrawer(
        key: _drawerStateKey,
        onTapClose: true,
        rightChild: Container(
          color: Colors.white,
        ),
        scaffold: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            bottomNavigationBar: HomeBottomBar(),
            body: CustomScrollView(
              slivers: [
                HomeHeader(drawerKey: _drawerStateKey),
                Search(),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (_, state) {
                    if (state.status == HomeStatus.selecting) {
                      return ArtistPicker();
                    }

                    String textStatus = '';

                    switch (state.status) {
                      case HomeStatus.cheking:
                        textStatus = 'Cheking DB...';
                        break;
                      case HomeStatus.loading:
                        textStatus = 'Loading artists...';
                        break;
                      case HomeStatus.downloading:
                        textStatus = 'Downloading tracks...';
                        break;
                      default:
                        textStatus = '';
                    }

                    return SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: LinearProgressIndicator(),
                          ),
                          Text(textStatus)
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
