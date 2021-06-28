#!/usr/bin/perl -w
use Tk;
use utf8;

my $mw = MainWindow->new;
$mw->geometry("400x480");
$mw->title("英汉小词典 Paul-sinbud2004");

my $main_frame = $mw->Frame()->pack(-side => 'top',-fill =>'x');
my $top_frame = $main_frame->Frame(-background => 'white')
                ->pack(-side => 'top',-fill => 'x');
my $bottom_frame = $main_frame->Frame(-background => 'white')
                   ->pack(-side => 'bottom',-fill => 'y');

$top_frame->Label(-text=>"单词:",-font=>[-size=>'12'],-background =>'purple')->pack(-side=>'left');
my $word_entry = $top_frame->Entry(-background=>"white",-foreground=>"black",-font=>[-size=>'12'])->pack(-side => 'left');
my $word_button = $top_frame->Button(-text=>"查询",-font=>[-size=>'12'],-command => \&search_bing)->pack(-side => "right");

my $bottom_text = $bottom_frame->Text(-background => "green",-foreground => "purple",-font=>[-size=>'12'])->pack(-side => "top");
my $bottom_button = $bottom_frame->Button(-text=>"清空",-font=>[-size=>'12'],-command => \&clean_text)->pack(-side => "bottom");

use Encode;
sub search_bing{
  my $ask = $word_entry->get();
  
  my $result = `./bing.pl $ask`; 

  $result = decode("utf-8",$result);
  $result = ">>>>>>".$ask."的解释:\n".$result;

  $bottom_text->insert("end",$result);

}

sub clean_text{
  $bottom_text->delete('0.0','end');
}

MainLoop;
