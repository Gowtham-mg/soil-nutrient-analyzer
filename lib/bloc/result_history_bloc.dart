import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:soilnutrientanalyzer/bloc/result_bloc.dart';

class ResultHistoryCubit extends Cubit<ResultHistoryState> {
  final FirebaseFirestore firestore;
  final Box box;
  ResultHistoryCubit(this.firestore, this.box) : super(ResultHistoryInitial());

  void getHistory() async {
    try {
      emit(ResultHistoryLoading());
      String token = box.get('token').toString();
      QuerySnapshot snapshot = await firestore
          .collection('result')
          .where('id', isEqualTo: token)
          .get();
      List<Map<String, dynamic>> data =
          snapshot.docs.map((e) => e.data()).toList();
      List<ResultSuccess> history =
          data.map((e) => ResultSuccess.fromMap(e)).toList();
      emit(ResultHistorySuccess(history));
    } catch (e) {
      emit(ResultHistoryError(e.toString()));
    }
  }
}

abstract class ResultHistoryState extends Equatable {}

class ResultHistoryInitial extends ResultHistoryState {
  @override
  List<Object> get props => [];
}

class ResultHistoryLoading extends ResultHistoryState {
  @override
  List<Object> get props => [];
}

class ResultHistorySuccess extends ResultHistoryState {
  final List<ResultSuccess> history;

  ResultHistorySuccess(this.history);
  @override
  List<Object> get props => [];
}

class ResultHistoryError extends ResultHistoryState {
  final String error;

  ResultHistoryError(this.error);
  @override
  List<Object> get props => [];
}
