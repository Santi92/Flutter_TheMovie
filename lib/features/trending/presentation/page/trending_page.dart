import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_themoviedb/core/di/injection_container.dart';
import 'package:test_themoviedb/features/trending/domain/models/movie.dart';
import 'package:test_themoviedb/features/trending/presentation/bloc/trending_bloc.dart';
import 'package:test_themoviedb/features/trending/presentation/bloc/trending_event.dart';
import 'package:test_themoviedb/features/trending/presentation/bloc/trending_state.dart';

class TredingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider(
          create: (context) => sl<TrendingBloc>()..add(LoadMovies()),
          child: Center(child: TredingPageWidget())),
    );
  }
}

class TredingPageWidget extends StatefulWidget {
  @override
  _TredingPageState createState() => _TredingPageState();
}

class _TredingPageState extends State<TredingPageWidget> {
  final _scrollController = ScrollController();
  late TrendingBloc _postBloc;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _postBloc = context.read<TrendingBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie'),
      ),
      body: Center(child: _bodyWidget(context)),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return BlocBuilder<TrendingBloc, TrendingState>(builder: (context, state) {
      if (state is TrendingLoadingState) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is TrendingLoadSuccess) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            return index >= state.movies.length
                ? BottomLoader()
                : _MovieItem(movie: state.movies[index]);
          },
          itemCount: state.hasReachedMax
              ? state.movies.length
              : state.movies.length + 1,
          controller: _scrollController,
        );
      }

      if (state is FailureConectionState) {
        return _showGenericError();
      }
      if (state is ConenctionErrorState) {
        return _showGenericError();
      }
      return _showGenericError();
    });
  }

  void _onScroll() {
    if (_isBottom) _postBloc.add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

Widget _showGenericError() {
  return Text(
    'Something went wrong!',
    style: TextStyle(color: Colors.red),
  );
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                    child: _showImagen(),
                  )),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0)
                      .copyWith(top: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(movie.title ?? "",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2),
                      Text(movie.getDeteString()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _showImagen() {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(movie.getMoviePath()),
        fit: BoxFit.fill,
      ),
    ));
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
