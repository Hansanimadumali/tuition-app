import 'package:flutter/material.dart';
import 'package:tution_app/models/tution_class.dart';
import 'package:tution_app/pages/classes/custom_widgets/tutuion_class_bottomsheet_filter.dart';
import 'package:tution_app/pages/payments/payment_profile.dart';

class PaymentClassList extends StatefulWidget {
  @override
  _PaymentClassListState createState() => _PaymentClassListState();
}

class _PaymentClassListState extends State<PaymentClassList> {
  List<TutionClass> _list;
  List<TutionClass> _searchedList = new List();
  String _searchText = "";
  bool _isSearching = false;
  String _searchSubject = "";
  String _searchTeacher = "";
  String _searchInstitute = "";
  int _searchGrade = -1;
  final TextEditingController _controller = new TextEditingController();

  _PaymentClassListState() {
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

  void _searchOperation(String searchText) {
    if (_isSearching != null || _isSearching == false) {
      _searchedList.clear();
      _handleStartSearch();
      bool _isSubstring;
      bool _isMatchGrade;
      bool _isInstituteMatch;
      bool _isTeacherMatch;
      bool _isSubjectMatch;
      for (int i = 0; i < _list.length; i++) {
        TutionClass data = _list[i];
        _isSubstring = false;
        _isMatchGrade = false;
        _isInstituteMatch = false;
        _isTeacherMatch = false;
        _isSubjectMatch = false;

        String text = data.toString();
        if (text.toLowerCase().contains(searchText.toLowerCase())) {
          _isSubstring = true;
        }

        if (_searchGrade == -1) {
          _isMatchGrade = true;
        } else if (_searchGrade == data.grade) {
          _isMatchGrade = true;
        }

        if (_searchInstitute == "" || _searchInstitute == data.institute) {
          _isInstituteMatch = true;
        }

        if (_searchSubject == "" || _searchSubject == data.subject) {
          _isSubjectMatch = true;
        }

        if (_searchTeacher == "" || _searchTeacher == data.teacher) {
          _isTeacherMatch = true;
        }

        if (_isMatchGrade &&
            _isSubstring &&
            _isInstituteMatch &&
            _isTeacherMatch &&
            _isSubjectMatch) {
          _searchedList.add(data);
        }
      }
      _handleSearchEnd();
    }
  }

  bool _shouldFilter() {
    if (_searchedList.length != 0 ||
        _searchGrade != -1 ||
        _searchInstitute != "" ||
        _searchSubject != "" ||
        _searchTeacher != "") {
      return true;
    }
    return false;
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        child: Column(
          children: <Widget>[
            _createSearchBar(context),
            _createClassList(context)
          ],
        ),
      ),
    );
  }

  Expanded _createClassList(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 7.0, right: 7.0, top: 0.0),
      child: Container(
          child: _shouldFilter()
              ? new ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0.0),
                  itemCount: _searchedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    TutionClass tutionClass = _searchedList[index];
                    return _createClassListTile(context, tutionClass);
                  },
                )
              : new ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0.0),
                  itemCount: _list.length,
                  itemBuilder: (BuildContext context, int index) {
                    TutionClass tutionClass = _list[index];
                    return _createClassListTile(context, tutionClass);
                  },
                )),
    ));
  }

  Card _createClassListTile(BuildContext context, TutionClass tutionClass) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PaymentProfile()));
          },
          behavior: HitTestBehavior.translucent,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              _mainListTileContent(tutionClass),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  margin: const EdgeInsets.only(left: 220.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "26000",
                        style: TextStyle(color: Colors.green),
                      ),
                      Text("/this month",style: TextStyle(fontSize: 10.0),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _mainListTileContent(TutionClass tutionClass) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          child: Text(
                            tutionClass.className,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        height: 30.0,
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 4.0),
                                child: Container(
                                    child: Text(
                                  tutionClass.subject.name,
                                  style: TextStyle(fontSize: 11.0),
                                )),
                              ),
                              Container(
                                height: 28.0,
                                width: 28.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.0),
                                    color: _getMediumColor(tutionClass)),
                                child: Center(
                                  child: Text(
                                    tutionClass.medium.toUpperCase()[0],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11.0),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xffececec),
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ],
                  )),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Grade " + tutionClass.grade.toString(),
                          style: TextStyle(color: Color(0xff385170)),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text("|"),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(tutionClass.institute.name)
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      "By " + tutionClass.teacher.name,
                      style: TextStyle(color: Color(0xff9fd3c7)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getMediumColor(TutionClass tutionClass) {
    if (tutionClass.medium.toLowerCase() == "sinhala") {
      return Color(0xff385170);
    } else if (tutionClass.medium.toLowerCase() == "english") {
      return Color(0xff9fd3c7);
    } else {
      return Colors.red;
    }
  }

  Widget _createSearchBar(BuildContext context) {
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
                      hintText: "Search Classes",
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

  void _filterModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return TutionClassBottomsheetFilter();
        });
  }
}
