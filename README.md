TouchNavigation
===============

类似于网易新闻客户端的可以滑动返回的导航控制器

===============

使用方法类型于UIKIT中的UINavgationController

INIT:

TouchNavigationController *nav = [[[TouchNavigationController alloc] initWithRootViewController:vc] autorelease];

PUSH:

[self.touchNavigationController pushViewController:testViewController animated:YES];

POP:

[self.touchNavigationController popViewControllerAnimated:YES];

注意：所有PUSH进来的ViewController都要继承于TouchViewController。