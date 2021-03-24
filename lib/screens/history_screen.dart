import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soilnutrientanalyzer/bloc/result_history_bloc.dart';

class HistoryScreen extends StatelessWidget {
  final TextStyle style = TextStyle(
    color: Colors.black,
    fontSize: 18,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'History',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
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
      body: BlocBuilder<ResultHistoryCubit, ResultHistoryState>(
          builder: (BuildContext context, ResultHistoryState state) {
        if (state is ResultHistoryLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ResultHistoryError) {
          return Center(child: Text(state.error));
        } else if (state is ResultHistorySuccess) {
          if (state.history.length == 0) {
            return Center(
              child: Text(
                'No data available',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                childrenPadding: EdgeInsets.only(bottom: 20, left: 20),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                expandedAlignment: Alignment.centerLeft,
                title: Text(
                  state.history[index].crop.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    state.history[index].crop.image,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                children: state.history[index].result
                    .toMap()
                    .entries
                    .map((e) => Text(
                          '${e.key}: ${e.value}',
                          style: style,
                        ))
                    .toList(),
              );
            },
            itemCount: state.history.length,
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
