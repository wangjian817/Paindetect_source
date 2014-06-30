//
//  AllListView.m
//  Paindetect
//
//  Created by presenter CS on 12-7-26.
//  Copyright (c) 2012年 blisslogix. All rights reserved.
//

#import "AllListView.h"
#import "Database.h"

@interface AllListView ()

@end

@implementation AllListView


@synthesize keyArr;
@synthesize listData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSArray *array = [[NSArray alloc] initWithObjects:@"Tree",@"Flower",@"Grass",@"1",nil];
    //self.listData = array;
    
    Database *dataBase = [[Database alloc] init];
    [dataBase initWithSqliteOpen];
    self.listData = [dataBase getAllRecord];
    [dataBase initWithSqliteClose];
    
    keyArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.listData count]; i++) {
        NSMutableDictionary *revDict = [self.listData objectAtIndex:i];
        [self.keyArr addObject:[revDict valueForKey:@"pid"]];
    }

    
    
    NSLog(@"%@",self.keyArr);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.listData = nil;
    self.keyArr = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    //Return the number of sections.
    return [self.listData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSMutableDictionary *revDict = [self.listData objectAtIndex:section];
    return [revDict count]-2;
    //return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    NSInteger section = [indexPath section];
    
    NSMutableDictionary *dict = [self.listData objectAtIndex:section];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    switch (row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"受访者姓名 : %@",[dict valueForKey:k_PatientName]];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"性别 : %@",[dict valueForKey:k_OtherCondition]];
            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"年龄 : %@",[dict valueForKey:k_age]];
            break;
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"身份证号 : %@",[dict valueForKey:k_Subject_Id]];
            break;
        case 4:
            cell.textLabel.text = [NSString stringWithFormat:@"民族 : %@",[dict valueForKey:k_Nationality]];
            break;
        case 5:
            cell.textLabel.text = [NSString stringWithFormat:@"职业 : %@",[dict valueForKey:k_Occupation]];
            break;
        case 6:
            cell.textLabel.text = [NSString stringWithFormat:@"受访日期 : %@",[dict valueForKey:k_DateOfVisit]];
            break;
        case 7:
            cell.textLabel.text = [NSString stringWithFormat:@"联络方式 : %@",[dict valueForKey:k_ClinicalRecord]];
            break;
        case 8:
            cell.textLabel.text = [NSString stringWithFormat:@"目前服用何药，剂量及使用方法 : %@",[dict valueForKey:k_MedicationTakenNow]];
            break;
        case 9:
            cell.textLabel.text = [NSString stringWithFormat:@"接诊者: %@",[dict valueForKey:k_Center]];
            break;
        case 10:
            cell.textLabel.text = [NSString stringWithFormat:@"疼痛部位 : %@",[dict valueForKey:k_bodydetails]];
            break;
        case 11:
            if([[dict valueForKey:@"q2"] isEqualToString:@"0"]){
                cell.textLabel.text = @"疼痛发生时有否由该标示区向身体其他部位放射 : 否";
            }else{
                cell.textLabel.text = @"疼痛发生时有否由该标示区向身体其他部位放射 : 是";
            }
            break;
        case 12:
            cell.textLabel.text = [NSString stringWithFormat:@"目前您疼痛发作时的程度为 : %@",[dict valueForKey:@"q3"]];
            break;
        case 13:
            cell.textLabel.text = [NSString stringWithFormat:@"在过去4周中，疼痛发作最剧烈的一次程度为 : %@",[dict valueForKey:@"q4"]];
            break;
        case 14:
            cell.textLabel.text = [NSString stringWithFormat:@"在过去4周，平均的疼痛程度为 : %@",[dict valueForKey:@"q5"]];
            break;
        case 15:
            if ([[dict valueForKey:@"q6"] isEqualToString:@"0" ]) {
                cell.textLabel.text = [NSString stringWithFormat:@"以下何种疼痛发作模式与您的情况最相符 : %@",@"持续疼痛伴有轻微波动"];
            }
            if ([[dict valueForKey:@"q6"] isEqualToString:@"-1" ]) {
                cell.textLabel.text = [NSString stringWithFormat:@"以下何种疼痛发作模式与您的情况最相符 : %@",@"持续疼痛伴有发作剧痛（发作后恢复到原来水平）"];
            }
            if ([[dict valueForKey:@"q6"] isEqualToString:@"1" ]) {
                cell.textLabel.text = [NSString stringWithFormat:@"以下何种疼痛发作模式与您的情况最相符 : %@",@"反复疼痛发作－完全或部分缓解"];
            }
            break;
        case 16:
            cell.textLabel.text = [NSString stringWithFormat:@"在该标记区是否有烧灼感或麻刺感发生 : %@",[dict valueForKey:@"q7"]];
            break;
        case 17:
            cell.textLabel.text = [NSString stringWithFormat:@"在该标示区是否有麻痛（如蚁行感）或针刺痛（如电击样刺痛）发生 : %@",[dict valueForKey:@"q8"]];
            break;
        case 18:
            cell.textLabel.text = [NSString stringWithFormat:@"轻触该标示区皮肤（如穿衣时）即引起疼痛 : %@",[dict valueForKey:@"q9"]];
            break;
        case 19:
            cell.textLabel.text = [NSString stringWithFormat:@"过去在该标示区是否有突发雷击样疼痛发生 : %@",[dict valueForKey:@"q10"]];
            break;
        case 20:
            cell.textLabel.text = [NSString stringWithFormat:@"标示区偶尔接触冷水／热水可引起疼痛 : %@",[dict valueForKey:@"q11"]];
            break;
        case 21:
            cell.textLabel.text = [NSString stringWithFormat:@"过去在该标示区是否有麻木感 : %@",[dict valueForKey:@"q12"]];
            break;
        case 22:
            cell.textLabel.text = [NSString stringWithFormat:@"轻压该标示区皮肤即可触发疼痛 : %@",[dict valueForKey:@"q13"]];
            break;
        case 23:
            cell.textLabel.text = [NSString stringWithFormat:@"得分: %@",[dict valueForKey:@"score"]];
            break;
        default:
            cell.textLabel.text = @"";
            break;
    }
    //cell.textLabel.text = [NSString stringWithFormat:@"%d",row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     //<#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     
}*/
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *str = [NSString stringWithFormat:@"记录编号：%@",[self.keyArr objectAtIndex:section]];
    return str;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.keyArr;
}

@end
