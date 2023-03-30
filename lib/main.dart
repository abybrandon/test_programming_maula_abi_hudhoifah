// ignore_for_file: use_key_in_widget_constructors, unused_field, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:test_programming_maula_abi_hudhoifah2/screen/add_data.dart';
import 'package:test_programming_maula_abi_hudhoifah2/screen/detail_data.dart';
import 'package:test_programming_maula_abi_hudhoifah2/theme.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DataSiswa(),
  ));
}

String formatDate(String dateString) {
  initializeDateFormatting('id_ID');
  DateTime dateTime = DateTime.parse(dateString);
  String formattedDate = DateFormat('d MMMM yyyy', 'id_ID').format(dateTime);
  return formattedDate;
}

class DataSiswa extends StatefulWidget {
  @override
  State<DataSiswa> createState() => _DataSiswaState();
}

class _DataSiswaState extends State<DataSiswa> {
  @override
  void initState() {
    fetchSiswa();
    fetchData();
    super.initState();
  }

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://hiringmobile.qtera.co.id/city?province=6392ea3453bd8aa1069ba3b6'));
    final data = jsonDecode(response.body)['data'];
    return data;
  }

  var siswa = Siswa();
  final String _provinsi = '';

  Future<List<Siswa>> fetchSiswa() async {
    var result =
        await http.get(Uri.parse("https://hiringmobile.qtera.co.id/students"));
    List<dynamic> siswaJson = jsonDecode(result.body)['data'];
    return siswaJson.map((json) => siswa.parseSiswa(json)).toList();
  }

  widgetProv() {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var provinsiPertama = snapshot.data[0]['name'];
          return Text("Provinsi   : " + provinsiPertama,
              style: regularTextStyle.copyWith(color: Colors.black));
        } else if (snapshot.hasError) {
          return Text("Error");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey[800],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text(
                "Data Siswa",
                style: TextStyle(fontSize: 32, color: Colors.white),
              ),
              const Icon(Icons.search, size: 32, color: Colors.white)
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        myApiWidget()
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDataPage()),
          );
        },
      ),
    );
  }

  myApiWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: FutureBuilder<List<Siswa>>(
        future: fetchSiswa(),
        builder: (BuildContext context, AsyncSnapshot<List<Siswa>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Siswa siswa = snapshot.data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailData(
                                siswa: snapshot.data[index],
                              )),
                    );
                  },
                  child: Card(
                      elevation: 4,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(siswa.name,
                                      style: regularTextStyle.copyWith(
                                          color: Colors.black, fontSize: 16)),
                                  IconButton(
                                    icon: Icon(Icons.more_vert),
                                    onPressed: () {
                                      showMenu(
                                        context: context,
                                        position: RelativeRect.fromLTRB(
                                            1000.0, 0.0, 0.0, 0.0),
                                        items: [
                                          PopupMenuItem(
                                            child: Text("Edit"),
                                            value: "edit",
                                          ),
                                          PopupMenuItem(
                                            child: Text("Hapus"),
                                            value: "hapus",
                                          ),
                                        ],
                                        elevation: 8.0,
                                      ).then((value) {
                                        if (value == "edit") {
                                          // melakukan aksi edit
                                        } else if (value == "hapus") {
                                          // melakukan aksi hapus
                                        }
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 22,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              "https://raysensenbach.com/wp-content/uploads/2013/04/default.jpg",
                                            ))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Jenis Kelamin        : " +
                                              siswa.gender,
                                          style: regularTextStyle.copyWith(
                                              color: Colors.black),
                                        ),
                                        Text(
                                            "Tanggal Lahir         : " +
                                                formatDate(siswa.birthDate)
                                                    .toString(),
                                            style: regularTextStyle.copyWith(
                                                color: Colors.black)),
                                        widgetProv(),
                                        Column(
                                          children: [],
                                        ),
                                        Text(
                                          "Kota / Kabupaten  : " + siswa.city,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: regularTextStyle.copyWith(
                                              color: Colors.black, fontSize: 8),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Siswa {
  final String id;
  final String name;
  final String gender;
  final String birthDate;
  final String province;
  final String city;
  final String photo;
  final String createdAt;
  final String updatedAt;

  Siswa(
      {this.id,
      this.name,
      this.gender,
      this.birthDate,
      this.province,
      this.city,
      this.photo,
      this.createdAt,
      this.updatedAt});
  Siswa parseSiswa(Map<String, dynamic> json) {
    return Siswa(
      id: json["_id"],
      name: json['name'],
      gender: json['gender'],
      birthDate: json["birthDate"],
      province: json["province"],
      city: json['city'],
      photo: json["photo"],
      createdAt: json["createdAat"],
      updatedAt: json["updatedAt"],
    );
  }
}
