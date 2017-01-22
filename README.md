# dispatch_semaphore

转载请注明出处http://www.cnblogs.com/snailHL/p/3906112.html

dispatch_semaphore是GCD用来同步的一种方式，与他相关的共有三个函数，分别是

dispatch_semaphore_create，dispatch_semaphore_signal，dispatch_semaphore_wait。

下面我们逐一介绍三个函数：

（1）dispatch_semaphore_create的声明为：

　　dispatch_semaphore_t  dispatch_semaphore_create(long value);

　　传入的参数为long，输出一个dispatch_semaphore_t类型且值为value的信号量。

　　值得注意的是，这里的传入的参数value必须大于或等于0，否则dispatch_semaphore_create会返回NULL。

　　（关于信号量，我就不在这里累述了，网上很多介绍这个的。我们这里主要讲一下dispatch_semaphore这三个函数的用法）。



（2）dispatch_semaphore_signal的声明为：

　　long dispatch_semaphore_signal(dispatch_semaphore_t dsema)

　　这个函数会使传入的信号量dsema的值加1；（至于返回值，待会儿再讲）



(3) dispatch_semaphore_wait的声明为：

　　long dispatch_semaphore_wait(dispatch_semaphore_t dsema, dispatch_time_t timeout)；

　　这个函数会使传入的信号量dsema的值减1；

　　这个函数的作用是这样的，如果dsema信号量的值大于0，该函数所处线程就继续执行下面的语句，并且将信号量的值减1；

　　如果desema的值为0，那么这个函数就阻塞当前线程等待timeout（注意timeout的类型为dispatch_time_t，

　　不能直接传入整形或float型数），如果等待的期间desema的值被dispatch_semaphore_signal函数加1了，

　　且该函数（即dispatch_semaphore_wait）所处线程获得了信号量，那么就继续向下执行并将信号量减1。

　　如果等待期间没有获取到信号量或者信号量的值一直为0，那么等到timeout时，其所处线程自动执行其后语句。

　　

（4）dispatch_semaphore_signal的返回值为long类型，当返回值为0时表示当前并没有线程等待其处理的信号量，其处理

　　的信号量的值加1即可。当返回值不为0时，表示其当前有（一个或多个）线程等待其处理的信号量，并且该函数唤醒了一

　　个等待的线程（当线程有优先级时，唤醒优先级最高的线程；否则随机唤醒）。

　　dispatch_semaphore_wait的返回值也为long型。当其返回0时表示在timeout之前，该函数所处的线程被成功唤醒。

　　当其返回不为0时，表示timeout发生。



（5）在设置timeout时，比较有用的两个宏：DISPATCH_TIME_NOW 和 DISPATCH_TIME_FOREVER。

　　DISPATCH_TIME_NOW　　表示当前；

　　DISPATCH_TIME_FOREVER　　表示遥远的未来；

　　一般可以直接设置timeout为这两个宏其中的一个，或者自己创建一个dispatch_time_t类型的变量。

　　创建dispatch_time_t类型的变量有两种方法，dispatch_time和dispatch_walltime。

　　利用创建dispatch_time创建dispatch_time_t类型变量的时候一般也会用到这两个变量。

　　dispatch_time的声明如下：

　　dispatch_time_t dispatch_time(dispatch_time_t when, int64_t delta)；

　　其参数when需传入一个dispatch_time_t类型的变量，和一个delta值。表示when加delta时间就是timeout的时间。

　　例如：dispatch_time_t  t = dispatch_time(DISPATCH_TIME_NOW, 1*1000*1000*1000);

　　　　　表示当前时间向后延时一秒为timeout的时间。



（6）关于信号量，一般可以用停车来比喻。

　　停车场剩余4个车位，那么即使同时来了四辆车也能停的下。如果此时来了五辆车，那么就有一辆需要等待。

　　信号量的值就相当于剩余车位的数目，dispatch_semaphore_wait函数就相当于来了一辆车，dispatch_semaphore_signal

　　就相当于走了一辆车。停车位的剩余数目在初始化的时候就已经指明了（dispatch_semaphore_create（long value）），

　　调用一次dispatch_semaphore_signal，剩余的车位就增加一个；调用一次dispatch_semaphore_wait剩余车位就减少一个；

　　当剩余车位为0时，再来车（即调用dispatch_semaphore_wait）就只能等待。有可能同时有几辆车等待一个停车位。有些车主

　　没有耐心，给自己设定了一段等待时间，这段时间内等不到停车位就走了，如果等到了就开进去停车。而有些车主就像把车停在这，

　　所以就一直等下去。
