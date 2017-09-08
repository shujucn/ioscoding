# WKWebView load local file

```
-(void)loadLocalFile:(NSString *)fileName {
    NSString *html = [[NSBundle mainBundle] pathForResource:fileName ofType:@"html"];
    //load css
//    NSString *css = [[NSBundle mainBundle] pathForResource:fileName ofType:@"css"];
    //load picture
//    NSString *picture = [[NSBundle mainBundle] pathForResource:fileName ofType:@"jpg"];
    if(html){
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
            // iOS9.
            // This way is same as below
            NSURL *fileURL = [NSURL fileURLWithPath:html];
            [self loadFileURL:fileURL allowingReadAccessToURL:fileURL];
           
            // This way can also load file
            //            NSString * htmlCont = [NSString stringWithContentsOfFile:html
            //                                                                                       encoding:NSUTF8StringEncoding
            //                                                                                          error:nil];
            //            [self loadHTMLString:htmlCont baseURL:[NSBundle mainBundle].resourceURL];
        } else {
            // iOS8
            NSURL *fileURL = [NSURL fileURLWithPath:html];
            NSError *error = nil;
            // Create "/temp/www" directory
            NSFileManager *fileManager= [NSFileManager defaultManager];
            NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
            [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
            
            NSURL *rscURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
            // Now copy given file to the temp directory
            [fileManager removeItemAtURL:rscURL error:&error];
            [fileManager copyItemAtURL:fileURL toURL:rscURL error:&error];
            
            NSURLRequest *request = [NSURLRequest requestWithURL:rscURL];
            [self loadRequest:request];
        }
    }
}
```


