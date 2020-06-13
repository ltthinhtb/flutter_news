import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_news/service/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'save_list_news.dart';

class SaveListNewPageBloc
    extends Bloc<SaveListNewPageEvent, SaveListNewPageState> {
  SharedPreferences prefs;
  DocumentSnapshot doc;
  int isDark = 0;

  @override
  SaveListNewPageState get initialState => InitState();

  @override
  Stream<SaveListNewPageState> mapEventToState(
      SaveListNewPageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoadSaveListNewsEvent) {
      yield event.isRefresh ? InitState() : LoadingDataState();
      if (await getOption())
        isDark = 1;
      else
        isDark = 0;
      await getData();
      yield GetDataSuccess(doc);
    }
    if (event is DeleteLoveNewsEvent) {
      yield InitState();
      await DataBase(uid: event.id).deleteLoveNews();
      yield GetDataSuccess(doc);
    }
  }

  Future<DocumentSnapshot> getData() async {
    prefs = await SharedPreferences.getInstance();
    String userId = prefs.get('userId') ?? null;
    final databaseReference = Firestore.instance;
    var usersRef = databaseReference.collection("users");
    doc = await usersRef.document(userId).get();
    return doc;
  }

  Future<bool> getOption() async {
    prefs = await SharedPreferences.getInstance();
    bool option = prefs.get('theme_option') ?? false;
    return option;
  }
}
