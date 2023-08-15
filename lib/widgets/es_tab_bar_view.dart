import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class EsStringTabBarView extends StatefulWidget{
  final List<String> tabs;
  final List<Widget> views;
  final void Function(int index)? onChanged;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final Color inactiveFillColor;
  final Color activeFillColor;

  const EsStringTabBarView({
    super.key,
    required this.tabs,
    required this.views,
    this.onChanged,
    this.inactiveTextColor = const Color(0xFF626262),
    this.activeTextColor = Colors.white,
    this.inactiveFillColor = const Color(0xFFF2F2F2),
    this.activeFillColor = Colors.blue,
  });

  @override
  State<StatefulWidget> createState() => _EsStringTabBarViewState();
}

class _EsStringTabBarViewState extends State<EsStringTabBarView> with TickerProviderStateMixin{
  late TabController tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: widget.inactiveFillColor
          ),
          child: TabBar(
            controller: tabController,
            onTap: (i){
              setState(() {
                _tabIndex = i;
              });
            },
            indicator: BoxDecoration(
              color: widget.activeFillColor,
              borderRadius: BorderRadius.circular(50),
            ),
            labelColor: Colors.black,
            dividerColor: Colors.black,
            // ignore: prefer_const_literals_to_create_immutables
            tabs: widget.tabs.mapIndexed((i, e) {
              return Tab(
                child: Text(
                  e,
                  style: TextStyle(
                    color: _tabIndex != i ? widget.inactiveTextColor : widget.activeTextColor,
                  )
                ),
              );
            }).toList()
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: widget.views
          ),
        )
      ],
    );
  }

  Widget lazyLoadView(int i){
    return widget.views[i];
  }
}