require 'minitest/autorun'
require './collecter'

class CollecterTest < Minitest::Test
	def setup()
		site = "https://anihonetwallpaper.com/"
		muse = site + "category/%e3%83%a9%e3%83%96%e3%83%a9%e3%82%a4%e3%83%96%e5%a3%81%e7%b4%99"
		@site_url = muse
		@sumple_post_url = site + "%e3%83%a9%e3%83%96%e3%83%a9%e3%82%a4%e3%83%96%e5%a3%81%e7%b4%99/34679"
	end	

	def test_save_dir()
		assert_path_exists "#{Dir.home}/Pictures/WallPaper/"
	end

	def test_set_up()
		# nilでないかのcheckのみ行っている
		doc = set_up(@site_url)
		assert doc
	end

	def test_take_max_page()
		# nilでないかのcheckのみ行っている
		max_page = take_max_page(@site_url)
		assert max_page
	end
end


