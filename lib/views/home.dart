import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/util/news.dart';
import 'package:news_app/util/data.dart';
import 'category_view.dart';
import 'article_view.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories=new List<CategoryModel>();
  List<ArticleModel> articles= new List<ArticleModel>();
  bool _loading=true;
  @override
  void initState() {
    super.initState();
    categories=getCategories();
    getNews();
  }
  void getNews() async{
    News n=News();
    await n.getNews();
    articles=n.news;
    setState(() {
      _loading=false;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News ",
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
    body: _loading ? Center(
      child: CircularProgressIndicator(),
    )
     :RefreshIndicator(
          onRefresh: () async {
            setState(() {
              getNews();
            });
            return await Future.delayed(Duration(seconds: 3));
          },
            child: SingleChildScrollView(
              child: Container(
          child: Column(
            children: <Widget>[
              //categories
              Container(
                height: 70,
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.symmetric(horizontal: 16,),
                child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount:categories.length ,
                itemBuilder: (context,index){
                  return CategoryTile(category: categories[index].category,
                  imageUrl: categories[index].imageUrl,);
                },
                  ),
              ),

              //articles
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16,),
                child: ListView.builder(
                  itemCount: articles.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return ArticleTile(imageUrl: articles[index].urlToImage,
                    title: articles[index].title,
                    desc: articles[index].desc,
                    url: articles[index].url,
                    );

                  },
                )
              )
            ],
          ),
    ),
       ),
     ),
    );
  }
}
class CategoryTile extends StatelessWidget {
  String category,imageUrl;
  CategoryTile({this.category,this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=> CategoryView(category: category.trim().toLowerCase(),)
        ));
      },
          child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children:<Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
               height: 60,
               width: 120,
               fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black26,
              ),
              child: Text(category,style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white
              ),),
            )
            
        ],),
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {
  String imageUrl,title,desc,url;
  ArticleTile({this.imageUrl,this.title,this.desc,this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=> ArticleView(
              blogUrl: url,
            )
          
          ));
        },
        child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
              fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5,),
            Text(title,style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),),
            SizedBox(height: 5,),
            Text(desc),
          ],
        ),
      ),
    );
  }
}