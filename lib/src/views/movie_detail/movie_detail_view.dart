import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'movie_detail_view_model.dart';


class MovieDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MovieDetailViewModel>.reactive(
      viewModelBuilder: () => MovieDetailViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
        body: Container(),
      ),
    );
  }
}