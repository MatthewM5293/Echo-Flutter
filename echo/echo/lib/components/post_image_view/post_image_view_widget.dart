import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'post_image_view_model.dart';
export 'post_image_view_model.dart';

class PostImageViewWidget extends StatefulWidget {
  const PostImageViewWidget({
    Key? key,
    required this.postImage,
  }) : super(key: key);

  final String? postImage;

  @override
  _PostImageViewWidgetState createState() => _PostImageViewWidgetState();
}

class _PostImageViewWidgetState extends State<PostImageViewWidget> {
  late PostImageViewModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PostImageViewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                widget.postImage!,
                width: double.infinity,
                fit: BoxFit.scaleDown,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
