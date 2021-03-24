import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soilnutrientanalyzer/bloc/result_bloc.dart';
import 'package:soilnutrientanalyzer/metadata/meta_text.dart';

class ResultsScreen extends StatelessWidget {
  final TextStyle style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MetaText.soilNutrientAnalyzer,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<ResultCubit, ResultState>(
        builder: (BuildContext context, ResultState state) {
          if (state is ResultLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ResultError) {
            return Center(child: Text(state.error));
          } else if (state is ResultSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.asset(
                          state.crop.image,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        state.crop.name,
                        style: style,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text('pH value:  ${state.result.ph}', style: style),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '${state.temp}:  ${state.result.temperature}',
                      style: style,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      '${state.moisture}:  ${state.result.moisture}',
                      style: style,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text('npk ratio:  ${state.result.npkRatio}',
                        style: style),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
