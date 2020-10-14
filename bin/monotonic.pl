#!/usr/bin/perl

# monotonic distributed counter ... for time stamping

# time is the only monotonic variable
# that everyone could agree on

my $dbug = 1;
# run as a PLL, with a phase detection correcting the rate ... 

# multiplier :
my $m = 34/23;
printf "m: %s\n",$m;

my $acc = 0;
my ($n,$q) = (int($m),1);
my $freq = $n / $q;
my $step = 1/int($m);
my ($inc,$dec) = (0,0);

my $tic = 0;
local *F;
open F,'>','data.xls';
my $h = select(F); $|=1; select($h); # autoflush
printf F "p/m,tic,acc,trg,delta,step,freq,n,q,inc,dec,i-d\n";
printf  "p/m,tic,acc,trg,delta,step,freq\n";
my $p = 0;
my $c = 1/3;
while (1) {
  $p += rand(4) - 2 + 1; # in average increment by 1
  $acc += $step;
  if ($acc >= 1) { 
    $delta = $tic * $m - $p; # phase detect
    $trg = 1;
    $tic++;
    if ($delta > 0) {
      $dec++; # tic is too fast !
      $acc -= 1/$m; # phase adjust
      # increase delay, slow down DLL (freq-).
      # decrease step, ...
      if ($q > 1) { $q-- };
      $n++;
     } else {
      $inc++; # tic is late !
      $acc += 1/$m; # immediate phase adjust;
      # decrease delay, speed up DLL (freq+)
      # increase step, ...
      if ($n > 1) { $n-- } 
      $q++;
    }
    $step = $q/$n; # adjust delay 
    $freq = $n/$q;
  } else {
    $trg = 0;
  }

  printf F "%f,%u,%f,%u,%f,%f,%f,%u,%u,%u,%u,%u\n",$p/$m,$tic,$acc,$trg,$delta,$step,$freq,$n,$q,$inc,$dec,$inc-$dec;
  printf  "%.3f,%u,a:%f,%u,d:%f,s:%f,f:%f",$p/$m,$tic,$acc,$trg,$delta,$step,$freq;
  $acc -= 1 if $trg;
  if ($dbug) {
  my $ans = <STDIN>;
  } else {
    print "\n";
    sleep(0.1);
  }

}

sub flush { my $h = select($_[0]); my $af=$|; $|=1; $|=$af; select($h); }

1;
