// ignore_for_file: unnecessary_const, unused_field, prefer_const_declarations, prefer_const_constructors, unused_element, prefer_if_null_operators

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_programming_maula_abi_hudhoifah2/theme.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({Key key}) : super(key: key);

  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _photoController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  Future<void> _submitData() async {
    final String apiUrl =
        'https://6424f3887ac292e3cff480d8.mockapi.io/example/api/data';

    final Map<String, dynamic> data = {
      'tittle': _usernameController.text,
      'content': _genderController.text,
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    // Menampilkan pesan jika request berhasil atau gagal
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('Data berhasil ditambahkan'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Gagal'),
          content: const Text('Terjadi kesalahan saat menambahkan data'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  DateTime _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthDateController.text = DateFormat.yMMMd().format(_selectedDate);
      });
    }
  }

  File _pickedImage;

  Future<void> _pickImageFromGallery() async {
    final pickedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedImage == null) {
      return;
    }

    final pickedImageFile = File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: const Text('Tambah Data'),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Nama Lengkap",
                                style: regularTextStyle,
                              ),
                            ),
                            TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                labelText: 'Nama ',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nama  tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Tanggal Lahir",
                                style: regularTextStyle,
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                hintText: 'Masukkan tanggal lahir',
                                suffixIcon: GestureDetector(
                                  onTap: () async {
                                    DateTime selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );

                                    if (selectedDate != null) {
                                      _birthDateController.text =
                                          DateFormat('dd/MM/yyyy')
                                              .format(selectedDate);
                                    }
                                  },
                                  child: Icon(Icons.calendar_today),
                                ),
                              ),
                              controller: _birthDateController,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Jenis Kelamin",
                                style: regularTextStyle,
                              ),
                            ),
                            TextFormField(
                              controller: _genderController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                labelText: 'Jenis Kelamin ',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Gender tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Provinsi",
                                style: regularTextStyle,
                              ),
                            ),
                            TextFormField(
                              controller: _provinceController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                labelText: 'Pilih ',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Provinsi tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Kota / Kabupaten",
                                style: regularTextStyle,
                              ),
                            ),
                            TextFormField(
                              controller: _cityController,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                labelText: 'Kota / Kabupaten',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Kota / Kabupaten tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Pilih Foto",
                                style: regularTextStyle,
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      BorderSide(width: 1, color: Colors.black),
                                ),
                                suffixIcon: GestureDetector(
                                    onTap: _pickImageFromGallery,
                                    child: Icon(
                                      Icons.add_a_photo,
                                    )),
                                labelText: 'Upload',
                              ),
                            ),
                          ],
                        ),
                      
                      
                        _pickedImage != null
                            ? Image.file(_pickedImage)
                            : Text('Belum ada gambar yang dipilih.'),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.greenAccent),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _submitData();
                            }
                          },
                          child: Text('Tambah Data',
                              style: regularTextStyle.copyWith(
                                  color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel',
                              style: regularTextStyle.copyWith(
                                  color: Colors.white)),
                        ),
                      ],
                    )))));
  }
}
