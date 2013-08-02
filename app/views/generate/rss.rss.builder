xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
    xml.channel do
        xml.title @organizations.map{|o| o.name}.join(', ')
        xml.description "News from the NewsDesk"
        xml.link root_url

        @posts.each do |post|
            xml.item do
                xml.title post.title
                xml.description post.data
                xml.pubDate post.updated_at.to_s(:rfc822)
                xml.guid post_url(post)
            end
        end
    end
end
