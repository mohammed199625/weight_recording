
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weight_bloc.dart';
import '../bloc/weight_state.dart';
import '../repo/weight_repo.dart';
import 'home_screen_ui.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    return RepositoryProvider(
      create: (context) => WeightRepository(),
      child: BlocProvider(
        create: (context) =>
            WeightBloc(
                weightRepository: RepositoryProvider.of<WeightRepository>(
                    context)),
        child: Scaffold(
            key: scaffoldKey,
            body:
            BlocListener<WeightBloc, WeightState>(listener: (context, state) {
              if (state is WeightAdded) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Product added"),
                  duration: Duration(seconds: 2),
                ));
              }
            }, child: BlocBuilder<WeightBloc, WeightState>(
              builder: (context, state) {
                if (state is WeightAdding) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WeightError) {
                  return const Center(child: Text("Error"));
                }
                return const HomePage();
              },
            ))),
      ),
    );
  }
}