require './model/authorInfo'
class TWAuthorInfo < AuthorInfo
  #从字符串加载对象
  def self.fromPlain(str, separator=",")
    items = str.split(/#{separator}/)
    TWAuthorInfo.new(items[0], items[1], items[2])
  end

  # 构造器方法
  def initialize(id, name, buddy)
    super(id, name)
    @buddy=buddy
  end
  def buddy
    @buddy
  end
end