// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_programming_maula_abi_hudhoifah2/widget.dart';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';

class DetailData extends StatefulWidget {
  final dynamic siswa;

  const DetailData({Key key, this.siswa}) : super(key: key);

  @override
  State<DetailData> createState() => _DetailDataState();
}

class _DetailDataState extends State<DetailData> {
  String formatDate(String dateString) {
    initializeDateFormatting('id_ID');
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        backgroundColor: Colors.grey[800],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    border: const Border(
                        left: BorderSide(color: Colors.black, width: 1),
                        right: BorderSide(color: Colors.black, width: 1),
                        top: BorderSide(color: Colors.black, width: 1),
                        bottom: BorderSide(color: Colors.black, width: 1)),
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://www.truckeradvisor.com/media/uploads/profilePics/notFound.jpg"))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    WidgetDetail("Nama Lengkap", widget.siswa.name),
                    WidgetDetail("Provinsi ", widget.siswa.province),
                  ],
                ),
                Row(
                  children: [
                    WidgetDetail("Jenis Kelamin", widget.siswa.gender),
                    WidgetDetail("Kota/Kabupaten ", widget.siswa.city),
                  ],
                ),
                WidgetDetail("Tanggal Lahir",
                    formatDate(widget.siswa.birthDate.toString()))
              ],
            ),
          )
        ],
      ),
    );
  }
}
