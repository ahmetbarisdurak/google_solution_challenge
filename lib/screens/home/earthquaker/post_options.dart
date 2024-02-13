import 'package:google_solution_challenge/screens/home/earthquaker/debris_post/debris_post_page.dart';
import 'package:google_solution_challenge/screens/home/earthquaker/missing_post/missing_post_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../translations/locale_keys.g.dart';

class PostOptions extends StatefulWidget {
  const PostOptions({super.key});

  @override
  State<PostOptions> createState() => _PostOptionsState();
}

showOptions(context) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(LocaleKeys.make_your_voice_heard_choose.tr()),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MissingPostPage()),
              );
            },
            child: Text(LocaleKeys.make_your_voice_heard_report_missing.tr()), // Kayıp ilanı veriyor.
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DebrisPostPage()),
            ),
            child: Text(LocaleKeys.make_your_voice_heard_report_debris.tr()), // Yıkılmış bina ilanı veriyor. kaldırılabilir
          ),
          SimpleDialogOption(
            child:
            Text(LocaleKeys.make_your_voice_heard_debris_page_cancel.tr()),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}

class _PostOptionsState extends State<PostOptions> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
