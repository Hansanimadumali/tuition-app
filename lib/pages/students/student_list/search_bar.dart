import 'package:flutter/material.dart';
import 'package:tution_app/models/student.dart';
import 'package:tution_app/pages/students/common_widgets/student_bottomshet_filter.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isSearching = false;
  String _searchText = "";
  int _searchGrade = -1;
  final TextEditingController _controller = new TextEditingController();
  List<Student> _searchedList = new List();
  List<dynamic> _list;

  _SearchBarState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 0.0),
      child: Container(
        child: Card(
          elevation: 5.0,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                child: TextField(
                  onChanged: _searchOperation,
                  decoration: InputDecoration(
                      hintText: "Search Students",
                      contentPadding:
                          const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.tune),
                        onPressed: () {
                          _filterModalBottomSheet(context);
                        },
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _searchOperation(String searchText) {
    if (_isSearching != null || _isSearching == false) {
      _searchedList.clear();
      _handleStartSearch();
      for (int i = 0; i < _list.length; i++) {
        Student data = _list[i];
        String text = data.toString();
        bool _isSubstring = false;
        bool _isMatchGrade = false;
        if (text.toLowerCase().contains(searchText.toLowerCase())) {
          _isSubstring = true;
        }

        if (_searchGrade == -1) {
          _isMatchGrade = true;
        } else if (_searchGrade == data.grade) {
          _isMatchGrade = true;
        }

        if (_isMatchGrade && _isSubstring) {
          _searchedList.add(data);
        }
      }
      _handleSearchEnd();
    }
  }

  void _handleStartSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      _isSearching = false;
      _controller.clear();
    });
  }

  void _filterModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return StudentBottomSheetFilter(
            setParentState: _filterHandler,
            grade: _searchGrade,
          );
        });
  }

  void _filterHandler(int value) {
    if (value != this._searchGrade) {
      setState(() {
        this._searchGrade = value;
        _searchOperation(_searchText);
      });
    }
  }
}
