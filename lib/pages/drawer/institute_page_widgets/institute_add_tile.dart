import 'package:flutter/material.dart';
import 'package:tution_app/models/institute.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tution_app/state_mangement/drawer/institute_page/institute_page_sm.dart';

class InstituteAddTile extends StatefulWidget {
  final Institute institute;

  InstituteAddTile({Key key,this.institute}):super(key:key);
  @override
  _InstituteAddTileState createState() => _InstituteAddTileState();
}

class _InstituteAddTileState extends State<InstituteAddTile> {

  InstituteBloc get _instituteBloc => BlocProvider.of<InstituteBloc>(context);
  TextEditingController _nameEditingController =TextEditingController();
  TextEditingController _locationEditingController =TextEditingController();
  Institute _institute;


  @override
  void initState(){
    super.initState();
    if(widget.institute !=null){
      _institute =widget.institute;
      _nameEditingController.text =_institute.name;
      _locationEditingController.text =_institute.location;
    }
  }

  @override
  void dispose(){
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xffececec)),
              child: Center(
                child: Icon(Icons.add),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    _instituteNameInput(),
                    _instituteLocationInput()
                  ],
                ),
              ),
            ),
            Container(
              width: 60,
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.save,color: Colors.blue,size: 17.0,),
                    onPressed: (){
                        _instituteBloc.dispatch(SaveButtonPressed(
                          id:_institute != null? _institute.id: null,
                          name:_nameEditingController.text,
                          location:_locationEditingController.text
                        ));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.cancel, color: Colors.red,size: 17.0,),
                    onPressed: (){
                        _instituteBloc.dispatch(CancelButtonPressed());
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

   TextFormField _instituteNameInput() {
    return TextFormField(
      controller: _nameEditingController,
      decoration: const InputDecoration(
          hintText: 'Institute name',
          labelText: 'Name',
          contentPadding: EdgeInsets.symmetric(vertical: 5.0)),
      onSaved: (String value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String value) {
        return value.contains('@') ? 'Do not use the @ char.' : null;
      },
    );
  }

  TextFormField _instituteLocationInput() {
    return TextFormField(
      controller: _locationEditingController,
      decoration: const InputDecoration(
          hintText: 'Institute Location',
          labelText: 'Location',
          contentPadding: EdgeInsets.symmetric(vertical: 5.0)),
      onSaved: (String value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String value) {
        return value.contains('@') ? 'Do not use the @ char.' : null;
      },
    );
  }
}