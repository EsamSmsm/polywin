import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
    this.controller,
    this.search,
  }) : super(key: key);

  final TextEditingController controller;
  final Function search;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
          ),
        ],
      ),
      child: TextFormField(
        textDirection: TextDirection.rtl,
        onChanged: (value) => search,
        onFieldSubmitted: (value) => search,
        controller: controller,
        cursorColor: Colors.grey,
        // cursorHeight: 26,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          prefix: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black54,
            ),
            onPressed: search,
          ),
          hintText: 'بحث',
          hintTextDirection: TextDirection.rtl,
          hintStyle: TextStyle(
            color: Color(0xffA1A1A1),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
