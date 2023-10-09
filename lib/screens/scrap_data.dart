import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;

class WebScraperApp extends StatefulWidget {
  @override
  _WebScraperAppState createState() => _WebScraperAppState();
}

class _WebScraperAppState extends State<WebScraperApp> {
  // initialize WebScraper by passing base url of website

  List<String> titles = [];

  @override
  void initState() {
    super.initState();
    // Requesting to fetch before UI drawing starts
    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse(
        'https://www.google.com/search?q=margalla+hills+national+park&oq=margalla+hills+national+park&aqs=chrome.0.35i39i355j46i39i175i199j0i512l3j69i60j69i61j69i60.2986j0j7&sourceid=chrome&ie=UTF-8#lpqa=d,2');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('#pqaQ > div > div > div.yZZ28b > div > div.tlRQ11YQ67J__lupqa-p.tyESJkV0cFa__pqa-d > div:nth-child(1) > div:nth-child(1) > div > div.t6X3Re > a > div')
        .map((element) => element.innerHtml.trim())
        .toList();
    setState(() {
      this.titles = titles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Web scrapping"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: titles.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
        itemBuilder: (context, index) {
          final title = titles[index];
          return Text(title);
        },
      ),
    );
  }
}
