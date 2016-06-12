# ios switch language inside app 
There are two ways switch language:
1、Kill APP After (Code in changeLanguage.m)
   *Synchronize user defaults "AppLanguages" 
   *exit(0) //This action will kill app, when reload app, language change by    launch app  
   
2、reload main bundle 
   * add NSBundle+language.h/NSBundle+language.h
   * reload bundle app inside, switch language


