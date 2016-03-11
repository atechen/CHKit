# CHKit

###1. NSTimer
1. ReleaseTarget：解决NSTimer强引用target，造成target和NSTimer无法释放的两种方案，
使用的时候，还需要在-(void)dealloc{}方法中，调用timer的invalidate()方法
	* HWWeakTimer来源于：[HWWeakTimer开源项目](https://github.com/ChatGame/HWWeakTimer)
	* NSTimer+AFSoundManager来自：[AFSoundManager开源项目](https://github.com/AlvaroFranco/AFSoundManager)
	
###2. TableView
1. MultiItemOnCell：在tableView的Cell上有多个且个数不定的元素。[思路来源-叶孤城](http://reviewcode.cn/article.html?reviewId=15&url_type=39&object_type=webpage&pos=1)，[代码](https://github.com/zangqilong198812/MultiButtonTutorial)