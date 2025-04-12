import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juan_kite/layouts/wide/cubit/wide_screen_cubit.dart';
import 'package:juan_kite/layouts/wide/view/wide_screen_page.dart';

class WideScreenLayout extends StatelessWidget {
  const WideScreenLayout({required this.constrains, super.key});

  final BoxConstraints constrains;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WideScreenCubit()..loadCategories(),
      lazy: false,
      child: WideScreenPage(constrains: constrains),
    );
  }
}
