require 'nokogiri'
require 'open-uri'

site_url = ARGV[0]
save_dir = "#{Dir.home}/Pictures/WallPaper/"

def set_up(url)
    html = URI.open(url)
    doc = Nokogiri::HTML(html)
    return doc
end

def download_img(img_url, save_path)
    """
    画像のURLから画像をダウンロードする.
    """
    File.open(save_path, 'w') do |file|
        open(img_url) do |img|
            file.write(img.read)
        end
    end
end

def take_img_urls(post_url)
    """
    投稿ページ内にある1920x1080の画像のURLの配列を取得する.
    """
    post_doc = set_up(post_url)

    # 1920x1080のimgタグを取得.
	img_tags = post_doc.xpath("//a[@class='button add-dl']")

    img_urls = img_tags.each.map do |img_tag|
        img_path = img_tag.attribute('href').value
    end
end

def take_max_page(site_url)
    site_doc = set_up(site_url)
    p_tag = site_doc.xpath("//div[@class='post_box2']/p[@class='center']")[0]
    page = p_tag.content.match(/\d+(?=\sページ)/)

    return page[0].to_i
end

def take_post_urls(page_doc)
    """
    ページ内にあるpc向けの投稿ページのURLの配列を取得する.
    """
    # pc向けの投稿のaタグを取得.
    a_tags = page_doc.xpath("//h3[@class='posttitle']/span/a")

    # ページ内の全ての投稿URLを取得.
    img_size= /^(?=.*1920)(?=.*1080).*$/
    post_urls = []
    a_tags.each do |a_tag|
        if a_tag.content.match?(img_size)
             post_url = a_tag.attribute('href').value
             post_urls.append(post_url)
        end
    end
    return post_urls
end

if __FILE__ == $0
    max_page = take_max_page(site_url)
    1.upto(max_page) do |page_num|
        p page_num

        # ページのNokogiri::HTML::Documentを取得.
        page_url = site_url + "/page/#{page_num.to_s}"
        page_doc = set_up(page_url)

        # ページから投稿URLの配列を取得.
        post_urls = take_post_urls(page_doc)

        post_urls.each do |post_url|
            img_urls = take_img_urls(post_url)

            # 投稿ページ内の全ての画像をダウンロード.
            img_urls.each do |img_url|
                # urlの末尾を取得.
                img_name = img_url.match(/[^\/]*?$/).to_s
                save_path = save_dir + img_name
                download_img(img_url, save_path) rescue nil
                p img_name
            end
        end
    end
end
