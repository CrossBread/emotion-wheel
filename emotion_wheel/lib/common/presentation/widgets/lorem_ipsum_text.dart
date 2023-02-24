import 'package:flutter/material.dart';

class LoremIpsumText extends StatelessWidget {
  final bool isOneLine;

  const LoremIpsumText({
    super.key,
    this.isOneLine = false,
  });

  const LoremIpsumText.oneLine({
    super.key,
  }) : isOneLine = true;

  @override
  Widget build(BuildContext context) {
    return Text(
        List<String>.generate(1000, (index) {
          var loremIpsumText =
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
          int length = loremIpsumText.split(' ').length;
          return loremIpsumText.split(' ')[index % length];
        }).join(' '),
        overflow: isOneLine ? TextOverflow.ellipsis : TextOverflow.fade);
  }
}
