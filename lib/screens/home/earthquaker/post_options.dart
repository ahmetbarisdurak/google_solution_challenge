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
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          LocaleKeys.make_your_voice_heard_choose.tr(),
          style: TextStyle(
            color: Colors.black, // Başlık rengi
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MissingPostPage()),
              );
            },
            child: ListTile(
              leading: Icon(Icons.search, color: Colors.grey[900]), // Kayıp ilanı için ikon
              title: Text(
                LocaleKeys.make_your_voice_heard_report_missing.tr(),
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context),
            child: ListTile(
              leading: Icon(Icons.close, color: Colors.red), // İptal için kırmızı ikon
              title: Text(
                LocaleKeys.make_your_voice_heard_debris_page_cancel.tr(),
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
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
