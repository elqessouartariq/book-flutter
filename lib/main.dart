import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Book Library';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
      routes: {
        '/book-list': (context) => BookListScreen(),
        '/adherants': (context) => AdherantsScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlqkfpQ8Tq7Jk_f07dgVFmSE0MN3pr1dw3vpHWiAMcbQ&s',
            width: 300,
            height: 200,
          ),
          const SizedBox(height: 20),
          const Text(
            'Bienvenue dans notre bibliothèque !',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Text(
              'Découvrez notre vaste collection de livres et profitez de notre espace de lecture confortable.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,

              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fHww'),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -6,
                    child: const Center(
                      child: Text(
                        'Book Library - Tariq El Qessouar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Books'),
              onTap: () {
                Navigator.pushNamed(context, '/book-list');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Adherants'),
              onTap: () {
                Navigator.pushNamed(context, '/adherants');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        child: const Icon(Icons.add),
        onPressed: () {
          // action on button press
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}


class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final List<Map<String, dynamic>> _books = [
    {
      'title': 'The Compound Effect',
      'author': 'Darren Hardy',
      'coverImage': 'https://store.darrenhardy.com/cdn/shop/products/DSC02177_1_900x.jpg?v=1607554239',
      'description': 'The Compound Effect emphasizes the power of daily decisions and consistent action. It discourages readers from seeking quick fixes or magic bullets, instead advocating for a long-term approach to achieving goals. By making small improvements each day and taking responsibility for your choices, the book argues, you can eventually achieve great success. The Compound Effect also highlights the importance of measurement and tracking progress, as well as taking 100% responsibility for your life.'
    },
    {
      'title': 'The Bogleheads\' Guide to Investing',
      'author': 'Taylor Larimore',
      'coverImage': 'https://media.karousell.com/media/photos/products/2021/3/2/the_bogleheads_guide_to_invest_1614655096_5c40d1ea_progressive.jpg',
      'description': 'The Bogleheads\' Guide to Investing goes beyond just stock picking and market timing. It dives into sound financial habits like paying off debt, building an emergency fund, and living frugally. The core message centers around building a diversified portfolio with low-cost index funds that track the overall market. This approach aims to maximize returns while minimizing fees and emotional investing.  The book also emphasizes the importance of staying invested for the long haul and avoiding impulsive decisions based on market fluctuations.'
    },
  ];
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _coverImageController = TextEditingController();
  int? _editingIndex;

  void _addBook() {
    setState(() {
      _books.add({
        'title': _titleController.text,
        'author': _authorController.text,
        'coverImage': _coverImageController.text,
      });
      _titleController.clear();
      _authorController.clear();
      _coverImageController.clear();
    });
  }

  void _updateBook(int index) {
    setState(() {
      _books[index] = {
        'title': _titleController.text,
        'author': _authorController.text,
        'coverImage': _coverImageController.text,
      };
      _editingIndex = null;
      _titleController.clear();
      _authorController.clear();
      _coverImageController.clear();
    });
  }

  void _deleteBook(int index) {
    setState(() {
      _books.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des livres'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Titre du livre',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _authorController,
                    decoration: InputDecoration(
                      hintText: 'Auteur',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _coverImageController,
                    decoration: InputDecoration(
                      hintText: 'URL de l\'image de couverture',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _editingIndex == null ? _addBook : () => _updateBook(_editingIndex!),
                  child: Text(_editingIndex == null ? 'Ajouter' : 'Mettre à jour'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return Dismissible(
                  key: Key(book['title']),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _deleteBook(index);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: book),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            book['coverImage'],
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book['title'],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  book['author'],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _titleController.text = book['title'];
                                          _authorController.text = book['author'];
                                          _coverImageController.text = book['coverImage'];
                                          _editingIndex = index;
                                        });
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    SizedBox(width: 8.0),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Copier l'URL du livre dans le presse-papiers
                                        final bookUrl = 'https://example.com/book/${book['title']}';
                                        Clipboard.setData(ClipboardData(text: bookUrl));

                                        // Afficher un message pop-up
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('URL du livre copiée dans le presse-papiers'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      child: const Text('Partager URL'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}

class BookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailScreen({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                book['coverImage'],
                width: 300,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              book['title'],
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Auteur: ${book['author']}',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              book['description'] ?? 'Aucune description disponible.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdherantsScreen extends StatefulWidget {
  @override
  _AdherantsScreenState createState() => _AdherantsScreenState();
}

class _AdherantsScreenState extends State<AdherantsScreen> {
  final List<Map<String, dynamic>> _adherants = [
    {
      'name': 'Adhérant 1',
      'email': 'adherant1@example.com',
      'phone': '0123456789',
    },
    {
      'name': 'Adhérant 2',
      'email': 'adherant2@example.com',
      'phone': '9876543210',
    },
  ];
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  int? _editingIndex;

  void _addAdherant() {
    setState(() {
      _adherants.add({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      });
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
    });
  }

  void _updateAdherant(int index) {
    setState(() {
      _adherants[index] = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      };
      _editingIndex = null;
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
    });
  }

  void _deleteAdherant(int index) {
    setState(() {
      _adherants.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des adhérents'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Nom',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: 'Téléphone',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _editingIndex == null ? _addAdherant : () => _updateAdherant(_editingIndex!),
                  child: Text(_editingIndex == null ? 'Ajouter' : 'Mettre à jour'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _adherants.length,
              itemBuilder: (context, index) {
                final adherant = _adherants[index];
                return Dismissible(
                  key: Key(adherant['name']),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _deleteAdherant(index);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.person, size: 50),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                adherant['name'],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                adherant['email'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                adherant['phone'],
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _nameController.text = adherant['name'];
                                        _emailController.text = adherant['email'];
                                        _phoneController.text = adherant['phone'];
                                        _editingIndex = index;
                                      });
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  SizedBox(width: 8.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Copier les informations de l'adhérant dans le presse-papiers
                                      final adherantInfo = 'Nom: ${adherant['name']}\nEmail: ${adherant['email']}\nTéléphone: ${adherant['phone']}';
                                      Clipboard.setData(ClipboardData(text: adherantInfo));

                                      // Afficher un message pop-up
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Informations de l\'adhérant copiées dans le presse-papiers'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    child: Text('Partager'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('À propos'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                'https://media.istockphoto.com/id/171383850/photo/brain-bookshelf.jpg?s=612x612&w=0&k=20&c=xubbesC1qkn04LGijuV34ACkDmLKKYl_ZtVNziWTb4k=',
                width: 150,
                height: 150,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Book Library',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Version 1.0',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'À propos de l\'application',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Book Library est une application de gestion de bibliothèque en ligne. Elle permet aux utilisateurs de consulter la liste des livres disponibles, d\'ajouter de nouveaux livres, de les mettre à jour et de les supprimer. Les adhérents peuvent également être gérés à l\'aide de cette application.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Fonctionnalités',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '- Gestion de la liste des livres (ajout, mise à jour, suppression)\n- Gestion de la liste des adhérents (ajout, mise à jour, suppression)\n- Partage des informations des livres et des adhérents',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Contactez-nous',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Email: contact@booklibrary.com\nTéléphone: 01 23 45 67 89',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}


class BottomNavigationBarWidget extends StatefulWidget {
  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      fixedColor: Colors.green,
      unselectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: "Books",
          icon: Icon(Icons.book),
        ),
        BottomNavigationBarItem(
          label: "Adherants",
          icon: Icon(Icons.account_circle),
        ),
        BottomNavigationBarItem(
          label: "About",
          icon: Icon(Icons.info),
        ),
      ],
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
        switch (index) {
          case 0:
          // Navigate to home page
            Navigator.pushNamed(context, '/');
            break;
          case 1:
          // Navigate to book list page
            Navigator.pushNamed(context, '/book-list');
            break;
          case 2:
          // Navigate to adherants page
            Navigator.pushNamed(context, '/adherants');
            break;
          case 3:
          // Navigate to about page
            Navigator.pushNamed(context, '/about');
            break;
        }
      },
    );
  }
}