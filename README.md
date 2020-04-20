## holoClock

every time we have to rely on a trusted time we use the holoClock
it accuracy is within the minutes as we don't need second in the real
physical realm, (we don't want nanosecond trading etc...)

We obtain accuracy with parallelism (a la [DLL] !)

 to make a secure clock we need: 
 
 1.  make it monotonic 
 2.  make it "unpredictable" (i.e no one can guess the time before it happened !)
 3.  make it decentralized


[DLL]: https://qwant.com/?q=%26g+delay+locked+loop+Michel+Combes
