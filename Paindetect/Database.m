
//  Database.m
//  Paindetect
//
//  Created by Jegan notebook3 Selvaraja on 24/04/12.
//  Copyright (c) 2012 blisslogix. All rights reserved.
//

#import "Database.h"

@implementation Database

@synthesize databasePath;

static sqlite3 *database;


-(id)initWithSqliteOpen {
    [self getDatabasePath];
    sqlite3_open([databasePath UTF8String], &database);
    return self;
}
-(id)initWithSqliteClose {
    sqlite3_close(database);
    return self;
}
-(void)getDatabasePath {
    
    // Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:@"PainDetect.sqlite"];
}

-(void)createDatabase {
    
    [self getDatabasePath];
    
    // Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
	
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
	
	// If the database already exists then return without doing anything
	if(success) return;
	
	// If not then proceed to copy the database from the application to the users filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"PainDetect.sqlite"];
	
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	
	//[fileManager release];
    
}

//getAllRecord
-(NSMutableArray *)getAllRecord{
    sqlite3_stmt *selectStatement = nil;
    NSMutableArray *preScoreArr = [[NSMutableArray alloc] init];
    if (selectStatement == nil) {
        const char *sql1 = "select * from PHistory order by patientid desc";
        if (sqlite3_prepare_v2( database, sql1, -1, &selectStatement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(selectStatement) == SQLITE_ROW) {
                NSLog(@"YES");
                NSMutableDictionary *locDict = [[NSMutableDictionary alloc] init];
                
                //[locDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_saveActivationcode] forKey:k_saveActivationcode];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)] forKey:@"pid"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)] forKey:k_Center];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)] forKey:k_Subject_Id];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)] forKey:k_DateOfVisit];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 4)] forKey:k_PatientName];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)] forKey:k_Nationality];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 6)] forKey:k_Occupation];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 7)] forKey:k_age];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 8)] forKey:k_ClinicalRecord];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 9)] forKey:k_MedicationTakenNow];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 10)] forKey:k_OtherCondition];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 11)] forKey:k_bodydetails];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 12)] forKey:@"q2"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 13)] forKey:@"q3"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 14)] forKey:@"q4"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 15)] forKey:@"q5"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 16)] forKey:@"q6"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 17)] forKey:@"q7"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 18)] forKey:@"q8"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 19)] forKey:@"q9"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 20)] forKey:@"q10"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 21)] forKey:@"q11"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 22)] forKey:@"q12"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 23)] forKey:@"q13"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 24)] forKey:@"score"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 24)] forKey:@"AlreadyUpload"];
                [preScoreArr addObject:locDict];
            }
        }
        sqlite3_reset(selectStatement);
    }
    return preScoreArr;
    
}

-(NSMutableArray *)getPreScore:(NSString *)strSubID{
    sqlite3_stmt *selectStatement = nil;
    NSMutableArray *preScoreArr = [[NSMutableArray alloc] init];
    if (selectStatement == nil) {
        const char *sql1 = "select * from PHistory where subjectid = ? order by patientid desc limit 5";
        if (sqlite3_prepare_v2( database, sql1, -1, &selectStatement, NULL) == SQLITE_OK) {
            
            sqlite3_bind_text(selectStatement,1,[strSubID UTF8String],-1,SQLITE_TRANSIENT);
            
            while (sqlite3_step(selectStatement) == SQLITE_ROW) {
                NSLog(@"YES");
                NSMutableDictionary *locDict = [[NSMutableDictionary alloc] init];
                
                [locDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_saveActivationcode] forKey:k_saveActivationcode];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)] forKey:@"pid"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)] forKey:k_Center];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)] forKey:k_Subject_Id];
                /*NSLog(@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)]);*/
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)] forKey:k_DateOfVisit];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 4)] forKey:k_PatientName];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)] forKey:k_Nationality];
                /*NSLog(@"%s",(char *)sqlite3_column_text(selectStatement, 7));
                 NSLog(@"%s",(char *)sqlite3_column_text(selectStatement, 8));
                 NSLog(@"%s",(char *)sqlite3_column_text(selectStatement, 9));                
                 NSLog(@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 6)]);*/
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 6)] forKey:k_Occupation];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 7)] forKey:k_age];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 8)] forKey:k_ClinicalRecord];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 9)] forKey:k_MedicationTakenNow];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 10)] forKey:k_OtherCondition];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 11)] forKey:k_bodydetails];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 12)] forKey:@"q2"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 13)] forKey:@"q3"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 14)] forKey:@"q4"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 15)] forKey:@"q5"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 16)] forKey:@"q6"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 17)] forKey:@"q7"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 18)] forKey:@"q8"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 19)] forKey:@"q9"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 20)] forKey:@"q10"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 21)] forKey:@"q11"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 22)] forKey:@"q12"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 23)] forKey:@"q13"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 24)] forKey:@"score"];
                [preScoreArr addObject:locDict];
            }
        }
        sqlite3_reset(selectStatement);
    }
    return preScoreArr;
}


