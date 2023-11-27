import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/comments_view2/comments_view2_widget.dart';
import '/components/empty_feed/empty_feed_widget.dart';
import '/components/post_options/post_options_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          iconTheme:
              IconThemeData(color: FlutterFlowTheme.of(context).primaryText),
          automaticallyImplyLeading: true,
          title: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                Theme.of(context).brightness == Brightness.dark
                    ? 'assets/images/echo-high-resolution-logo-white-transparent.png'
                    : 'assets/images/echo-high-resolution-logo-black-transparent_(1).png',
                width: MediaQuery.sizeOf(context).width * 0.3,
                fit: BoxFit.scaleDown,
                alignment: Alignment(0.00, 0.00),
              ),
            ),
          ),
          actions: [
            Align(
              alignment: AlignmentDirectional(0.00, -1.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 16.0, 0.0),
                child: FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).alternate,
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                  icon: Icon(
                    Icons.logout_sharp,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    GoRouter.of(context).prepareAuthEvent();
                    await authManager.signOut();
                    GoRouter.of(context).clearRedirectLocation();

                    context.goNamedAuth('SplashScreen', context.mounted);
                  },
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                PageView(
                  controller: _model.pageViewController ??=
                      PageController(initialPage: 0),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(),
                          child: PagedListView<DocumentSnapshot<Object?>?,
                              PostsRecord>(
                            pagingController: _model.setListViewController1(
                              PostsRecord.collection.orderBy('post_date'),
                            ),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            reverse: false,
                            scrollDirection: Axis.vertical,
                            builderDelegate:
                                PagedChildBuilderDelegate<PostsRecord>(
                              // Customize what your widget looks like when it's loading the first page.
                              firstPageProgressIndicatorBuilder: (_) => Center(
                                child: SizedBox(
                                  width: 35.0,
                                  height: 35.0,
                                  child: SpinKitWave(
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 35.0,
                                  ),
                                ),
                              ),
                              // Customize what your widget looks like when it's loading another page.
                              newPageProgressIndicatorBuilder: (_) => Center(
                                child: SizedBox(
                                  width: 35.0,
                                  height: 35.0,
                                  child: SpinKitWave(
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 35.0,
                                  ),
                                ),
                              ),
                              noItemsFoundIndicatorBuilder: (_) =>
                                  EmptyFeedWidget(),
                              itemBuilder: (context, _, listViewIndex) {
                                final listViewPostsRecord = _model
                                    .listViewPagingController1!
                                    .itemList![listViewIndex];
                                return Visibility(
                                  visible: functions.timeCheck(
                                          listViewPostsRecord.postDate!) ==
                                      true,
                                  child: FutureBuilder<UsersRecord>(
                                    future: UsersRecord.getDocumentOnce(
                                        listViewPostsRecord.postOwner!),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 35.0,
                                            height: 35.0,
                                            child: SpinKitWave(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              size: 35.0,
                                            ),
                                          ),
                                        );
                                      }
                                      final columnUsersRecord = snapshot.data!;
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
                                                listViewPostsRecord,
                                                ParamType.Document,
                                              ),
                                            }.withoutNulls,
                                            extra: <String, dynamic>{
                                              'post': listViewPostsRecord,
                                            },
                                          );
                                        },
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.pushNamed(
                                                    'ProfileView',
                                                    queryParameters: {
                                                      'userToView':
                                                          serializeParam(
                                                        columnUsersRecord
                                                            .reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.00, -1.00),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    16.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.00, 0.00),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                context
                                                                    .pushNamed(
                                                                  'ProfileView',
                                                                  queryParameters:
                                                                      {
                                                                    'userToView':
                                                                        serializeParam(
                                                                      listViewPostsRecord
                                                                          .postOwner,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                  extra: <String,
                                                                      dynamic>{
                                                                    kTransitionInfoKey:
                                                                        TransitionInfo(
                                                                      hasTransition:
                                                                          true,
                                                                      transitionType:
                                                                          PageTransitionType
                                                                              .fade,
                                                                    ),
                                                                  },
                                                                );
                                                              },
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                                child: Image
                                                                    .network(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    columnUsersRecord
                                                                        .photoUrl,
                                                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu7nstGbtSpaQqfHE4D8bNX80xqTA0gcqegvN-E8LG&s',
                                                                  ),
                                                                  width: 35.0,
                                                                  height: 35.0,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                'ProfileView',
                                                                queryParameters:
                                                                    {
                                                                  'userToView':
                                                                      serializeParam(
                                                                    listViewPostsRecord
                                                                        .postOwner,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                                extra: <String,
                                                                    dynamic>{
                                                                  kTransitionInfoKey:
                                                                      TransitionInfo(
                                                                    hasTransition:
                                                                        true,
                                                                    transitionType:
                                                                        PageTransitionType
                                                                            .fade,
                                                                  ),
                                                                },
                                                              );
                                                            },
                                                            child: Text(
                                                              columnUsersRecord
                                                                  .displayName,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'VT323',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                'ProfileView',
                                                                queryParameters:
                                                                    {
                                                                  'userToView':
                                                                      serializeParam(
                                                                    listViewPostsRecord
                                                                        .postOwner,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                                extra: <String,
                                                                    dynamic>{
                                                                  kTransitionInfoKey:
                                                                      TransitionInfo(
                                                                    hasTransition:
                                                                        true,
                                                                    transitionType:
                                                                        PageTransitionType
                                                                            .fade,
                                                                  ),
                                                                },
                                                              );
                                                            },
                                                            child: Text(
                                                              columnUsersRecord
                                                                  .userName,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodySmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'VT323',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.00, 0.00),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    6.0,
                                                                    0.0,
                                                                    6.0,
                                                                    10.0),
                                                        child: AutoSizeText(
                                                          dateTimeFormat(
                                                            'relative',
                                                            listViewPostsRecord
                                                                .postDate!,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'VT323',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.00, 0.00),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    8.0),
                                                        child:
                                                            FlutterFlowIconButton(
                                                          borderColor:
                                                              Color(0x00359F8A),
                                                          borderRadius: 20.0,
                                                          borderWidth: 1.0,
                                                          buttonSize: 46.0,
                                                          fillColor:
                                                              Color(0x0004A24C),
                                                          icon: Icon(
                                                            Icons
                                                                .keyboard_control,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          ),
                                                          onPressed: () async {
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              enableDrag: false,
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return GestureDetector(
                                                                  onTap: () => _model
                                                                          .unfocusNode
                                                                          .canRequestFocus
                                                                      ? FocusScope.of(
                                                                              context)
                                                                          .requestFocus(_model
                                                                              .unfocusNode)
                                                                      : FocusScope.of(
                                                                              context)
                                                                          .unfocus(),
                                                                  child:
                                                                      Padding(
                                                                    padding: MediaQuery
                                                                        .viewInsetsOf(
                                                                            context),
                                                                    child:
                                                                        PostOptionsWidget(
                                                                      postViewing:
                                                                          listViewPostsRecord
                                                                              .reference,
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        40.0, 0.0, 16.0, 8.0),
                                                child: Text(
                                                  listViewPostsRecord
                                                      .postCaption,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'VT323',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        40.0, 0.0, 16.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 200.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              FlutterFlowExpandedImageView(
                                                            image:
                                                                Image.network(
                                                              valueOrDefault<
                                                                  String>(
                                                                listViewPostsRecord
                                                                    .postImage,
                                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu7nstGbtSpaQqfHE4D8bNX80xqTA0gcqegvN-E8LG&s',
                                                              ),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                            allowRotation:
                                                                false,
                                                            tag: valueOrDefault<
                                                                String>(
                                                              listViewPostsRecord
                                                                  .postImage,
                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu7nstGbtSpaQqfHE4D8bNX80xqTA0gcqegvN-E8LG&s' +
                                                                  '$listViewIndex',
                                                            ),
                                                            useHeroAnimation:
                                                                true,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Hero(
                                                      tag: valueOrDefault<
                                                          String>(
                                                        listViewPostsRecord
                                                            .postImage,
                                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu7nstGbtSpaQqfHE4D8bNX80xqTA0gcqegvN-E8LG&s' +
                                                            '$listViewIndex',
                                                      ),
                                                      transitionOnUserGestures:
                                                          true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0.0),
                                                        child: Image.network(
                                                          valueOrDefault<
                                                              String>(
                                                            listViewPostsRecord
                                                                .postImage,
                                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu7nstGbtSpaQqfHE4D8bNX80xqTA0gcqegvN-E8LG&s',
                                                          ),
                                                          height:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        32.0, 0.0, 16.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    ToggleIcon(
                                                      onPressed: () async {
                                                        final postLikedbyElement =
                                                            currentUserReference;
                                                        final postLikedbyUpdate =
                                                            listViewPostsRecord
                                                                    .postLikedby
                                                                    .contains(
                                                                        postLikedbyElement)
                                                                ? FieldValue
                                                                    .arrayRemove([
                                                                    postLikedbyElement
                                                                  ])
                                                                : FieldValue
                                                                    .arrayUnion([
                                                                    postLikedbyElement
                                                                  ]);
                                                        await listViewPostsRecord
                                                            .reference
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'post_likedby':
                                                                  postLikedbyUpdate,
                                                            },
                                                          ),
                                                        });
                                                      },
                                                      value: listViewPostsRecord
                                                          .postLikedby
                                                          .contains(
                                                              currentUserReference),
                                                      onIcon: Icon(
                                                        Icons.favorite,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        size: 25.0,
                                                      ),
                                                      offIcon: Icon(
                                                        Icons.favorite_border,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 25.0,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${valueOrDefault<String>(
                                                        formatNumber(
                                                          listViewPostsRecord
                                                              .postLikedby
                                                              .length,
                                                          formatType: FormatType
                                                              .compact,
                                                        ),
                                                        '0',
                                                      )} likes',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 30.0,
                                                      buttonSize: 40.0,
                                                      icon: Icon(
                                                        Icons
                                                            .chat_bubble_outline,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24.0,
                                                      ),
                                                      onPressed: () async {
                                                        await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          enableDrag: false,
                                                          context: context,
                                                          builder: (context) {
                                                            return GestureDetector(
                                                              onTap: () => _model
                                                                      .unfocusNode
                                                                      .canRequestFocus
                                                                  ? FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          _model
                                                                              .unfocusNode)
                                                                  : FocusScope.of(
                                                                          context)
                                                                      .unfocus(),
                                                              child: Padding(
                                                                padding: MediaQuery
                                                                    .viewInsetsOf(
                                                                        context),
                                                                child:
                                                                    CommentsView2Widget(
                                                                  postCommentsToView:
                                                                      listViewPostsRecord
                                                                          .reference,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));
                                                      },
                                                    ),
                                                    StreamBuilder<
                                                        List<CommentsRecord>>(
                                                      stream:
                                                          queryCommentsRecord(
                                                        queryBuilder:
                                                            (commentsRecord) =>
                                                                commentsRecord
                                                                    .where(
                                                          'comment_post',
                                                          isEqualTo:
                                                              listViewPostsRecord
                                                                  .reference,
                                                        ),
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 35.0,
                                                              height: 35.0,
                                                              child:
                                                                  SpinKitWave(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                size: 35.0,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        List<CommentsRecord>
                                                            textCommentsRecordList =
                                                            snapshot.data!;
                                                        return Text(
                                                          '${formatNumber(
                                                            textCommentsRecordList
                                                                .length,
                                                            formatType:
                                                                FormatType
                                                                    .compact,
                                                          )} Comments',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium,
                                                        );
                                                      },
                                                    ),
                                                    FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 30.0,
                                                      buttonSize: 40.0,
                                                      icon: FaIcon(
                                                        FontAwesomeIcons.share,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 24.0,
                                                      ),
                                                      onPressed: () {
                                                        print(
                                                            'IconButton pressed ...');
                                                      },
                                                    ),
                                                    Text(
                                                      'Share',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 1.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(),
                          child: AuthUserStreamWidget(
                            builder: (context) => PagedListView<
                                DocumentSnapshot<Object?>?, PostsRecord>(
                              pagingController: _model.setListViewController2(
                                PostsRecord.collection
                                    .whereIn(
                                        'post_owner',
                                        (currentUserDocument?.following
                                                ?.toList() ??
                                            []))
                                    .orderBy('post_date'),
                              ),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              reverse: false,
                              scrollDirection: Axis.vertical,
                              builderDelegate:
                                  PagedChildBuilderDelegate<PostsRecord>(
                                // Customize what your widget looks like when it's loading the first page.
                                firstPageProgressIndicatorBuilder: (_) =>
                                    Center(
                                  child: SizedBox(
                                    width: 35.0,
                                    height: 35.0,
                                    child: SpinKitWave(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 35.0,
                                    ),
                                  ),
                                ),
                                // Customize what your widget looks like when it's loading another page.
                                newPageProgressIndicatorBuilder: (_) => Center(
                                  child: SizedBox(
                                    width: 35.0,
                                    height: 35.0,
                                    child: SpinKitWave(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 35.0,
                                    ),
                                  ),
                                ),
                                noItemsFoundIndicatorBuilder: (_) =>
                                    EmptyFeedWidget(),
                                itemBuilder: (context, _, listViewIndex) {
                                  final listViewPostsRecord = _model
                                      .listViewPagingController2!
                                      .itemList![listViewIndex];
                                  return Visibility(
                                    visible: functions.timeCheck(
                                            listViewPostsRecord.postDate!) ==
                                        true,
                                    child: FutureBuilder<UsersRecord>(
                                      future: UsersRecord.getDocumentOnce(
                                          listViewPostsRecord.postOwner!),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 35.0,
                                              height: 35.0,
                                              child: SpinKitWave(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 35.0,
                                              ),
                                            ),
                                          );
                                        }
                                        final columnUsersRecord =
                                            snapshot.data!;
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
                                                  listViewPostsRecord,
                                                  ParamType.Document,
                                                ),
                                              }.withoutNulls,
                                              extra: <String, dynamic>{
                                                'post': listViewPostsRecord,
                                              },
                                            );
                                          },
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    context.pushNamed(
                                                      'ProfileView',
                                                      queryParameters: {
                                                        'userToView':
                                                            serializeParam(
                                                          columnUsersRecord
                                                              .reference,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.00, -1.00),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      16.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.00,
                                                                      0.00),
                                                              child: InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  context
                                                                      .pushNamed(
                                                                    'ProfileView',
                                                                    queryParameters:
                                                                        {
                                                                      'userToView':
                                                                          serializeParam(
                                                                        listViewPostsRecord
                                                                            .postOwner,
                                                                        ParamType
                                                                            .DocumentReference,
                                                                      ),
                                                                    }.withoutNulls,
                                                                    extra: <String,
                                                                        dynamic>{
                                                                      kTransitionInfoKey:
                                                                          TransitionInfo(
                                                                        hasTransition:
                                                                            true,
                                                                        transitionType:
                                                                            PageTransitionType.fade,
                                                                      ),
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                  child: Image
                                                                      .network(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      columnUsersRecord
                                                                          .photoUrl,
                                                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu7nstGbtSpaQqfHE4D8bNX80xqTA0gcqegvN-E8LG&s',
                                                                    ),
                                                                    width: 35.0,
                                                                    height:
                                                                        35.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                context
                                                                    .pushNamed(
                                                                  'ProfileView',
                                                                  queryParameters:
                                                                      {
                                                                    'userToView':
                                                                        serializeParam(
                                                                      listViewPostsRecord
                                                                          .postOwner,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                  extra: <String,
                                                                      dynamic>{
                                                                    kTransitionInfoKey:
                                                                        TransitionInfo(
                                                                      hasTransition:
                                                                          true,
                                                                      transitionType:
                                                                          PageTransitionType
                                                                              .fade,
                                                                    ),
                                                                  },
                                                                );
                                                              },
                                                              child: Text(
                                                                columnUsersRecord
                                                                    .displayName,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .headlineSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'VT323',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        4.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                context
                                                                    .pushNamed(
                                                                  'ProfileView',
                                                                  queryParameters:
                                                                      {
                                                                    'userToView':
                                                                        serializeParam(
                                                                      listViewPostsRecord
                                                                          .postOwner,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                  extra: <String,
                                                                      dynamic>{
                                                                    kTransitionInfoKey:
                                                                        TransitionInfo(
                                                                      hasTransition:
                                                                          true,
                                                                      transitionType:
                                                                          PageTransitionType
                                                                              .fade,
                                                                    ),
                                                                  },
                                                                );
                                                              },
                                                              child: Text(
                                                                columnUsersRecord
                                                                    .userName,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'VT323',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.00, 0.00),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      6.0,
                                                                      0.0,
                                                                      6.0,
                                                                      10.0),
                                                          child: AutoSizeText(
                                                            dateTimeFormat(
                                                              'relative',
                                                              listViewPostsRecord
                                                                  .postDate!,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'VT323',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.00, 0.00),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      8.0),
                                                          child:
                                                              FlutterFlowIconButton(
                                                            borderColor: Color(
                                                                0x00359F8A),
                                                            borderRadius: 20.0,
                                                            borderWidth: 1.0,
                                                            buttonSize: 46.0,
                                                            fillColor: Color(
                                                                0x0004A24C),
                                                            icon: Icon(
                                                              Icons
                                                                  .keyboard_control,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 24.0,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                enableDrag:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () => _model
                                                                            .unfocusNode
                                                                            .canRequestFocus
                                                                        ? FocusScope.of(context).requestFocus(_model
                                                                            .unfocusNode)
                                                                        : FocusScope.of(context)
                                                                            .unfocus(),
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          PostOptionsWidget(
                                                                        postViewing:
                                                                            listViewPostsRecord.reference,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          40.0, 0.0, 16.0, 8.0),
                                                  child: Text(
                                                    listViewPostsRecord
                                                        .postCaption,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'VT323',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          40.0, 0.0, 16.0, 0.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 200.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await Navigator.push(
                                                          context,
                                                          PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .fade,
                                                            child:
                                                                FlutterFlowExpandedImageView(
                                                              image:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  listViewPostsRecord
                                                                      .postImage,
                                                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu7nstGbtSpaQqfHE4D8bNX80xqTA0gcqegvN-E8LG&s',
                                                                ),
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                              allowRotation:
                                                                  false,
                                                              tag:
                                                                  valueOrDefault<
                                                                      String>(
                                                                listViewPostsRecord
                                                                    .postImage,
                                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu7nstGbtSpaQqfHE4D8bNX80xqTA0gcqegvN-E8LG&s' +
                                                                    '$listViewIndex',
                                                              ),
                                                              useHeroAnimation:
                                                                  true,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Hero(
                                                        tag: valueOrDefault<
                                                            String>(
                                                          listViewPostsRecord
                                                              .postImage,
                                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu7nstGbtSpaQqfHE4D8bNX80xqTA0gcqegvN-E8LG&s' +
                                                              '$listViewIndex',
                                                        ),
                                                        transitionOnUserGestures:
                                                            true,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      0.0),
                                                          child: Image.network(
                                                            valueOrDefault<
                                                                String>(
                                                              listViewPostsRecord
                                                                  .postImage,
                                                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu7nstGbtSpaQqfHE4D8bNX80xqTA0gcqegvN-E8LG&s',
                                                            ),
                                                            height:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          32.0, 0.0, 16.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ToggleIcon(
                                                        onPressed: () async {
                                                          final postLikedbyElement =
                                                              currentUserReference;
                                                          final postLikedbyUpdate =
                                                              listViewPostsRecord
                                                                      .postLikedby
                                                                      .contains(
                                                                          postLikedbyElement)
                                                                  ? FieldValue
                                                                      .arrayRemove([
                                                                      postLikedbyElement
                                                                    ])
                                                                  : FieldValue
                                                                      .arrayUnion([
                                                                      postLikedbyElement
                                                                    ]);
                                                          await listViewPostsRecord
                                                              .reference
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'post_likedby':
                                                                    postLikedbyUpdate,
                                                              },
                                                            ),
                                                          });
                                                        },
                                                        value: listViewPostsRecord
                                                            .postLikedby
                                                            .contains(
                                                                currentUserReference),
                                                        onIcon: Icon(
                                                          Icons.favorite,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                          size: 25.0,
                                                        ),
                                                        offIcon: Icon(
                                                          Icons.favorite_border,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 25.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${valueOrDefault<String>(
                                                          formatNumber(
                                                            listViewPostsRecord
                                                                .postLikedby
                                                                .length,
                                                            formatType:
                                                                FormatType
                                                                    .compact,
                                                          ),
                                                          '0',
                                                        )} likes',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                      FlutterFlowIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 30.0,
                                                        buttonSize: 40.0,
                                                        icon: Icon(
                                                          Icons
                                                              .chat_bubble_outline,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                        onPressed: () async {
                                                          await showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            enableDrag: false,
                                                            context: context,
                                                            builder: (context) {
                                                              return GestureDetector(
                                                                onTap: () => _model
                                                                        .unfocusNode
                                                                        .canRequestFocus
                                                                    ? FocusScope.of(
                                                                            context)
                                                                        .requestFocus(_model
                                                                            .unfocusNode)
                                                                    : FocusScope.of(
                                                                            context)
                                                                        .unfocus(),
                                                                child: Padding(
                                                                  padding: MediaQuery
                                                                      .viewInsetsOf(
                                                                          context),
                                                                  child:
                                                                      CommentsView2Widget(
                                                                    postCommentsToView:
                                                                        listViewPostsRecord
                                                                            .reference,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          ).then((value) =>
                                                              safeSetState(
                                                                  () {}));
                                                        },
                                                      ),
                                                      FutureBuilder<
                                                          List<CommentsRecord>>(
                                                        future: FFAppState()
                                                            .commentCount(
                                                          requestFn: () =>
                                                              queryCommentsRecordOnce(
                                                            queryBuilder:
                                                                (commentsRecord) =>
                                                                    commentsRecord
                                                                        .where(
                                                              'comment_post',
                                                              isEqualTo:
                                                                  listViewPostsRecord
                                                                      .reference,
                                                            ),
                                                          ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 35.0,
                                                                height: 35.0,
                                                                child:
                                                                    SpinKitWave(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                  size: 35.0,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<CommentsRecord>
                                                              textCommentsRecordList =
                                                              snapshot.data!;
                                                          return Text(
                                                            '${formatNumber(
                                                              textCommentsRecordList
                                                                  .length,
                                                              formatType:
                                                                  FormatType
                                                                      .compact,
                                                            )} Comments',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium,
                                                          );
                                                        },
                                                      ),
                                                      FlutterFlowIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 30.0,
                                                        buttonSize: 40.0,
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .share,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24.0,
                                                        ),
                                                        onPressed: () {
                                                          print(
                                                              'IconButton pressed ...');
                                                        },
                                                      ),
                                                      Text(
                                                        'Share',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 16.0, 0.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 1.0,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, -1.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
                    child: smooth_page_indicator.SmoothPageIndicator(
                      controller: _model.pageViewController ??=
                          PageController(initialPage: 0),
                      count: 2,
                      axisDirection: Axis.horizontal,
                      onDotClicked: (i) async {
                        await _model.pageViewController!.animateToPage(
                          i,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                      effect: smooth_page_indicator.ExpandingDotsEffect(
                        expansionFactor: 4.0,
                        spacing: 8.0,
                        radius: 16.0,
                        dotWidth: 16.0,
                        dotHeight: 10.0,
                        dotColor: FlutterFlowTheme.of(context).primaryText,
                        activeDotColor: FlutterFlowTheme.of(context).secondary,
                        paintStyle: PaintingStyle.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
