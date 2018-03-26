//
//  ViewController.m
//  UITextView禁止输入表情
//
//  Created by HanYong on 2018/3/22.
//  Copyright © 2018年 HanYong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 100)];
    textView.delegate = self;
    textView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    textView.layer.borderWidth = 0.5f;
    textView.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:textView];
    
}

-(void)textViewDidChange:(UITextView *)textView{
    NSRange textRange = [textView selectedRange];
    NSString *text = [self disable_emoji:[textView text]];
    [textView setText:text];
    [textView setSelectedRange:textRange];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    //禁止苹果系统输入表情
    if ([[UITextInputMode currentInputMode].primaryLanguage isEqualToString:@"emoji"]) {
        return NO;
    }
    
    return YES;
}

//使用正则表达式 - 将表情字符串替换为""
- (NSString *)disable_emoji:(NSString *)text{
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
