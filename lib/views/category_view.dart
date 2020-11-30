import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/util/news.dart';
import 'package:news_app/views/home.dart';

class CategoryView extends StatefulWidget {
  String category;
  CategoryView({this.category});
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ArticleModel> articles=[];
  bool _loading=true;
  @override
  void initState() {
    super.initState();
    getNews(widget.category);
  }
  void getNews(String category) async{
    CategoryNews cn=CategoryNews();
    await cn.getCategoryNews(category);
    articles=cn.news;
    setState(() {
      _loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.category[0].toUpperCase()+widget.category.substring(1)+" News ",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),),
            Text("For You",style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),)
          ],
        ),
        centerTitle: true,
    ),
    body: _loading? Center(
      child: CircularProgressIndicator(),
    ):
    articles.length>0? Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: articles.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context,index){
          return ArticleTile(
            imageUrl: articles[index].urlToImage,
            title: articles[index].title,
            desc: articles[index].desc,
            url: articles[index].url,
          );
        },
      ),
    ): Container(
      child: Text("No data to show :("),
    ),

    );
  }
}