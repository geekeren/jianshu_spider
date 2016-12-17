require 'pathname'
class DataProcessor

  def initialize(authorList)
    @tpl="view/default.tpl.html"
    @authorList = authorList
  end

  def self.loadAuthorList(authorList)
    DataProcessor.new(authorList)
  end


  def installTpl(tpl)
    @tpl=tpl
    self
  end

  def render()

  end

  def rank

  end

  def out2Html(title)
    tplFile = open @tpl
    tplContent = tplFile.read
    tplFile.close
    content =""
    for i in 0 .. @authorList.length-1
      author = @authorList[i]
      content+=format(" <tr>
            <td>%s</td>
            <td><a target= \"_blank\" href=\"http://jianshu.com/users/%s\">%s</a></td>
            <td>%s</td>
            <td>%s</td>
            <td>%s</td>
            <td>%s</td>
            <td>%s</td>
            <td>%s</td>
            <td>%s</td>
        </tr>", i, author.id, author.name, author.post_count, author.word_count, author.read_count, author.comment_count, author.liked_count, author.fans_count,author.buddy)
    end

    today = Time.new;
    timeStr= today.strftime("(%Y-%m-%d %H:%M:%S)");
    footer="Powered By <a target=\"_blank\" href=\"http://wangbaiyuan.cn\">BrainWang@ThoughtWorks</a>"
    out = tplContent.gsub(/@\{title\}/, title)
    out = out.gsub(/@\{content\}/, content)
    out = out.gsub(/@\{footer\}/, footer)
    out = out.gsub(/@\{time\}/, timeStr)
    timeStr= today.strftime("(%Y-%m-%d)");
    file=open("output/#{title+timeStr}.html", "w")
    file.write out
    print "\n输出文件位于", Pathname.new(File.dirname(__FILE__)).realpath, "/", file.path, "\n"
    file.close

  end


end
