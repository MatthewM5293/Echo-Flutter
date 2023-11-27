import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_view_model.dart';
export 'profile_view_model.dart';

class ProfileViewWidget extends StatefulWidget {
  const ProfileViewWidget({
    Key? key,
    required this.userToView,
  }) : super(key: key);

  final DocumentReference? userToView;

  @override
  _ProfileViewWidgetState createState() => _ProfileViewWidgetState();
}

class _ProfileViewWidgetState extends State<ProfileViewWidget> {
  late ProfileViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileViewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return FutureBuilder<UsersRecord>(
      future: (_model.documentRequestCompleter ??= Completer<UsersRecord>()
            ..complete(UsersRecord.getDocumentOnce(widget.userToView!)))
          .future,
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 35.0,
                height: 35.0,
                child: SpinKitWave(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 35.0,
                ),
              ),
            ),
          );
        }
        final profileViewUsersRecord = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: true,
              actions: [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.00, 1.00),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 16.0),
                            child: Container(
                              width: 90.0,
                              height: 90.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).accent1,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).primary,
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 4.0, 4.0, 4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Image.network(
                                    valueOrDefault<String>(
                                      profileViewUsersRecord.photoUrl,
                                      'https://t4.ftcdn.net/jpg/00/97/58/97/360_F_97589769_t45CqXyzjz0KXwoBZT9PRaWGHRk5hQqQ.jpg',
                                    ),
                                    width: 100.0,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Text(
                            profileViewUsersRecord.displayName,
                            style: FlutterFlowTheme.of(context).headlineSmall,
                          ),
                        ),
                        if (widget.userToView == currentUserReference)
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(1.00, 0.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed('EditProfile');
                                  },
                                  text: 'Edit Profile',
                                  icon: Icon(
                                    Icons.edit,
                                    size: 14.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 40.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'VT323',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if ((widget.userToView?.id !=
                                currentUserReference?.id) &&
                            ((currentUserDocument?.following?.toList() ?? [])
                                    .contains(
                                        profileViewUsersRecord.reference) ==
                                false))
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(1.00, 0.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      await currentUserReference!.update({
                                        ...mapToFirestore(
                                          {
                                            'following': FieldValue.arrayUnion([
                                              profileViewUsersRecord.reference
                                            ]),
                                          },
                                        ),
                                      });

                                      await profileViewUsersRecord.reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'followed_by':
                                                FieldValue.arrayUnion(
                                                    [currentUserReference]),
                                          },
                                        ),
                                      });
                                      setState(() => _model
                                          .documentRequestCompleter = null);
                                      await _model
                                          .waitForDocumentRequestCompleted();
                                    },
                                    text: 'Follow',
                                    icon: Icon(
                                      Icons.person_add,
                                      size: 14.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'VT323',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if ((profileViewUsersRecord.reference !=
                                currentUserReference) &&
                            ((currentUserDocument?.following?.toList() ?? [])
                                    .contains(
                                        profileViewUsersRecord.reference) ==
                                true))
                          Expanded(
                            child: Align(
                              alignment: AlignmentDirectional(1.00, 0.00),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      await currentUserReference!.update({
                                        ...mapToFirestore(
                                          {
                                            'following':
                                                FieldValue.arrayRemove([
                                              profileViewUsersRecord.reference
                                            ]),
                                          },
                                        ),
                                      });

                                      await profileViewUsersRecord.reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'followed_by':
                                                FieldValue.arrayRemove(
                                                    [currentUserReference]),
                                          },
                                        ),
                                      });
                                      setState(() => _model
                                          .documentRequestCompleter = null);
                                      await _model
                                          .waitForDocumentRequestCompleted();
                                    },
                                    text: 'Unfollow',
                                    icon: Icon(
                                      Icons.person_remove_outlined,
                                      size: 14.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'VT323',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                      elevation: 3.0,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 8.0),
                    child: Text(
                      profileViewUsersRecord.userName,
                      style: FlutterFlowTheme.of(context).labelLarge,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 2.0, 16.0, 8.0),
                    child: Text(
                      profileViewUsersRecord.bio,
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Followers',
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 8.0),
                                child: Text(
                                  formatNumber(
                                    profileViewUsersRecord.followedBy.length,
                                    formatType: FormatType.compact,
                                  ),
                                  style:
                                      FlutterFlowTheme.of(context).displaySmall,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Following',
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 8.0, 0.0, 8.0),
                                child: Text(
                                  formatNumber(
                                    profileViewUsersRecord.following.length,
                                    formatType: FormatType.compact,
                                  ),
                                  style:
                                      FlutterFlowTheme.of(context).displaySmall,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                    child: Text(
                      'All Posts',
                      style: FlutterFlowTheme.of(context).labelLarge,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                      child: StreamBuilder<List<PostsRecord>>(
                        stream: queryPostsRecord(
                          queryBuilder: (postsRecord) => postsRecord
                              .where(
                                'post_owner',
                                isEqualTo: profileViewUsersRecord.reference,
                              )
                              .orderBy('post_date', descending: true),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 35.0,
                                height: 35.0,
                                child: SpinKitWave(
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 35.0,
                                ),
                              ),
                            );
                          }
                          List<PostsRecord> gridViewPostsRecordList =
                              snapshot.data!;
                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 16.0,
                              childAspectRatio: 1.0,
                            ),
                            scrollDirection: Axis.vertical,
                            itemCount: gridViewPostsRecordList.length,
                            itemBuilder: (context, gridViewIndex) {
                              final gridViewPostsRecord =
                                  gridViewPostsRecordList[gridViewIndex];
                              return InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(
                                    'PostDetails',
                                    queryParameters: {
                                      'post': serializeParam(
                                        gridViewPostsRecord,
                                        ParamType.Document,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      'post': gridViewPostsRecord,
                                    },
                                  );
                                },
                                child: Container(
                                  width: 150.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Image.network(
                                    gridViewPostsRecord.postImage,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment(0.00, 0.00),
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      'assets/images/error_image.png',
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment(0.00, 0.00),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
