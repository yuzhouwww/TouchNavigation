TouchNavigation
===============

类似于网易新闻客户端里面可以滑动返回的导航控制器

兼容iOS 5.1及以后，iOS5.1之前没有测试

![alt tag](https://dl.dropboxusercontent.com/u/95274982/%E7%85%A7%E7%89%87%2013-6-27%20%E4%B8%8B%E5%8D%886%2035%2004.png)

===============

使用方法类型于UIKIT中的UINavigationController

INIT:

TouchNavigationController *nav = [[[TouchNavigationController alloc] initWithRootViewController:vc] autorelease];

PUSH:

[self.touchNavigationController pushViewController:testViewController animated:YES];

POP:

[self.touchNavigationController popViewControllerAnimated:YES];

以及：
- (void)popToViewController:(TouchViewController *)viewController animated:(BOOL)animated;
- (void)popToRootViewControllerAnimated:(BOOL)animated;

===============

注意：所有PUSH进来的ViewController都要继承于TouchViewController。

===============