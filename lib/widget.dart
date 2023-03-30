// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:test_programming_maula_abi_hudhoifah2/theme.dart';

class WidgetDetail extends StatelessWidget {
  String tittle;
  String detail;
  WidgetDetail(this.tittle,this.detail);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(
        bottom: BorderSide(color: Colors.black, width: 1)
      )),
      height: 60,
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 8),
          child: Text(tittle, style: regularTextStyle.copyWith(color: Colors.black, overflow: TextOverflow.ellipsis,)),
        ),
        Text(detail, style: regularTextStyle.copyWith(color: Colors.black))
      ]),
    );
  }
}
