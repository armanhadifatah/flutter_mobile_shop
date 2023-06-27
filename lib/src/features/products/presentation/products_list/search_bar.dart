import 'package:flutter/material.dart';

import '../../../../constants/app_sizes.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  SearchBarWidget({super.key});

  Function _onSearch(String value) {
    return (value) {
      print(value);
    };
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return SizedBox(
      height: Sizes.p48,
      width: double.infinity,
      child: TextField(
        controller: controller,
        // strutStyle: const StrutStyle(
        //   height: 1.5,

        // ),
        style: TextStyle(
          fontSize: 16,
          height: 1.5,
          color: primaryColor,
        ),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: primaryColor,
          ),
          suffixStyle: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: primaryColor,
          ),

          prefixIcon: Icon(
            Icons.search,
            color: primaryColor,
          ),

          fillColor: Theme.of(context).secondaryHeaderColor,
          suffixIcon: IconButton(
            icon: Icon(Icons.clear, color: primaryColor),
            onPressed: () {
              controller.clear();
              _onSearch('');
            },
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: Sizes.p12,
            horizontal: Sizes.p20,
          ),
          focusedBorder: outLinedBorder(),
          enabledBorder: outLinedBorder(),

          border: outLinedBorder(),
          // backgroundColor: Colors.white,
        ),
        onChanged: _onSearch,
      ),
    );
  }

  outLinedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20), // radius of the border
      borderSide: const BorderSide(
        color: Colors.transparent, // color of the border
        width: 0, // width of the border
      ),
    );
  }
}
