import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:news_app/models/article.dart';
import 'package:http/http.dart' as http;
class News{
  List<ArticleModel> news=[];
  Future<void> getNews() async{
    String url="https://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=35d94a28776f4263b2989aee707cc8ac";
    var response= await http.get(url);
    var json_data=jsonDecode(response.body);
    if(json_data['status']=="ok"){
      json_data['articles'].forEach((data){
        if(data['urlToImage']!=null && data['description']!=null){
        ArticleModel articleModel=ArticleModel(
          title: data['title'],
          desc: data['description'],
          url: data['url'],
          urlToImage: data['urlToImage'],
          content: data['content'],
          author: data['author'],
        );
        news.add(articleModel);
      }

      });
      
    }

  }
}
class CategoryNews{
  List<ArticleModel> news=[];
  Future<void> getCategoryNews(String category) async{
    String url="https://newsapi.org/v2/top-headlines?country=in&category=$category&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=35d94a28776f4263b2989aee707cc8ac";
    var response= await http.get(url);
    var json_data=jsonDecode(response.body);
    if(json_data['status']=="ok"){
      json_data['articles'].forEach((data){
        if(data['urlToImage']!=null && data['description']!=null){
        ArticleModel articleModel=ArticleModel(
          title: data['title'],
          desc: data['description'],
          url: data['url'],
          urlToImage: data['urlToImage'],
          content: data['content'],
          author: data['author'],
        );
        news.add(articleModel);
      }

      });
      
    }

  }
}