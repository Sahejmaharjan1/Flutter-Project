import 'package:flutter/material.dart';
import '../models/language.dart';

class ChooseLanguage extends StatefulWidget {
  final Function firstlanguage;
  final Function secondlanguage;
  ChooseLanguage({@required this.firstlanguage, @required this.secondlanguage});

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  // final TextEditingController _searchTextController = TextEditingController();

  List<Language> _language = Language.getLanguages();
  List<DropdownMenuItem<Language>> _dropdownMenuItems;
  Language _selectedLanguagefirst;
  Language _selectedLanguagesecond;
  String value;
  String _selectedLanguageCodefirst;
  String _selectedLanguageCodesecond;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_language);
    _selectedLanguagefirst = _dropdownMenuItems[0].value;
    _selectedLanguagesecond = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Language>> buildDropdownMenuItems(List language) {
    List<DropdownMenuItem<Language>> items = List();
    for (Language language in language) {
      items.add(
        DropdownMenuItem(
          value: language,
          child: Text(language.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItemfirst(Language selectedLanguage) {
    setState(() {
      _selectedLanguagefirst = selectedLanguage;
      _selectedLanguageCodefirst = _selectedLanguagefirst.code;
      print(_selectedLanguageCodefirst);
      widget.firstlanguage(_selectedLanguageCodefirst);
    });
  }

  onChangeDropdownItemsecond(Language selectedLanguage) {
    setState(() {
      _selectedLanguagesecond = selectedLanguage;
      _selectedLanguageCodesecond = _selectedLanguagesecond.code;
      print(_selectedLanguageCodesecond);
      widget.secondlanguage(_selectedLanguageCodesecond);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey[500],
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: DropdownButton(
                value: _selectedLanguagefirst,
                items: _dropdownMenuItems,
                onChanged: onChangeDropdownItemfirst,
              ),
            ),
          ),
          Material(
            color: Colors.white,
            child: IconButton(
              icon: Icon(
                Icons.arrow_right,
                color: Colors.grey[700],
              ),
              onPressed: () {},
//              onPressed: this._switchLanguage,
            ),
          ),
          Expanded(
            child: Center(
              child: DropdownButton(
                value: _selectedLanguagesecond,
                items: _dropdownMenuItems,
                onChanged: onChangeDropdownItemsecond,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
