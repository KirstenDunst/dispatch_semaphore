//
//  ViewController.m
//  text
//
//  Created by CSX on 2017/1/22.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "ViewController.h"
#import "AMToolHttp.h"
#import "AskModel.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self textOne];
//    [self textTwo];
//    [self textThree];
//    [self test];
    
    
    UIButton *myCreateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCreateButton.frame = CGRectMake(0, 0, 100, 100);
    [myCreateButton setBackgroundColor:[UIColor grayColor]];
    [myCreateButton setTitle:@"ASKChoose" forState:UIControlStateNormal];
    [myCreateButton addTarget:self action:@selector(buttonChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myCreateButton];
    
    
}

- (void)buttonChoose:(UIButton *)sender{
    
    
    [self AskRequest];
    
}





- (void)AskRequest{
    
    
    NSLog(@"开始加载请求");
    
    [AMToolHttp GET:[NSString stringWithFormat:@"http://service.zongs365.net/zongsheng/home/get_home_route_machine_list.do?manager_id=100094&route_id="] parameters:nil progress:^(id downloadProgress) {
        
    } success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        NSMutableArray *dataArr = [NSMutableArray array];
        
        NSArray *arr = responseObject[@"routeList"];
        
        for (NSDictionary *temdoDic in arr) {
            
            AskModel *model = [[AskModel alloc]initWithDictory:temdoDic];
            [dataArr addObject:model];
            
        }
        
        for (AskModel *model in dataArr) {
            
            NSLog(@"%@",model.routeName);
            
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
        
    }];
    
    
}





- (void)textOne{
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //限制每次只有一个分线程
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int index = 0; index < 1000; index++) {
        
        dispatch_async(queue, ^(){
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//时间等待机制
            
            NSLog(@"addd :%d", index);
            
            sleep(1);
            
            [array addObject:[NSNumber numberWithInt:index]];
            
            dispatch_semaphore_signal(semaphore);
            
        });
        
    }
    

}

- (void)textTwo{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    for (int i = 0; i < 1000; i++)
    {
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_group_async(group, queue, ^{
            NSLog(@"%i",i);
            sleep(2);
            dispatch_semaphore_signal(semaphore);
        });
    }
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
}

- (void)textThree{
    
    for (int i = 0; i<1000; i++) {
        
        sleep(1);
        NSLog(@"%i",i);
        
    }
    
}


- (void)test
{
    dispatch_queue_t aDQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    // Add a task to the group
    dispatch_group_async(group, aDQueue, ^{
        sleep(2);
        printf("task 1 \n");
    });
    dispatch_group_async(group, aDQueue, ^{
        printf("task 2 \n");
    });
    dispatch_group_async(group, aDQueue, ^{
        printf("task 3 \n");
    });
    printf("wait 1 2 3 \n");
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    printf("task 1 2 3 finished \n");
 
    group = dispatch_group_create();
    // Add a task to the group
    dispatch_group_async(group, aDQueue, ^{
        sleep(2);
        printf("task 4 \n");
        
    });
    dispatch_group_async(group, aDQueue, ^{
        printf("task 5 \n");
    });
    dispatch_group_async(group, aDQueue, ^{
        printf("task 6 \n");
    });
    printf("wait 4 5 6 \n");
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    printf("task 4 5 6 finished \n");
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
