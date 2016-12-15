require './model/tw_author_info'
require './data_loader'
require './data_processor.rb'
authorInfoList = loadAuthorListFromFile("studentlist.csv")
print "开始抓取\n"
authorInfoList.each_with_index { |authorInfo,i|
  loadAuthorInfoFromNet(authorInfo)
  print "\r完成进度： #{i+1}/#{authorInfoList.length} ……"
}
# p authorInfoList
DataProcessor.loadAuthorList(authorInfoList).out2Html("2017届思沃大讲堂同学简书文章统计")