import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "userName" field.
  String? _userName;
  String get userName => _userName ?? '';
  bool hasUserName() => _userName != null;

  // "dateOfBirth" field.
  DateTime? _dateOfBirth;
  DateTime? get dateOfBirth => _dateOfBirth;
  bool hasDateOfBirth() => _dateOfBirth != null;

  // "bio" field.
  String? _bio;
  String get bio => _bio ?? '';
  bool hasBio() => _bio != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "followed_by" field.
  List<DocumentReference>? _followedBy;
  List<DocumentReference> get followedBy => _followedBy ?? const [];
  bool hasFollowedBy() => _followedBy != null;

  // "following" field.
  List<DocumentReference>? _following;
  List<DocumentReference> get following => _following ?? const [];
  bool hasFollowing() => _following != null;

  // "postNum" field.
  int? _postNum;
  int get postNum => _postNum ?? 0;
  bool hasPostNum() => _postNum != null;

  void _initializeFields() {
    _password = snapshotData['Password'] as String?;
    _uid = snapshotData['uid'] as String?;
    _email = snapshotData['email'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _userName = snapshotData['userName'] as String?;
    _dateOfBirth = snapshotData['dateOfBirth'] as DateTime?;
    _bio = snapshotData['bio'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _followedBy = getDataList(snapshotData['followed_by']);
    _following = getDataList(snapshotData['following']);
    _postNum = castToType<int>(snapshotData['postNum']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? password,
  String? uid,
  String? email,
  DateTime? createdTime,
  String? phoneNumber,
  String? photoUrl,
  String? userName,
  DateTime? dateOfBirth,
  String? bio,
  String? displayName,
  int? postNum,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Password': password,
      'uid': uid,
      'email': email,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'photo_url': photoUrl,
      'userName': userName,
      'dateOfBirth': dateOfBirth,
      'bio': bio,
      'display_name': displayName,
      'postNum': postNum,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.password == e2?.password &&
        e1?.uid == e2?.uid &&
        e1?.email == e2?.email &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.userName == e2?.userName &&
        e1?.dateOfBirth == e2?.dateOfBirth &&
        e1?.bio == e2?.bio &&
        e1?.displayName == e2?.displayName &&
        listEquality.equals(e1?.followedBy, e2?.followedBy) &&
        listEquality.equals(e1?.following, e2?.following) &&
        e1?.postNum == e2?.postNum;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.password,
        e?.uid,
        e?.email,
        e?.createdTime,
        e?.phoneNumber,
        e?.photoUrl,
        e?.userName,
        e?.dateOfBirth,
        e?.bio,
        e?.displayName,
        e?.followedBy,
        e?.following,
        e?.postNum
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
