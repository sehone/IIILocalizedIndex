# IIILocalizedIndex #
***
## 简介 ##
IIILocalizedIndex是一个为数组创建索引的 Objective-C 类. 它同时支持字母语言与字符语言, 比如中文,日语,韩语. 你可以用它来创建支持索引的 table view, 就像苹果的'通讯录'应用.

<img width=300 src="https://github.com/sehone/IIILocalizedIndex/raw/master/doc/screenshot.png"/>

这还只是一个初始版本, 还需要加入更多的支持语言. 因此, 欢迎更多有不同语言知识的人加入进来, 一起完善这个类.

## 支持语言 ##
* `en` English
* `zh-Hans` 简体中文

## 为何需要它 ##
基于字母的语言相对容易建立索引, 包括通用的[A-Z]索引以及本地化的索引, 使用`UILocalizedIndexedCollation`就可以实现.

但是有些语言不是基于字母的 (比如汉语日语韩语), 有些是基于字符系统的, 为这一类语言建立索引则有些困难. 这种情况下, 你就可以使用 IIILocalizedIndex.


## 原理 ##
理论上, 如果一门语言支持 'localizedCaseInsensitiveCompare' 方法, 那这门语言中的字符就存在一个特定的排列顺序. 如果这个顺序对于用户来说是有意义和易懂的 (比如字母表顺序, 发音顺序), 就有可能找到一组分隔符, 来将这门语言中的所有字符进行区间划分, 并为每一个区间提供一个标题 (比如, 英文的区间标题就是[A-Z]这26个字母).

IIILocalizedIndex 为每一种支持的语言提供了这样一组分隔符, 以及跟每个分割区间对应的标题. 这些标题可以是任意字符, 你可以设为[A-Z]字母, 或者[0-9]数字, 或者本地化的字符, 随便什么内容都可以.

## 局限性 ##
* IIILocalizedIndex 的一个工作前提就是该语言中所有字符的排列顺序对于用户是有意义的, 并且分隔符是有说服力且易懂的.
  
  例如: 对于汉语字符, 就存在[A-Z]字母表和汉字发音之间的对应关系, 而且对于app用户而言, 汉语字符顺序*基本上*是基于发音的.
  
* '*基本上*'意味着并不是100%遵从这条规则. 有些生僻汉字不是基于发音 (这些汉字如此生僻, 以至于你可以认为发音就是正确的排序规则). 因此我们看到了另外一个局限性: 字符排列顺序规则在用户看来应该是一致的有规律可循的.


## 如何使用 ##
1. 将 IIILocalizedIndex 文件夹加入到项目中.
2. 调用 `+ (NSDictionary *)indexed:(NSArray *)data` 方法获取索引后的dictionary, 用这个dictionary来构建table view.
3. 该方法会向数组中的元素发送 `description` 消息, 因此, 如果数组元素是一些定制类的实例, 你应该实现自己的 `description` 方法.

## 要求 ##
IIILocalizedIndex 使用了 ARC. 如果项目没有使用ARC, 请为IIILocalizedIndex的文件添加 `'-fobjc-arc'` 编译标签.

## 许可 ##
所有代码遵循 [MIT 许可][3]
[3]: https://raw.github.com/sehone/IIILocalizedIndex/master/LICENSE.md