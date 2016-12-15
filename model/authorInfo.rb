class AuthorInfo


  def initialize(id, name)
    @id=id
    @name =name
  end

  #从字符串加载对象
  def self.fromPlain(str, separator=",")
    items = str.split(/#{separator}/)
    return AuthorInfo.new(items[0], items[1])

  end

  def id
    @id
  end

  def name
    @name
  end
  @read_count=0

  def post_count()
    @post_count.to_i
  end

  def word_count()
    @word_count.to_i
  end

  def liked_count()
    @liked_count.to_i
  end
  def read_count()
    @read_count.to_i
  end

  @comment_count=0

  def comment_count
    @comment_count.to_i
  end

  def read_count=(read_count)
    @read_count=read_count
  end

  def comment_count=(comment_count)
    @comment_count=comment_count
  end

  def setBaseInfo(fans_count, follow_count, post_count, word_count, liked_count)
    @fans_count=fans_count
    @follow_count=follow_count
    @post_count=post_count
    @word_count=word_count
    @liked_count=liked_count

  end

  def setMoreInfo(read_count, comment_count)
    @read_count=read_count
    @comment_count=comment_count
  end

  # def toHtmlTr(clsName)
  #   html = "<tr><td>%s</td><td>%s</td> <td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>"
  #   String.format(html,)
  # end

end