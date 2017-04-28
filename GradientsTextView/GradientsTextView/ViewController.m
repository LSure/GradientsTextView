//
//  ViewController.m
//  GradientsTextView
//
//  Created by 刘硕 on 2017/4/27.
//  Copyright © 2017年 刘硕. All rights reserved.
//

#import "ViewController.h"
#import "GradientsTextView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    CGFloat width = self.view.bounds.size.height / 2;
    GradientsTextView *gradientsView = [[GradientsTextView alloc]initWithFrame:CGRectMake(0, 0, width, width)];
    gradientsView.center = self.view.center;
    gradientsView.textView.text = @"中共中央总书记习近平在主持学习时强调，金融安全是国家安全的重要组成部分，是经济平稳健康发展的重要基础。维护金融安全，是关系我国经济社会发展全局的一件带有战略性、根本性的大事。金融活，经济活；金融稳，经济稳。必须充分认识金融在经济发展和社会生活中的重要地位和作用，切实把维护金融安全作为治国理政的一件大事，扎扎实实把金融工作做好。这次中央政治局集体学习，由有关负责同志结合各自业务领域和工作实际介绍情况。中国人民银行行长周小川就加强宏观调控、保障金融安全，中国银监会主席郭树清就化解银行体系风险、维护金融稳定，中国证监会主席刘士余就资本市场发展与风险管理，中国保监会副主席陈文辉就回归风险保障、强化保险监督、守住维护金融安全底线谈了认识和体会。中央政治局各位同志听取了他们的发言，并就有关问题进行了讨论。";
    gradientsView.textView.editable = NO;
    [self.view addSubview:gradientsView];
    gradientsView.textView.font = [UIFont systemFontOfSize:23];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
