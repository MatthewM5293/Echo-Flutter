import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CommentsRecord extends FirestoreRecord {
  CommentsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "comment_owner" field.
  DocumentReference? _commentOwner;
  DocumentReference? get commentOwner => _commentOwner;
  bool hasCommentOwner() => _commentOwner != null;

  // "comment_message" field.
  String? _commentMessage;
  String get commentMessage => _commentMessage ?? '';
  bool hasCommentMessage() => _commentMessage != null;

  // "comment_postDate" field.
  DateTime? _commentPostDate;
  DateTime? get commentPostDate => _commentPostDate;
  bool hasCommentPostDate() => _commentPostDate != null;

  // "comment_editDate" field.
  DateTime? _commentEditDate;
  DateTime? get commentEditDate => _commentEditDate;
  bool hasCommentEditDate() => _commentEditDate != null;

  // "comment_originalMessage" field.
  String? _commentOriginalMessage;
  String get commentOriginalMessage => _commentOriginalMessage ?? '';
  bool hasCommentOriginalMessage() => _commentOriginalMessage != null;

  // "comment_post" field.
  DocumentReference? _commentPost;
  DocumentReference? get commentPost => _commentPost;
  bool hasCommentPost() => _commentPost != null;

  void _initializeFields() {
    _commentOwner = snapshotData['comment_owner'] as DocumentReference?;
    _commentMessage = snapshotData['comment_message'] as String?;
    _commentPostDate = snapshotData['comment_postDate'] as DateTime?;
    _commentEditDate = snapshotData['comment_editDate'] as DateTime?;
    _commentOriginalMessage =
        snapshotData['comment_originalMessage'] as String?;
    _commentPost = snapshotData['comment_post'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('comments');

  static Stream<CommentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CommentsRecord.fromSnapshot(s));

  static Future<CommentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CommentsRecord.fromSnapshot(s));

  static CommentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CommentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CommentsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CommentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CommentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CommentsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCommentsRecordData({
  DocumentReference? commentOwner,
  String? commentMessage,
  DateTime? commentPostDate,
  DateTime? commentEditDate,
  String? commentOriginalMessage,
  DocumentReference? commentPost,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'comment_owner': commentOwner,
      'comment_message': commentMessage,
      'comment_postDate': commentPostDate,
      'comment_editDate': commentEditDate,
      'comment_originalMessage': commentOriginalMessage,
      'comment_post': commentPost,
    }.withoutNulls,
  );

  return firestoreData;
}

class CommentsRecordDocumentEquality implements Equality<CommentsRecord> {
  const CommentsRecordDocumentEquality();

  @override
  bool equals(CommentsRecord? e1, CommentsRecord? e2) {
    return e1?.commentOwner == e2?.commentOwner &&
        e1?.commentMessage == e2?.commentMessage &&
        e1?.commentPostDate == e2?.commentPostDate &&
        e1?.commentEditDate == e2?.commentEditDate &&
        e1?.commentOriginalMessage == e2?.commentOriginalMessage &&
        e1?.commentPost == e2?.commentPost;
  }

  @override
  int hash(CommentsRecord? e) => const ListEquality().hash([
        e?.commentOwner,
        e?.commentMessage,
        e?.commentPostDate,
        e?.commentEditDate,
        e?.commentOriginalMessage,
        e?.commentPost
      ]);

  @override
  bool isValidKey(Object? o) => o is CommentsRecord;
}
