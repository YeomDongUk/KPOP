import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/hof/hof_bloc.dart';
import 'package:kpop/bloc/hof/hof_event.dart';
import 'package:kpop/bloc/hof/hof_state.dart';
import 'package:kpop/widget/artist_list.dart';
import 'package:provider/provider.dart';

class HofMonthlyScreen extends StatefulWidget {
  final String typeCode;

  const HofMonthlyScreen({Key key, this.typeCode}) : super(key: key);
  @override
  _HofMonthlyScreenState createState() => _HofMonthlyScreenState();
}

class _HofMonthlyScreenState extends State<HofMonthlyScreen>
    with AutomaticKeepAliveClientMixin {
  var monthAgo = new DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
      .toString();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    BlocProvider.of<HofBloc>(context).add(
      HofMonthlyLoad(
        genderCode: Provider.of<String>(context, listen: false),
        typeCode: widget.typeCode,
      ),
    );
    return BlocBuilder<HofBloc, HofState>(
      builder: (context, state) {
        if (state is HofSuccess) {
          return ArtistList(
            leading: _buildTerm(),
            artistList: state.artistList,
          );
        }
        return Container();
      },
    );
  }

  Container _buildTerm() {
    return Container(
      height: 40,
      color: Colors.black,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        "${monthAgo.substring(0, 10).replaceAll("-", ".")}. ~ ${DateTime.now().toString().substring(0, 10).replaceAll("-", ".")}.",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
