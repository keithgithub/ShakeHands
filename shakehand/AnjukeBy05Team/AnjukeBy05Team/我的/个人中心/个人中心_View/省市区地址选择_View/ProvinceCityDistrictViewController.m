//
//  ProvinceCityDistrictViewController.m
//  AnjukeBy05Team
//
//  Created by etcxm on 16/6/21.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "ProvinceCityDistrictViewController.h"

@interface ProvinceCityDistrictViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray *_listProvinceArry;
    
}


@end

@implementation ProvinceCityDistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    UIPickerView *pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, theHeight*0.6, theWidth,theHeight*0.4)];
    pickView.dataSource = self; //数据源
    pickView.delegate = self; //委托
    pickView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:pickView];
    
    //    plist文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"provincesData" ofType:@"plist"];
    
    _listProvinceArry = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"_listArry = %@",_listProvinceArry);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark   UIPickerViewDataSource,UIPickerViewDelegate

//返回列数
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 3;
}

//返回行数
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if (component == 0) {
        
        return _listProvinceArry.count;//省的个数
        
    } else if (component == 1) {
        
        NSInteger firstSelectRow = [pickerView selectedRowInComponent:0]; //获取的第一列选中的省份
        
        NSDictionary *provincesDic = [_listProvinceArry objectAtIndex:firstSelectRow];//获取省的数据
        
        NSArray *theCityArry =  [provincesDic objectForKey:@"name"];//获取市的数据
        
        return theCityArry.count;
        
    } else {
    
        NSInteger firstSelectRow = [pickerView selectedRowInComponent:1]; //获取的第二列选中的城市
        
        NSDictionary *citiesDic = [_listProvinceArry objectAtIndex:firstSelectRow];//获取区的数据
        
        NSArray *theDistrictsArry =  [citiesDic objectForKey:@"name"];//获取区的数据
        
        return theDistrictsArry.count;
    
    }
    
}


//返回行的内容（系统自带的）
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //   component 列数
    //    row  行数
    
    if (component == 0) { // 获取省份的数据
        
        NSDictionary *provincesDic = [_listProvinceArry objectAtIndex:row];
        return [provincesDic objectForKey:@"name"];
        
    } else if (component == 1) {
  
        NSInteger firstSelectRow = [pickerView selectedRowInComponent:0]; //获取的第一列选中的省份
        
        NSDictionary *provincesDic = [_listProvinceArry objectAtIndex:firstSelectRow];//获取省的数据
        
        NSArray *theCityArry =  [provincesDic objectForKey:@"name"];//获取市的数据
        
        if (row < theCityArry.count) {
            
            return [theCityArry objectAtIndex:row];
            
        }else
        {
            return @"";
        }

        
    } else {
        
        NSInteger firstSelectRow = [pickerView selectedRowInComponent:1]; //获取的第二列选中的城市
        
        NSDictionary *citiesDic = [_listProvinceArry objectAtIndex:firstSelectRow];//获取区的数据
        
        NSArray *theDistrictsArry =  [citiesDic objectForKey:@"name"];//获取区的数据
        
        if (row < theDistrictsArry.count) {
            
            return [theDistrictsArry objectAtIndex:row];
            
        }else
        {
            return @"";
        }
        
    }
    
    
}

////自定义
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
//{
//    if (component == 0) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
//        view.backgroundColor = [UIColor redColor];
////        add label.....
//        return view;
//    }else
//    {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
//        view.backgroundColor = [UIColor greenColor];
////        add label  image.....
//        return view;
//    }
//}


//选中的事件
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) { //这是第一列
        
    //  reloadAllComponents 刷新所有的列
    //  reloadComponent  刷新指定的列
        
        [pickerView reloadComponent:1];
        
    //  让第二列 回到 第一行
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
    } else if (component == 1) { //这是第二列
    
        [pickerView reloadComponent:2];
        
    //  让第三列 回到 第一行
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
    }
}

//列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED;
{

    return theWidth*0.3;
    
}

//行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED;
{
    return 20;
}


@end
