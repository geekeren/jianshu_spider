require 'net/http'

def loadAuthorListFromFile(file)
  file=open(file)
  list= Array.new()
  while str = file.gets do
    authorInfo = TWAuthorInfo.fromPlain(str, ",")
    list<<authorInfo
  end
  file.close
  list
end


def loadAuthorInfoFromNet(authorInfo)
  h = Net::HTTP.new("www.jianshu.com", 80)
  resp = h.get "/users/#{authorInfo.id}/latest_articles"
  latest_articles_html = resp.body.to_s
  loadAuthorBaseInfoFromHtml(authorInfo, latest_articles_html)
  #从列表页计算用户文章评论量、阅读量
  for i in 1 .. authorInfo.post_count.to_i/10+1 #遍历所有文章列表页，比如24篇文章就是1～3页
    if i !=1
      resp = h.get "/users/#{authorInfo.id}/latest_articles?page=#{i}"
      latest_articles_html = resp.body.to_s
    end
    loadAuthorArticleInfoFromHtml(authorInfo, latest_articles_html)

  end


end

#从html中加载用户文章信息
def loadAuthorArticleInfoFromHtml(authorInfo, latest_articles_html)

  if /<ul class="article-list latest-notes">([\s\S]*?)<\/ul>/ =~ latest_articles_html
  then
    articleListHtml = $1.to_s
    articleListHtml.scan(/<li(.*?)>([\s\S]*?)<\/li>/) { |articleItemHtml|

      infoKeys=["阅读", "喜欢", "评论"]
      infoValues = Array.new(infoKeys.length, 0)
      for i in 0 .. infoKeys.length-1

        if /<div class=\"list-footer\">([\s\S]*?)<\/div>/=~ articleItemHtml[1].force_encoding("UTF-8")
          articleItemFooterHtml = $1
          #p articleItemFooterHtml
          if /#{"#{infoKeys[i]}(\\s+)([0-9]*)".force_encoding("UTF-8")}/ =~ articleItemFooterHtml.force_encoding("UTF-8")
            infoValues[i]+=$2.to_i
          end
        end
      end
      authorInfo.setMoreInfo(authorInfo.read_count+infoValues[0], authorInfo.comment_count+infoValues[2])
    }


  end
end

#从html中加载基本用户信息
def loadAuthorBaseInfoFromHtml(authorInfo, latest_articles_html)
  infoKeys=["粉丝", "关注", "文章", "字数", "收获喜欢"]
  infoValues = Array.new(infoKeys.length)

  if /<ul class=\"clearfix\">([\s\S]*?)<\/ul>/ =~ latest_articles_html
  then
    authorInfoHtml= $1.force_encoding("UTF-8")
    for i in 0 .. infoKeys.length-1
      if /#{"<b>([0-9]*)</b><span>#{infoKeys[i]}</span>".force_encoding("UTF-8")}/=~ authorInfoHtml
        infoValues[i]= $1
      end
    end


  end
  authorInfo.setBaseInfo(infoValues[0], infoValues[1], infoValues[2], infoValues[3], infoValues[4])
end

