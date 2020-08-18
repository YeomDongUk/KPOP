import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kpop/bloc/hof/hof_bloc.dart';
import 'package:kpop/bloc/hof/hof_event.dart';
import 'package:kpop/bloc/hof/hof_state.dart';
import 'package:kpop/static/color.dart';
import 'package:kpop/widget/artist_list.dart';
import 'package:kpop/widget/custom_fab.dart';
import 'package:provider/provider.dart';

class HofDailyScreen extends StatefulWidget {
  final String typeCode;

  const HofDailyScreen({Key key, this.typeCode}) : super(key: key);
  @override
  _HofDailyScreenState createState() => _HofDailyScreenState();
}

class _HofDailyScreenState extends State<HofDailyScreen>
    with AutomaticKeepAliveClientMixin {
  int type = 0;
  int month = 0;
  void choiceSortType(int index) {
    if (index != type) setState(() => type = index);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    BlocProvider.of<HofBloc>(context).add(
      HofDailyLoad(
        genderCode: Provider.of<String>(context, listen: false),
        typeCode: widget.typeCode,
        month: month,
        orderByCode: type == 0 ? "DATE" : "VOTE",
      ),
    );
    return Scaffold(
      body: BlocBuilder<HofBloc, HofState>(
        builder: (context, state) {
          if (state is HofSuccess) {
            return ArtistList(
              leading: _buildLeading(),
              artistList: state.artistList,
              isDaily: true,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: CustomFab(
        typeCode: widget.typeCode,
        onPressed: (int month) {
          this.month = month;
          BlocProvider.of<HofBloc>(context).add(
            HofDailyLoad(
              genderCode: Provider.of<String>(context, listen: false),
              typeCode: widget.typeCode,
              month: month,
              orderByCode: type == 0 ? "DATE" : "VOTE",
            ),
          );
        },
      ),
    );
  }

  Container _buildLeading() {
    return Container(
      height: 40,
      color: Colors.black,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildSelector(0),
          Image.asset(
            "assets/icon/icon_time_normal.png",
            scale: 2.2,
          ),
          SizedBox(width: 10),
          _buildSelector(1),
          Image.asset(
            "assets/icon/icon_star_36x36_normal.png",
            scale: 1.2,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  GestureDetector _buildSelector(int index) {
    return GestureDetector(
      onTap: () => choiceSortType(index),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: type == index ? CustomColor.main : Colors.white,
        ),
        width: 16,
        padding: EdgeInsets.all(1),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: type == index ? CustomColor.main : Colors.white,
            border: Border.all(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
