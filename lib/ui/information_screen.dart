import 'package:flutter/material.dart';
import 'package:flutter_movie_provider/model/movie.dart';

class InformationScreen extends StatelessWidget {
  final Movie movie;

  const InformationScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: Text(movie.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: double.infinity,
                            child: Image.network(movie.posterUrl),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '개봉일 ' + movie.releaseDate,
                                style: const TextStyle(fontSize: 12),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    child: TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.check,
                                        size: 12.0,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        movie.voteCount.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: 65,
                                    child: TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.star,
                                        size: 12.0,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        movie.voteAverage.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 3,
                  child: Text(
                    movie.overView,
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
