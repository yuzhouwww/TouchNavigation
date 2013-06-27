TouchNavigation
===============

类似于网易新闻客户端里面可以滑动返回的导航控制器

![alt tag](https://dl.dropboxusercontent.com/u/95274982/%E7%85%A7%E7%89%87%2013-6-27%20%E4%B8%8B%E5%8D%886%2035%2004.png)

===============

使用方法类型于UIKIT中的UINavigationController

INIT:

TouchNavigationController *nav = [[[TouchNavigationController alloc] initWithRootViewController:vc] autorelease];

PUSH:

[self.touchNavigationController pushViewController:testViewController animated:YES];

POP:

[self.touchNavigationController popViewControllerAnimated:YES];

===============

注意：所有PUSH进来的ViewController都要继承于TouchViewController。

===============