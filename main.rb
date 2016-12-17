require './model/tw_author_info'
require './data_loader'
require './data_processor.rb'
authorInfoList = loadAuthorListFromFile("studentlist.csv")
print "\n\n Note:真实姓名被保护，如果你要统计思沃大讲堂同学简书文章信息请通过微信向我索取\n"
print "\n开始抓取\n"
authorInfoList.each_with_index { |authorInfo,i|
  loadAuthorInfoFromNet(authorInfo)
  print "\r完成进度： #{i+1}/#{authorInfoList.length} ……"
}
# p authorInfoList

DataProcessor.loadAuthorList(authorInfoList).out2Html("2017届思沃大讲堂同学简书文章统计")