-(void)updateUploadFlag:(NSString *)strpid{
    sqlite3_stmt *updatestmt1 = nil;
    if (updatestmt1 == nil) {
        const char *sql1 = "update PHistory set AlreadyUpload = 1 where patientid = ?";
        
        if (sqlite3_prepare_v2(database, sql1, -1, &updatestmt1, NULL) != SQLITE_OK) 
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    }
    
    //NSLog(@"pid:%@,%d",strpid,[strpid intValue]);
    
    sqlite3_bind_int(updatestmt1, 1, [strpid intValue]);
    
    
    if (SQLITE_DONE != sqlite3_step(updatestmt1)) {
        NSAssert1(0, @"Error while update data. '%s'", sqlite3_errmsg(database));
        
    }
    sqlite3_reset(updatestmt1);
    
}

-(NSString *)insertPDData:(NSMutableDictionary *)pdDict{
    int i;
    NSString *patientStr = [[NSString alloc] init];
    
    sqlite3_stmt *queryStmt1 = nil;
    if(queryStmt1 == nil) {
        const char *sql1 = "Select * from PHistory where subjectid = ? and dateofvisit = ?";
        
        if(sqlite3_prepare_v2(database, sql1, -1, &queryStmt1, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating queryStmt1. '%s'", sqlite3_errmsg(database));
    }
    
    sqlite3_bind_text(queryStmt1,1,[[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_Subject_Id]] UTF8String],-1,SQLITE_TRANSIENT);
    sqlite3_bind_text(queryStmt1,2,[[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_DateOfVisit]] UTF8String],-1,SQLITE_TRANSIENT);
    
    //NSLog(@"sid:%s,%s,%s",[[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_Subject_Id]] UTF8String],[[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_DateOfVisit]] UTF8String],[[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_Center]] UTF8String]);
    
    i=0;
    if (sqlite3_step(queryStmt1) == SQLITE_ROW) {
        patientStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(queryStmt1, 0)];
        i++;
    }else {
        //NSAssert1(0, @"query not find. '%s'", sqlite3_errmsg(database));
    }
    
    sqlite3_reset(queryStmt1);
    
    sqlite3_stmt *updateStmt1 = nil;
    if(i != 0){
        if(updateStmt1 == nil) {
            const char *sql2 = "update PHistory set center = ?, patientname = ?,nationality = ?, occupation = ?, age = ?, clinicalrecord = ?,medicationtaken = ?, othercondition = ?, bodydetails = ?, q2 = ?, q3 = ?, q4 = ?, q5 = ?, q6 = ?, q7 = ?, q8 = ?, q9 = ?, q10 = ?, q11 = ?, q12 = ?, q13 = ?, score = ?, AlreadyUpload = 0 where subjectid = ? AND dateofvisit = ?";
            
            if (sqlite3_prepare_v2(database, sql2, -1, &updateStmt1, NULL) != SQLITE_OK) 
                NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        }
        
        sqlite3_bind_text(updateStmt1, 1, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_Center]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 2, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_PatientName]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 3, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_Nationality]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 4, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_Occupation]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 5, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_age]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 6, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_ClinicalRecord]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 7, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_MedicationTakenNow]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 8, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_OtherCondition]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 9, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_bodydetails]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 10, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q2"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 11, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q3"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 12, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q4"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 13, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q5"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 14, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q6"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 15, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q7"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 16, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q8"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 17, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q9"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 18, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q10"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 19, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q11"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 20, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q12"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 21, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q13"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 22, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"score"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 23, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_Subject_Id]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 24, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_DateOfVisit]] UTF8String], -1, SQLITE_TRANSIENT);
        
        if(SQLITE_DONE != sqlite3_step(updateStmt1))
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
        
        sqlite3_reset(updateStmt1);
    }else {
        if(updateStmt1 == nil) {
            const char *sql3 = "insert into PHistory (center,subjectid,dateofvisit,patientname,nationality,occupation,age,clinicalrecord,medicationtaken,othercondition,bodydetails,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,score,AlreadyUpload) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,0)";
            
            if (sqlite3_prepare_v2(database, sql3, -1, &updateStmt1, NULL) != SQLITE_OK) 
                NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        }
        sqlite3_bind_text(updateStmt1, 1, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_Center]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 2, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_Subject_Id]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 3, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_DateOfVisit]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 4, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_PatientName]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 5, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_Nationality]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 6, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_Occupation]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 7, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_age]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 8, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_ClinicalRecord]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 9, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_MedicationTakenNow]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 10, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_OtherCondition]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 11, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:k_bodydetails]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 12, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q2"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 13, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q3"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 14, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q4"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 15, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q5"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 16, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q6"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 17, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q7"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 18, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q8"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 19, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q9"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 20, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q10"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 21, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q11"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 22, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q12"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 23, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"q13"]] UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt1, 24, [[NSString stringWithFormat:@"%@",[pdDict valueForKey:@"score"]] UTF8String], -1, SQLITE_TRANSIENT);
        
        if(SQLITE_DONE != sqlite3_step(updateStmt1))
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
        
        sqlite3_reset(updateStmt1);
        patientStr=[self getPatientStr];
    }
    
    return patientStr;
    
}

