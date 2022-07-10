class Book {
  final String title;
  final String urlImage;

  const Book({
    required this.title,
    required this.urlImage,
  });
}

const allBooks = [
  Book(
      title: 'It Ends with Us',
      urlImage:
          'https://images-na.ssl-images-amazon.com/images/I/71l9pCV99FL.jpg'),
  Book(
      title: 'Where the Crawdads Sing',
      urlImage:
          'https://images-na.ssl-images-amazon.com/images/I/61m1Vxw8tiL.jpg'),
  Book(
      title: 'Verity',
      urlImage:
          'https://images-na.ssl-images-amazon.com/images/I/61tqfa+xbWL.jpg'),
];
