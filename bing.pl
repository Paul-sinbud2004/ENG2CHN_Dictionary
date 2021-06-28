#!/usr/bin/perl -w
use LWP::UserAgent;
#Make sure LWP::Protocol::https is installed;

my $ask = shift;

my $get_page = LWP::UserAgent -> new;
$get_page -> timeout(10);

my $page_addr = "https://cn.bing.com/dict/${ask}?mkt=zh-CN&setlang=ZH";
my $response = $get_page -> get($page_addr);
my $content = $response ->content;
#print "网页已经获取\n";
#print $content;

$content =~ m/content=\"必应词典为您提供(.*?)\"/ ;
  my $mid_res = $1;
  $mid_res =~ s/，/\n/g;
  $mid_res =~ s/\.\s+/./g;
  my @res = split /\s+/,$mid_res;


foreach (@res){
  if(/的释义/){
      print "\n-----必应词典-----\n";
  }elsif(/网络释义/){
      print "-----其它翻译-----\n";
  }else{
  print $_."\n\n";
  }
}

