import 'package:flutter/material.dart';
import 'package:lab4/book.dart';
import 'book_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  List<Book> books = allBooks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(16),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Book Title',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.blue))),
            onChanged: searchBook,
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: books.length,
                itemBuilder: ((context, index) {
                  final book = books[index];
                  return ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Image.network(
                        book.urlImage,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(book.title),
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookPage(book: book)),
                          ));
                })))
      ]),
    );
  }

  void searchBook(String query) {
    final suggestions = allBooks.where((book) {
      final bookTitle = book.title.toLowerCase();
      final input = query.toLowerCase();

      return bookTitle.contains(input);
    }).toList();
    setState(() => books = suggestions);
  }
}

class MySearchDelegate extends SearchDelegate {
  //ลิสตัวเลือก
  List<String> searchResults = [
    'Americano',
    'Espresso',
    'Cappuccino',
    'Latte',
    'Mocha',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      //กำหนดปุ่มลบข้อความในช่องค้นหา
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    //กำหนดปุ่มย้อนกลับ
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    //แสดงข้อความที่เลือกจากตัวเลือกบนหน้าจอ
    return Center(
        child: Text(query,
            style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //แสดงรายการตัวเลือกโดยนำคำที่ค้น มาหาในลิสตัวเลือก
    List<String> suggestions = searchResults.where(((element) {
      final result = element.toLowerCase(); //แปลงตัวอักษรเป็นพิมพ์เล็ก
      final input = query.toLowerCase();

      return result.contains(input);
    })).toList();

    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;

              showResults(context);
            },
          );
        });
  }
}
