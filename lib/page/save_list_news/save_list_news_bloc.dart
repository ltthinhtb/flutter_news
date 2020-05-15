import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'save_list_news.dart';

class SaveListNewPageBloc
    extends Bloc<SaveListNewPageEvent, SaveListNewPageState> {
  SharedPreferences prefs;
  DocumentSnapshot doc;

  @override
  SaveListNewPageState get initialState => InitState();

  @override
  Stream<SaveListNewPageState> mapEventToState(
      SaveListNewPageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoadSaveListNewsEvent) {
      yield event.isRefresh ? InitState() : LoadingDataState();
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
}