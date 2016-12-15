# jianshu_spider

Ruby爬虫统计简书用户的文章信息

## 使用方法

* 下载项目代码并运行


```
git clone git@github.com:geekeren/jianshu_spider.git
cd jianshu_spider/
 ruby main.rb
```

##项目文件

view/default.tpl.html是输出文件的模板，所以可以修改输出文件的样式布局

##输入文件

**studentlist.csv**：用户列表文件，csv格式

* 每一行记录用户ID(简书用户主页URL /users/后面的字段)，用户姓名，小buddy姓名

##输出文件

 位于out文件夹下
