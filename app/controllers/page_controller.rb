class PageController < ApplicationController

  require 'date'
  require 'csv'

  def home
    file_path = File.expand_path("../assets/news/stories.json", File.dirname(__FILE__))
    file = File.open(file_path)
    data = file.read
    file.close
  	return render "index.html.erb", :layout => false
  end
  
  def roster
  	file_path = File.expand_path("../assets/roster.csv", File.dirname(__FILE__))
  	file = File.open(file_path)
  	data = file.read
  	file.close
  	params[:roster] = CSV.parse(data)
  	return render "roster.html.erb"
  end

  def frolf
    file_path = File.expand_path("../assets/frolf.txt", File.dirname(__FILE__))
    file = File.open(file_path)
    data = file.read
    file.close
    params[:holes] = JSON.parse(data)
    return render "frolf.html.erb"
  end

  def bufo
    return render "bufo.html.erb"
  end

  def news
    params[:current] = 1
    return news_page()
  end

  def news_page
    file_path = File.expand_path("../assets/news/stories.json", File.dirname(__FILE__))
    file = File.open(file_path)
    data = file.read
    file.close
    stories =  [ JSON.parse(data) ]
    total_pages = (stories.count-1) / 5 + 1
    if params[:current] > total_pages
      return redirect_to "/news"
    end
    start = (params[:current]-1)*5
    params[:news] = []
    for i in start..start+4
      file_path = File.expand_path("../assets/news/#{stories[0][i]}.json", File.dirname(__FILE__))
      file = File.open(file_path)
      data = file.read
      file.close
      params[:news].append(JSON.parse(data))
    end
    params[:pagenums] = [1..total_pages]
    return render "blog.html.erb"
  end

  def story
    file_path = File.expand_path("../assets/news/#{params[:story]}.json", File.dirname(__FILE__))
    file = File.open(file_path)
    data = file.read
    file.close
    params[:story] = JSON.parse(data)
    print params[:story]
    return render "single.html.erb"
  end

  def history
    return render "history.html.erb"
  end

  def subscribe
    file_path = File.expand_path("../assets/subscribers.json", File.dirname(__FILE__))
    file = File.open(file_path)
    data = file.read
    sublist = JSON.parse(data)
    if not sublist.include? params[:email]
      sublist.append(params[:email])
      output = JSON.generate(sublist)
      File.open(file_path, "w") {|file| file.puts output}
    end
    file.close

    redirect_to "/home"
  end

end
