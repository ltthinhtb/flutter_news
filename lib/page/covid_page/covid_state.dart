import 'package:equatable/equatable.dart';
import 'package:flutter_news/models/response/covid_response.dart';


abstract class CovidPageState extends Equatable {
  CovidPageState([List props = const []]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class InitState extends CovidPageState {
  @override
  String toString() {
    return 'InitState{}';
  }
}

class LoadingDataState extends CovidPageState {
  @override
  String toString() {
    return 'LoadingDataState{}';
  }
}

class GetDataSuccess extends CovidPageState {
  final CovidResponse covidResponse;

  GetDataSuccess( this.covidResponse);

  @override
  String toString() {
    return 'GetDataSuccess{covidResponse: $covidResponse}';
  }


}
