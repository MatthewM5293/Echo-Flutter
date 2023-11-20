import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PostsRecord extends FirestoreRecord {
  PostsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "post_owner" field.
  DocumentReference? _postOwner;
  DocumentReference? get postOwner => _postOwner;
  bool hasPostOwner() => _postOwner != null;

  // "post_caption" field.
  String? _postCaption;
  String get postCaption => _postCaption ?? '';
  bool hasPostCaption() => _postCaption != null;

  // "post_image" field.
  String? _postImage;
  String get postImage => _postImage ?? '';
  bool hasPostImage() => _postImage != null;

  // "post_likedby" field.
  List<DocumentReference>? _postLikedby;
  List<DocumentReference> get postLikedby => _postLikedby ?? const [];
  bool hasPostLikedby() => _postLikedby != null;

  // "post_editdate" field.
  DateTime? _postEditdate;
  DateTime? get postEditdate => _postEditdate;
  bool hasPostEditdate() => _postEditdate != null;

  // "post_original_caption" field.
  String? _postOriginalCaption;
  String get postOriginalCaption => _postOriginalCaption ?? '';
  bool hasPostOriginalCaption() => _postOriginalCaption != null;

  // "post_date" field.
  DateTime? _postDate;
  DateTime? get postDate => _postDate;
  bool hasPostDate() => _postDate != null;

  // "post_comments_enabled" field.
  bool? _postCommentsEnabled;
  bool get postCommentsEnabled => _postCommentsEnabled ?? false;
  bool hasPostCommentsEnabled() => _postCommentsEnabled != null;

  // "post_comments" field.
  List<DocumentReference>? _postComments;
  List<DocumentReference> get postComments => _postComments ?? const [];
  bool hasPostComments() => _postComments != null;

  void _initializeFields() {
    _postOwner = snapshotData['post_owner'] as DocumentReference?;
    _postCaption = snapshotData['post_caption'] as String?;
    _postImage = snapshotData['post_image'] as String?;
    _postLikedby = getDataList(snapshotData['post_likedby']);
    _postEditdate = snapshotData['post_editdate'] as DateTime?;
    _postOriginalCaption = snapshotData['post_original_caption'] as String?;
    _postDate = snapshotData['post_date'] as DateTime?;
    _postCommentsEnabled = snapshotData['post_comments_enabled'] as bool?;
    _postComments = getDataList(snapshotData['post_comments']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('posts');

  static Stream<PostsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PostsRecord.fromSnapshot(s));

  static Future<PostsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PostsRecord.fromSnapshot(s));

  static PostsRecord fromSnapshot(DocumentSnapshot snapshot) => PostsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PostsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PostsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PostsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PostsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPostsRecordData({
  DocumentReference? postOwner,
  String? postCaption,
  String? postImage,
  DateTime? postEditdate,
  String? postOriginalCaption,
  DateTime? postDate,
  bool? postCommentsEnabled,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'post_owner': postOwner,
      'post_caption': postCaption,
      'post_image': postImage,
      'post_editdate': postEditdate,
      'post_original_caption': postOriginalCaption,
      'post_date': postDate,
      'post_comments_enabled': postCommentsEnabled,
    }.withoutNulls,
  );

  return firestoreData;
}

class PostsRecordDocumentEquality implements Equality<PostsRecord> {
  const PostsRecordDocumentEquality();

  @override
  bool equals(PostsRecord? e1, PostsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.postOwner == e2?.postOwner &&
        e1?.postCaption == e2?.postCaption &&
        e1?.postImage == e2?.postImage &&
        listEquality.equals(e1?.postLikedby, e2?.postLikedby) &&
        e1?.postEditdate == e2?.postEditdate &&
        e1?.postOriginalCaption == e2?.postOriginalCaption &&
        e1?.postDate == e2?.postDate &&
        e1?.postCommentsEnabled == e2?.postCommentsEnabled &&
        listEquality.equals(e1?.postComments, e2?.postComments);
  }

  @override
  int hash(PostsRecord? e) => const ListEquality().hash([
        e?.postOwner,
        e?.postCaption,
        e?.postImage,
        e?.postLikedby,
        e?.postEditdate,
        e?.postOriginalCaption,
        e?.postDate,
        e?.postCommentsEnabled,
        e?.postComments
      ]);

  @override
  bool isValidKey(Object? o) => o is PostsRecord;
}
