import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'recent_list_news.dart';

class RecentListNewPageBloc
    extends Bloc<RecentListNewPageEvent, RecentListNewPageState> {
  SharedPreferences prefs;
  DocumentSnapshot doc;
  int isDark = 0;

  @override
  // TODO: implement initialState
  RecentListNewPageState get initialState => InitState();

  @override
  Stream<RecentListNewPageState> mapEventToState(
      RecentListNewPageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoadRecentListNewsEvent) {
      yield event.isRefresh ? InitState() : LoadingDataState();
      await getData();
      if (await getOption())
        isDark = 1;
      else
        isDark = 0;
      await getData();
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
