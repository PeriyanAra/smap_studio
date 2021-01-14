import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* Blocs */
import 'package:smap_studio/blocs/gallery/bloc.dart';

/* Screens */
import 'package:smap_studio/screens/homepage/index.dart';

void main() {
  runApp(
    BlocProvider<GalleryBloc>(
      create: (context) => GalleryBloc(GalleryLoading()),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
