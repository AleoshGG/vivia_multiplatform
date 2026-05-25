import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(24.0),
      child: SvgPicture.asset(
          'assets/images/logo.svg',
          height: 180.0,
          width: 180.0,
        )
    );
  }



}