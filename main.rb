require './model/tw_author_info'
require './data_loader'
require './data_processor.rb'
authorInfoList = loadAuthorListFromFile("studentlist.csv")
print "\n\n Note:真实姓名被保护，如果你要统计思沃大讲堂同学简书文章信息请通过微信向我索取\n"
print "\n开始抓取\n"

def printProcess(completed, total)
  rate = ((completed.to_f/total)*20).to_i
  rateStr="["
  rate.times {
    rateStr+="#"
  }

  (20-rate).times {
    rateStr+=" "
  }
  rateStr+="]"

  print "\r完成进度： #{rateStr}  #{completed/total==1? "completed!":format("%s/%s",completed,total) }"
end

authorInfoList.each_with_index { |authorInfo, i|
  loadAuthorInfoFromNet(authorInfo)
  printProcess(i+1, authorInfoList.length)
}


# p authorInfoList

DataProcessor.loadAuthorList(authorInfoList).out2Html("2017届思沃大讲堂同学简书文章统计")