-(void)insertPatientHistory:(NSMutableDictionary *)patientDetailDict {
    sqlite3_stmt *addStmt1 = nil;
    if(addStmt1 == nil) {
        const char *sql1 = "insert into PatientHistory (center,subjectid,dateofvisit,patientname,nationality,occupation,age,clinicalrecord,medicationtaken,othercondition) values (?,?,?,?,?,?,?,?,?,?)";
        
        //        sqlite3 query For Create PatientHistory Procedure    //
        //        CREATE TABLE PatientHistory(patientid integer primary key autoincrement not null, center varchar(200), subjectid integer, dateofvisit varchar(150), patientname varchar(100),nationality varchar(100),occupation varchar(150),age varchar(50),clinicalrecord varchar(250),medicationtaken varchar(500),othercondition varchar(500));
        
        
        if(sqlite3_prepare_v2(database, sql1, -1, &addStmt1, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    }
    sqlite3_bind_text(addStmt1, 1, [[NSString stringWithFormat:@"%@",[patientDetailDict valueForKey:k_Center]] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt1, 2, [[NSString stringWithFormat:@"%@",[patientDetailDict valueForKey:k_Subject_Id]] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt1, 3, [[NSString stringWithFormat:@"%@",[patientDetailDict valueForKey:k_DateOfVisit]] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt1, 4, [[NSString stringWithFormat:@"%@",[patientDetailDict valueForKey:k_PatientName]] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt1, 5, [[NSString stringWithFormat:@"%@",[patientDetailDict valueForKey:k_Nationality]] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt1, 6, [[NSString stringWithFormat:@"%@",[patientDetailDict valueForKey:k_Occupation]] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt1, 7, [[NSString stringWithFormat:@"%@",[patientDetailDict valueForKey:k_age]] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt1, 8, [[NSString stringWithFormat:@"%@",[patientDetailDict valueForKey:k_ClinicalRecord]] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt1, 9, [[NSString stringWithFormat:@"%@",[patientDetailDict valueForKey:k_MedicationTakenNow]] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt1, 10, [[NSString stringWithFormat:@"%@",[patientDetailDict valueForKey:k_OtherCondition]] UTF8String], -1, SQLITE_TRANSIENT);
    
    //SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
    NSInteger primarykey = sqlite3_last_insert_rowid(database);
    NSNumber *numt = [NSDecimalNumber numberWithLongLong:sqlite3_last_insert_rowid(database)];
    
    NSLog(@"insert Patient History %d  %@",primarykey, numt);
    
    //    const char *sresult = "select patientid from PatientHistory";
    //    NSLog(@"%@",sresult);
    
    if(SQLITE_DONE != sqlite3_step(addStmt1))
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    
    sqlite3_reset(addStmt1);
    
}

-(void)insertbodydetails:(NSMutableDictionary *)bodydetailsdict
{
    sqlite3_stmt *addStmt1 = nil;
    if (addStmt1 == nil) {
        const char *sql1 = "insert into BodyDetails (patientid,bodydetails) values (?,?)";
        
        if (sqlite3_prepare_v2(database, sql1, -1, &addStmt1, NULL) != SQLITE_OK) 
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    }
    
    sqlite3_bind_text(addStmt1, 1, [[NSString stringWithFormat:@"%@",[bodydetailsdict valueForKey:k_patientid]] UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt1, 2, [[NSString stringWithFormat:@"%@",[bodydetailsdict valueForKey:k_bodydetails]] UTF8String], -1, SQLITE_TRANSIENT);
    
    NSInteger primarykey = sqlite3_last_insert_rowid(database);
    NSLog(@"the value is %d",primarykey);
    
    if (SQLITE_DONE != sqlite3_step(addStmt1)) {
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
        
    }
    sqlite3_reset(addStmt1);
}

-(void)insertanswerdetails:(NSMutableDictionary *)answerdetailsdict
{
    sqlite3_stmt *addStmtAnswer = nil;
    if (addStmtAnswer == nil) {
        const char *sqlanswer = "insert into AnswerDetails (painid,patientid,Answers) values (?,?,?)";
        
        //        CREATE TABLE AnswerDetails(painid varchar(100), patientid varchar(100), Answers varchar(500));
        if (sqlite3_prepare_v2(database, sqlanswer, -1, &addStmtAnswer, NULL) != SQLITE_OK) 
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        
    }
    sqlite3_bind_text(addStmtAnswer, 1, [[NSString stringWithFormat:@"%@",[answerdetailsdict valueForKey:k_painid]]UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmtAnswer, 2, [[NSString stringWithFormat:@"%@",[answerdetailsdict valueForKey:k_patientid]]UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmtAnswer, 3, [[NSString stringWithFormat:@"%@",[answerdetailsdict valueForKey:k_Answers]]UTF8String], -1, SQLITE_TRANSIENT);
    
    if (SQLITE_DONE != sqlite3_step(addStmtAnswer)) {
        NSAssert1(0, @"Error while inserting data. %s", sqlite3_errmsg(database));
    }
    
    sqlite3_reset(addStmtAnswer);
}



-(void)checkActivationCode:(NSString *)valueCode {
    sqlite3_stmt *selectStatement = nil;
    if (selectStatement == nil) {
        const char *sql1 = "Select * from ActivationCodeDetails where activationcode = ?";
        
        if (sqlite3_prepare_v2( database, sql1, -1, &selectStatement, NULL) == SQLITE_OK) {
            sqlite3_bind_text(selectStatement, 1, [[NSString stringWithFormat:@"%@",valueCode] UTF8String], -1, SQLITE_TRANSIENT);
            if (sqlite3_step(selectStatement) == SQLITE_ROW) {
                NSLog(@"YES");
            }
            else {
                NSLog(@"NO");
            }
        }
        sqlite3_reset(selectStatement);
    }   
}

-(BOOL)getActivationCodde:(NSString *)getVal {
    int val ;
    sqlite3_stmt *selectStatement = nil;
    if (selectStatement == nil) {
        const char *sql1 = "Select * from ActivationCodeDetails where activationcode = ?";
        
        if (sqlite3_prepare_v2( database, sql1, -1, &selectStatement, NULL) == SQLITE_OK) {
            sqlite3_bind_text(selectStatement, 1, [[NSString stringWithFormat:@"%@",getVal] UTF8String], -1, SQLITE_TRANSIENT);
            if (sqlite3_step(selectStatement) == SQLITE_ROW) {
                NSLog(@"YES");
                val = 1;
            }
            else {
                NSLog(@"NO");
                val = 0;
            }
        }
        sqlite3_reset(selectStatement);
    } 
    return val;
}

-(NSString *)getPatientStr {
    NSString *patientStr = [[NSString alloc] init];
    sqlite3_stmt *selectStatement = nil;
    if (selectStatement == nil) {
        //const char *sql1 = "select patientid from PatientHistory";
        const char *sql1 = "select patientid from PHistory";
        if (sqlite3_prepare_v2( database, sql1, -1, &selectStatement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(selectStatement) == SQLITE_ROW) {
                NSLog(@"YES");
                patientStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            }
            NSLog(@"patientStr  %@",patientStr);
        }
        sqlite3_reset(selectStatement);
    }
    return patientStr;
}

-(NSString *)getPainIDStr {
    NSString *painStr = [[NSString alloc] init];
    sqlite3_stmt *selectStatement = nil;
    if (selectStatement == nil) {
        const char *sql1 = "select painid from BodyDetails";
        if (sqlite3_prepare_v2( database, sql1, -1, &selectStatement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(selectStatement) == SQLITE_ROW) {
                NSLog(@"YES");
                painStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            }
            NSLog(@"Pain Str  %@",painStr);
        }
        sqlite3_reset(selectStatement);
    }
    return painStr;
}


-(void)insertActivationcode:(NSMutableArray *)activationcodeArray
{
    sqlite3_stmt *addStmt1= nil;
    if (addStmt1 == nil) {
        for (int i = 0; i < [activationcodeArray count]; i++) {
            const char *sql1 = "insert into ActivationCodeDetails (activationcode,activationid) values (?,?)";
            if (sqlite3_prepare_v2(database, sql1, -1, &addStmt1, NULL) != SQLITE_OK) {
                NSAssert1(0, @"error while creating add statement. '%s'", sqlite3_errmsg(database));
            }
            sqlite3_bind_text(addStmt1, 1, [[[activationcodeArray objectAtIndex:i] valueForKey:@"ActivitationCode"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(addStmt1, 2, [[[activationcodeArray objectAtIndex:i] valueForKey:@"ActivitationID"] intValue]);
            
            if (SQLITE_DONE != sqlite3_step(addStmt1)) {
                NSAssert1(0, @"Error while inserting data. %s", sqlite3_errmsg(database));
            }
        }
    }
    NSInteger primarykey = sqlite3_last_insert_rowid(database);
    NSLog(@"the value is %d",primarykey);
    sqlite3_reset(addStmt1);
}

-(void)deleteActivationcode
{
    NSLog(@"delete Table details");
    sqlite3_stmt *deleteStmt = nil;
    if (deleteStmt == nil) {
        const char *sql = "delete from ActivationCodeDetails";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
        
        if (SQLITE_DONE != sqlite3_step(deleteStmt))
            NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
        sqlite3_reset(deleteStmt);
    }
}

-(void)deletePatientHistory
{
    NSLog(@"delete Table details");
    sqlite3_stmt *deleteStmt = nil;
    if (deleteStmt == nil) {
        const char *sql = "delete from PatientHistory";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
        
        if (SQLITE_DONE != sqlite3_step(deleteStmt))
            NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
        sqlite3_reset(deleteStmt);
    }
}
-(void)deleteBodyDetails
{
    NSLog(@"delete Table details");
    sqlite3_stmt *deleteStmt = nil;
    if (deleteStmt == nil) {
        const char *sql = "delete from BodyDetails";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
        
        if (SQLITE_DONE != sqlite3_step(deleteStmt))
            NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
        sqlite3_reset(deleteStmt);
    }
}
-(void)deleteAnswerDetails
{
    NSLog(@"delete Table details");
    sqlite3_stmt *deleteStmt = nil;
    if (deleteStmt == nil) {
        const char *sql = "delete from AnswerDetails";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
        
        if (SQLITE_DONE != sqlite3_step(deleteStmt))
            NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
        sqlite3_reset(deleteStmt);
    }
}



-(void)updateActivationcode:(NSMutableArray *)activationcodeArray
{
    sqlite3_stmt *updatestmt1 = nil;
    if (updatestmt1 == nil) {
        for (int i = 0; i < [activationcodeArray count]; i++) {
            const char *sql1 = "update ActivationCodeDetails set activationcode = ?,activationid = ?";
            if (sqlite3_prepare_v2(database, sql1, -1, &updatestmt1, NULL) != SQLITE_OK) {
                NSAssert1(0, @"error while creating add statement. '%s'", sqlite3_errmsg(database));
            }
            sqlite3_bind_text(updatestmt1, 1, [[[activationcodeArray objectAtIndex:i] valueForKey:@"ActivitationCode"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(updatestmt1, 2, [[[activationcodeArray objectAtIndex:i] valueForKey:@"ActivitationID"] intValue]);
            
        }
        NSInteger primarykey = sqlite3_last_insert_rowid(database);
        NSLog(@"the value is %d",primarykey);
        
        if (SQLITE_DONE != sqlite3_step(updatestmt1)) {
            NSAssert1(0, @"Error while inserting data. %s", sqlite3_errmsg(database));
        }
        
    }
    sqlite3_reset(updatestmt1);
    
}

-(void)updateanswerdetails:(NSMutableDictionary *)answerdetailsdict andpainid:(NSString *)PainId andpatientid:(NSString *)patientid
{
    sqlite3_stmt *updatestmt1 = nil;
    if (updatestmt1 == nil) {
        
        const char *sql1 = "update AnswerDetails set Question2 = ?, Question3 = ?,Question4 = ?, Question5 = ?, Question6 = ?, Question7 = ?,Question8 = ?, Question9 = ?, Question10 = ?, Question11 = ?, Question12 = ?, Question13 = ? where painid = ? AND patientid = ?";
        
        if (sqlite3_prepare_v2(database, sql1, -1, &updatestmt1, NULL) != SQLITE_OK) 
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        
    }
    sqlite3_bind_int(updatestmt1, 1, [[NSString stringWithFormat:@"%d",[answerdetailsdict valueForKey:k_question2]]intValue]);
    sqlite3_bind_int(updatestmt1, 2, [[NSString stringWithFormat:@"%d",[answerdetailsdict valueForKey:k_question3]]intValue]);
    sqlite3_bind_int(updatestmt1, 3, [[NSString stringWithFormat:@"%d",[answerdetailsdict valueForKey:k_question4]]intValue]);
    sqlite3_bind_int(updatestmt1, 4, [[NSString stringWithFormat:@"%d",[answerdetailsdict valueForKey:k_question5]]intValue]);
    sqlite3_bind_int(updatestmt1, 5, [[NSString stringWithFormat:@"%d",[answerdetailsdict valueForKey:k_question6]]intValue]);
    sqlite3_bind_int(updatestmt1, 6, [[NSString stringWithFormat:@"%d",[answerdetailsdict valueForKey:k_question7]]intValue]);
    sqlite3_bind_int(updatestmt1, 7, [[NSString stringWithFormat:@"%d",[answerdetailsdict valueForKey:k_question8]]intValue]);
    sqlite3_bind_int(updatestmt1, 8, [[NSString stringWithFormat:@"%d",[answerdetailsdict valueForKey:k_question9]]intValue]);
    sqlite3_bind_int(updatestmt1, 9, [[NSString stringWithFormat:@"%d",[answerdetailsdict valueForKey:k_question10]]intValue]);
    sqlite3_bind_int(updatestmt1, 10, [[NSString stringWithFormat:@"%d",[answerdetailsdict valueForKey:k_question11]]intValue]);
    sqlite3_bind_int(updatestmt1, 11, [[NSString stringWithFormat:@"%d",[answerdetailsdict valueForKey:k_question12]]intValue]);
    sqlite3_bind_int(updatestmt1, 12, [[NSString stringWithFormat:@"%d",[answerdetailsdict valueForKey:k_question13]]intValue]);
    
    if (SQLITE_DONE != sqlite3_step(updatestmt1)) {
        NSAssert1(0, @"Error while inserting data. %s", sqlite3_errmsg(database));
    }
    
    sqlite3_reset(updatestmt1);
}

-(void)updatebodydetails:(NSMutableDictionary *)bodydetailsdict
{
    sqlite3_stmt *updatestmt1 = nil;
    if (updatestmt1 == nil) {
        const char *sql1 = "update BodyDetails set bodydetails = ? where painid = ? AND patientid = ?";
        
        if (sqlite3_prepare_v2(database, sql1, -1, &updatestmt1, NULL) != SQLITE_OK) 
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    }
    
    sqlite3_bind_int(updatestmt1, 1, [[NSString stringWithFormat:@"%d",[bodydetailsdict valueForKey:k_painid]]intValue]);
    sqlite3_bind_int(updatestmt1, 2, [[NSString stringWithFormat:@"%d",[bodydetailsdict valueForKey:k_patientid]]intValue]);
    sqlite3_bind_int(updatestmt1, 3, [[NSString stringWithFormat:@"%d",[bodydetailsdict valueForKey:k_bodydetails]]intValue]);
    
    
    if (SQLITE_DONE != sqlite3_step(updatestmt1)) {
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
        
    }
    sqlite3_reset(updatestmt1);
}


-(NSMutableArray *)getRerutrDataBaseValueInPatientHistory {
    sqlite3_stmt *selectStatement = nil;
    NSMutableArray *patientHistoryArr = [[NSMutableArray alloc] init];
    if (selectStatement == nil) {
        const char *sql1 = "select * from PHistory where AlreadyUpload = 0";
        if (sqlite3_prepare_v2( database, sql1, -1, &selectStatement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(selectStatement) == SQLITE_ROW) {
                NSLog(@"YES");
                NSMutableDictionary *locDict = [[NSMutableDictionary alloc] init];
                
                [locDict setValue:[[NSUserDefaults standardUserDefaults] valueForKey:k_saveActivationcode] forKey:k_saveActivationcode];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)] forKey:@"pid"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)] forKey:k_Center];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)] forKey:k_Subject_Id];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)] forKey:k_DateOfVisit];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 4)] forKey:k_PatientName];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)] forKey:k_Nationality];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 6)] forKey:k_Occupation];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 7)] forKey:k_age];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 8)] forKey:k_ClinicalRecord];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 9)] forKey:k_MedicationTakenNow];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 10)] forKey:k_OtherCondition];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 11)] forKey:k_bodydetails];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 12)] forKey:@"q2"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 13)] forKey:@"q3"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 14)] forKey:@"q4"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 15)] forKey:@"q5"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 16)] forKey:@"q6"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 17)] forKey:@"q7"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 18)] forKey:@"q8"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 19)] forKey:@"q9"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 20)] forKey:@"q10"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 21)] forKey:@"q11"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 22)] forKey:@"q12"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 23)] forKey:@"q13"];
                [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 24)] forKey:@"score"];
                [patientHistoryArr addObject:locDict];
            }
        }
        sqlite3_reset(selectStatement);
    }
    return patientHistoryArr;
}

