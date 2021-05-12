import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix/models/movie_model.dart';
import 'package:netflix/screens/MovieScreen.dart';
import 'package:netflix/widgets/contentscroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 1, viewportFraction: 0.8);
    super.initState();
  }

  _movieindex(int index) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (pageController.position.haveDimensions) {
          value = pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 270,
            width: Curves.easeInOut.transform(value) * 400,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => MovieScreen(
                        movie: movies[index],
                      )));
        },
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(0.0, 4.0),
                      color: Colors.black54,
                    ),
                  ],
                ),
                child: Center(
                  child: Hero(
                    tag: movies[index].imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: AssetImage(movies[index].imageUrl),
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              bottom: 40,
              child: Container(
                width: 250,
                child: Text(
                  movies[index].title.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Image(
          image: AssetImage("assets/images/netflix_logo.png"),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
          padding: EdgeInsets.only(left: 10),
          iconSize: 30,
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            padding: EdgeInsets.only(right: 10),
            iconSize: 30,
            color: Colors.black,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 280,
            width: double.infinity,
            child: PageView.builder(
              controller: pageController,
              itemCount: movies.length,
              itemBuilder: (ctx, index) {
                return _movieindex(index);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ContentScroll(
            images: myList,
            imageHeight: 250,
            imageWidth: 150,
            title: "My List",
          ),
          SizedBox(
            height: 10,
          ),
          ContentScroll(
            images: myList,
            imageHeight: 250,
            imageWidth: 150,
            title: "Trending",
          ),
          SizedBox(
            height: 10,
          ),
          ContentScroll(
            images: myList,
            imageHeight: 250,
            imageWidth: 150,
            title: "You may also like",
          ),
        ],
      ),
    );
  }
}
