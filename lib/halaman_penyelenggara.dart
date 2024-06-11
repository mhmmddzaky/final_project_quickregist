import 'package:final_project_quickregist/LombaModel.dart';
import 'package:final_project_quickregist/riwayat_lomba_page.dart';
import 'package:final_project_quickregist/tambah_lomba_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penyelenggara Lomba',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PagePenyelenggara(),
    );
  }
}

class PagePenyelenggara extends StatefulWidget {
  @override
  _PagePenyelenggaraState createState() => _PagePenyelenggaraState();
}

class _PagePenyelenggaraState extends State<PagePenyelenggara> {
  int _selectedIndex = 0;
  List<Lomba> _lombaList = [];

  void _addLomba(Lomba lomba) {
    setState(() {
      _lombaList.add(lomba);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      RiwayatLombaPage(lombaList: _lombaList),
      TambahLombaPage(addLomba: _addLomba),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Penyelenggara Lomba'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat Lomba',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tambah Lomba',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
