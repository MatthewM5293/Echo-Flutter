import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  final _postViewQueryManager = StreamRequestManager<UsersRecord>();
  Stream<UsersRecord> postViewQuery({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<UsersRecord> Function() requestFn,
  }) =>
      _postViewQueryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPostViewQueryCache() => _postViewQueryManager.clear();
  void clearPostViewQueryCacheKey(String? uniqueKey) =>
      _postViewQueryManager.clearRequest(uniqueKey);

  final _searchListManager = FutureRequestManager<List<UsersRecord>>();
  Future<List<UsersRecord>> searchList({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<UsersRecord>> Function() requestFn,
  }) =>
      _searchListManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearSearchListCache() => _searchListManager.clear();
  void clearSearchListCacheKey(String? uniqueKey) =>
      _searchListManager.clearRequest(uniqueKey);

  final _commentCountManager = FutureRequestManager<List<CommentsRecord>>();
  Future<List<CommentsRecord>> commentCount({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<List<CommentsRecord>> Function() requestFn,
  }) =>
      _commentCountManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearCommentCountCache() => _commentCountManager.clear();
  void clearCommentCountCacheKey(String? uniqueKey) =>
      _commentCountManager.clearRequest(uniqueKey);
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
