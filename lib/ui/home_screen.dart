import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_movie_provider/data/movie_api.dart';
import 'package:flutter_movie_provider/model/movie.dart';
import 'package:flutter_movie_provider/ui/information_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> _movies = [];
  List<Movie> _originMovies = [];

  final _api = MovieApi();
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _showResult('');
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showResult(String query) async {
    _originMovies = await _api.fetchMovies(query);
    setState(() {
      _movies = _originMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: const Text('영화 정보 검색기'),
        actions: [
          IconButton(
            onPressed: () {
              _showResult('');
              // reset 아이콘 눌렀을 때에는 검색페이지로 다시 돌아오게 함.
            },
            icon: const Icon(
              Icons.settings_backup_restore_outlined,
            ),
          ),
        ],
      ),
/* Column 으로 잡은 후, 하단에 검색창과 GridView 로 리스트를 받아오는데
   Expanded 로 꽉 채워준다.
 */
      body: Column(
        children: [
          _buildTextField(),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: _buildGridView(),
          ),
        ],
      ),
    );
  }

// 검색어 입력시 데이터 값 반영.
  TextField _buildTextField() {
    return TextField(
      controller: _textEditingController,
      onChanged: (text) {
        _movies = _originMovies
            .where((e) => e.title.contains(_textEditingController.text))
            .toList();
        setState(() {});
      },
      decoration: InputDecoration(
        // border: InputBorder.none,
        // border가 보이지 않게 함
        suffix: IconButton(
          onPressed: () {
            _movies = _originMovies
                .where((e) => e.title.contains(_textEditingController.text))
                .toList();
            setState(() {});
          },
          icon: const Icon(Icons.search),
        ),
        hintText: '🎬검색어를 입력 해 주세요🎬',
      ),
    );
  }

// GridView 타입으로 받을 count 와 builder 를 지정해준다.
  GridView _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 5,
        childAspectRatio: 0.5,
      ),
      itemCount: _movies.length,
      itemBuilder: (context, index) {
// 상세보기 화면으로 넘어가기.
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InformationScreen(
                  movie: _movies[index],
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 10,
                fit: FlexFit.tight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _movies[index].posterPath.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'no image',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Image.network(
                          _movies[index].posterUrl,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Center(
                  child: Text(
                    _movies[index].title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        overflow: TextOverflow.fade),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
