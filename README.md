# IIILocalizedIndex #
***
## Summary ##
IIILocalizedIndex is a simple **Objective-C** class to index a localized data source array, it constructs indexes for both alphabetic and ideographic languages like CJK. You can use it to create indexed table view with multi-language support, as the 'Contacts' app.

<img width=300 src="https://github.com/sehone/IIILocalizedIndex/raw/master/doc/screenshot.png"/>

This is still an init version, we need to add more supporting languages. So anyone who has knowledge in different languages is welcome to accomplish this class.

## Supporting languages ##
* `en` English
* `zh-Hans` Simplified Chinese

## Why need it ##
For alphabet based languages, it's easy to index an array and to get the common [A-Z] or localized index, `UILocalizedIndexedCollation` can do the job for you.

However, some languages are not based on alphabet (i.e. CJK), some based on ideographic writing system. It's kind of difficult to construct alphabetic index from ideographic characters. This is the case when you might need IIILocalizedIndex.


## How it works ##
Theoretically, if a language supports 'localizedCaseInsensitiveCompare', then there is a certain order for all characters in that language. If this order makes sense to users (i.e. alphabetic order, pronouncing order), then it's possible to find a group of delimiters to partition all those characters into sections, and to provide an title for each section (i.e. for English, the section titles are [A-Z]).

IIILocalizedIndex provides a group of delimiters for every supported language, and a group of corresponding section titles. These section titles could be any characters, you can set them as [A-Z], [0-9], or any localized characters, or whatever. 


## Limitations ##
* The precondition for IIILocalizedIndex is that the order for characters in that language is intelligible to users, and delimiters are obvious and reasonable for partitioning all characters.
  
  For example: There is a mapping relationship between [A-Z] alphabet and the pronunciation of Chinese characters, and it's evident to app users that the order of Chinese characters is *generally* based on pronunciation.
  
* *'Generally'* means not 100% based on that rule. There are few strange Chinese characters are not ordered based on pronunciation (They are so strange that you can think the pronunciation is a right rule). So another limitation is that order rule for a language should be consistent to users.


## How to use it ##
1. Add the IIILocalizedIndex folder to your project.
2. Invoke the `+ (NSDictionary *)indexed:(NSArray *)data` method to get a dictionary, use this dic to set data for table view.
3.  This method sends `description` message to items in data array. So if items are objects of custom classes, remember to implement your own `description` method for getting index.

## Requirements ##
IIILocalizedIndex uses ARC. If you are not using ARC in your project, add `'-fobjc-arc'` as a compiler flag for all the files in IIILocalizedIndex.

## Licenses ##
All source code is licensed under the [MIT License][3]
[3]: https://raw.github.com/sehone/IIILocalizedIndex/master/LICENSE.md