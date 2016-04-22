# CHKit

###NSTimer
1. ReleaseTarget：解决NSTimer强引用target，造成target和NSTimer无法释放的两种方案，
使用的时候，还需要在-(void)dealloc{}方法中，调用timer的invalidate()方法
	* HWWeakTimer来源于：[HWWeakTimer开源项目](https://github.com/ChatGame/HWWeakTimer)
	* NSTimer+AFSoundManager来自：[AFSoundManager开源项目](https://github.com/AlvaroFranco/AFSoundManager)
	
###TableView
1. MultiItemOnCell：在tableView的Cell上有多个且个数不定的元素。[思路来源-叶孤城](http://reviewcode.cn/article.html?reviewId=15&url_type=39&object_type=webpage&pos=1)，[代码](https://github.com/zangqilong198812/MultiButtonTutorial)
2. DynamicCellHeight：动态计算行高的三种解决方案
	* iOS8才支持的SelfSize解决方案
	* 使用iOS7的估算机制 + Cell绑定数据同时计算行高
	* 使用AutoLayout + 模板cell计算行高
	* UITableView-FDTemplateLayoutCell：[GitHub](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)--[Blog](http://blog.sunnyxx.com/2015/05/17/cell-height-calculation/)
3. `header和footer使用在iOS6使用Masonry崩溃（未实现）`
	
###UINavigation
1. 全屏手势返回的实现（仅支持iOS7及以上）
	* FullScreenBackNavigation：使用系统返回实现，但替换系统的返回手势，在ViewController中处理NavigationBar的隐藏/显示
	* UINavigationController+FDFullscreenPopGesture：使用系统返回实现，替换系统的返回手势，同时封装NavigationBar的隐藏/显示  [GitHub](https://github.com/forkingdog/FDFullscreenPopGesture)--[Blog](http://blog.sunnyxx.com/2015/06/07/fullscreen-pop-gesture/)
	* CustomTransitionNavigation：不使用系统的返回实现，通过自定义转场动画实现  [GitHub](https://github.com/zys456465111/CustomPopAnimation)--[Blog](http://www.jianshu.com/p/d39f7d22db6c)
2. EdgeScreenBackNavigation：解决使用leftBarButtonItem属性时，导致的边缘返回手势失效

`***以下功能后续添加***`

###UIScrollView
1. 多图轮播
	* HYBLoopScrollView(3.1.2)
	* CHViewPager

###ImagePickerViewController
1. 自定义照片选择界面
2. 在照片选择界面插入相机按钮

###UITextFild和UITextView
1. 占位文字，自定义位置
2. 点击出现下拉列表
3. 限制输入字数
4. 键盘管理

###UITableViewCell
1. 滑动出现菜单
2. 点击出现抽屉