/*-(NSMutableArray *)getRerutrDataBaseValueInPatientHistory {
 sqlite3_stmt *selectStatement = nil;
 NSMutableArray *patientHistoryArr = [[NSMutableArray alloc] init];
 if (selectStatement == nil) {
 const char *sql1 = "select * from PHistory";
 if (sqlite3_prepare_v2( database, sql1, -1, &selectStatement, NULL) == SQLITE_OK) {
 
 while (sqlite3_step(selectStatement) == SQLITE_ROW) {
 NSLog(@"YES");
 NSMutableDictionary *locDict = [[NSMutableDictionary alloc] init];
 
 [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)] forKey:k_Center];
 [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)] forKey:k_Subject_Id];
 [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)] forKey:k_DateOfVisit];
 [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 4)] forKey:k_PatientName];
 [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)] forKey:k_Nationality];
 [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 6)] forKey:k_Occupation];
 [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 7)] forKey:k_age];
 [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 8)] forKey:k_ClinicalRecord];
 [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 9)] forKey:k_MedicationTakenNow];
 [locDict setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 10)] forKey:k_OtherCondition];
 [patientHistoryArr addObject:locDict];
 }
 }
 sqlite3_reset(selectStatement);
 }
 return patientHistoryArr;
 }*/

-(NSMutableArray *)getRerutrDataBaseValueInBodyDetails {
    sqlite3_stmt *selectStatement = nil;
    NSMutableArray *painHistoryArr = [[NSMutableArray alloc] init];
    if (selectStatement == nil) {
        const char *sql1 = "select * from BodyDetails";
        if (sqlite3_prepare_v2( database, sql1, -1, &selectStatement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(selectStatement) == SQLITE_ROW) {
                NSLog(@"YES");
                NSMutableDictionary *painlocDict = [[NSMutableDictionary alloc] init];
                NSString *locStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
                locStr = [locStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                locStr = [locStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                locStr = [locStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
                locStr = [locStr stringByReplacingOccurrencesOfString:@")" withString:@""];
                
                
                [painlocDict setValue:(NSMutableArray *)locStr forKey:k_oflineBodyAnswer];
                [painHistoryArr addObject:painlocDict];
            }
        }
        sqlite3_reset(selectStatement);
    }
    return painHistoryArr;
}

-(NSMutableArray *)getRerutrDataBaseValueInAnswerDetails {
    sqlite3_stmt *selectStatement = nil;
    NSMutableArray *answerOutPutArr = [[NSMutableArray alloc] init];
    if (selectStatement == nil) {
        const char *sql1 = "select * from AnswerDetails;";
        if (sqlite3_prepare_v2( database, sql1, -1, &selectStatement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(selectStatement) == SQLITE_ROW) {
                NSLog(@"YES");
                NSMutableDictionary *answerlocDict = [[NSMutableDictionary alloc] init];
                
                NSString *locStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
                locStr = [locStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                locStr = [locStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                locStr = [locStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
                locStr = [locStr stringByReplacingOccurrencesOfString:@")" withString:@""];
                
                
                [answerlocDict setValue:(NSMutableArray *)locStr forKey:k_oflineQusAnsAnswer];
                [answerOutPutArr addObject:answerlocDict];
            }
        }
        sqlite3_reset(selectStatement);
    }
    return answerOutPutArr;
}

@end
