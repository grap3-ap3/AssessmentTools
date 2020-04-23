class Report
  
  def initialize(dork,addresses_pastie,addresses_pastebin,addresses_github,addresses_gist)
    @dork = dork
    @addresses_pastie = addresses_pastie 
    @addresses_pastebin = addresses_pastebin
    @addresses_github = addresses_github
    @addresses_gist = addresses_gist
  end
      
  def report
        puts "[*] Creating HTML Report".green
        print "[*] Status: ".green
        file = File.open('report.html', 'w') 
        file.write("<html><head><title>Pastesearch Results for #{@dork}</title><link rel=\"stylesheet\" type=\"text/css\" href=\"lib/css/main.css\" media=\"screen\" /></head><body><div id=\"container\"><div id=\"logo\"><img src=\"lib/img/logo.gif\" width=\"114\" height=\"36\" /></div><div id=\"menu\">Pastesearch: This can take some time to render</div><div id=\"content\">")
        if @addresses_pastie.nil? == false
          file.write("<h2>Search Term: \"#{@dork}\" <br /> Site: Pastie - Found: #{@addresses_pastie.count} Items</h2>\n")
            @addresses_pastie.each do |links|
              file.write("<p><iframe src=#{links}/text style=\"width: 100%; height: 300px; background-color: white\"></iframe><p>link: <a href=\"#{links}\" target=\"_blank\">#{links}</a>\n")
              print ".".green
            end
          file.write("<hr><hr>")
          end
       if @addresses_pastebin.nil? == false         
          file.write("<br /><h2>Site: Pastebin - Found: #{@addresses_pastebin.count} Items</h2>\n")  
            @addresses_pastebin.each do |links|
                file.write("<p><iframe src=\"http://pastebin.com/embed_iframe.php?i=#{links}\" style=\"border:none;width:100%;height:300px\"></iframe><p>link: <a href=\"http://pastebin.com/#{links}\" target=\"_blank\">http://pastebin.com/#{links}</a>\n")
              print ".".green
            end
            file.write("<hr><hr>")
          end
       if @addresses_github.nil? == false
        file.write("<br /><h2>Site: Github - Found: #{@addresses_github.count} Items</h2>\n")
          @addresses_github.each do |links|
          file.write("<p><iframe src=#{links} style=\"width: 100%; height: 300px; background-color: white\"></iframe><p>link: <a href=\"#{links}\" target=\"_blank\">#{links}</a>\n")
          print ".".green
         end
       end
       if @addresses_gist.nil? == false
        file.write("<br /><h2>Site: Github Gist - Found: #{@addresses_gist.count} Items</h2>\n")
          @addresses_gist.each do |links|
          file.write("<p><script src=\"https://gist.github.com#{links}.js\"></script><p>link: <a href=\"#{links}\" target=\"_blank\">#{links}</a>\n")
          print ".".green
         end
       end
        file.write("</div><div id=\"footer\">&copy; Corelan Team | Written by Nullthreat</div><center><img src=\"lib/img/corelanlogo_small.jpg\"></center></div></body></html>")
        file.close
        puts "\n[*] HTML Report Created".green
      end
end
