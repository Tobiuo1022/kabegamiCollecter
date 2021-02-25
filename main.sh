#!/bin/zsh

site="https://anihonetwallpaper.com/"
muse=$site"category/%e3%83%a9%e3%83%96%e3%83%a9%e3%82%a4%e3%83%96%e5%a3%81%e7%b4%99"
aqours=$site"%E3%83%A9%E3%83%96%E3%83%A9%E3%82%A4%E3%83%96-%E3%82%B5%E3%83%B3%E3%82%B7%E3%83%A3%E3%82%A4%E3%83%B3%E5%A3%81%E7%B4%99"
gasaki=$site"category/%e3%83%a9%e3%83%96%e3%83%a9%e3%82%a4%e3%83%96%e8%99%b9%e3%83%b6%e5%92%b2%e5%a3%81%e7%b4%99"

ruby -W0 collecter.rb $muse
ruby -W0 collecter.rb $aqours
ruby -W0 collecter.rb $gasaki

find ~/Pictures/WallPaper -empty | xargs rm
