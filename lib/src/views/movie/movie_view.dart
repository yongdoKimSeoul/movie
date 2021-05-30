import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'movie_view_model.dart';

class MovieView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MovieViewModel>.reactive(
      viewModelBuilder: () => MovieViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
        body: Container(),
      ),
    );
  }
}