//
//  ShobhaAsarDataBase.m
//  Shobha Asasr
//
//  Created by Ascra on 11/11/16.
//  Copyright © 2016 Ascra. All rights reserved.
//

#import "ShobhaAsarDataBase.h"
#import <sqlite3.h>

static sqlite3 *database = nil;
static sqlite3_stmt *addStmt = nil;
static sqlite3_stmt *detailStmt = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt * updatestmt = nil;

@implementation ShobhaAsarDataBase

+(void)getInitialDataToDisplay:(NSString *)dbpath
{
    
    if (sqlite3_open([dbpath UTF8String], &database)==SQLITE_OK)
    {
        const char*sql = "Select * from STYLE_MASTER";
        sqlite3_stmt * selectstmt;
        sqlite3_busy_timeout(database, 500);
        if (sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL)==SQLITE_OK)
        {
            while (sqlite3_step(selectstmt)== SQLITE_ROW)
            {
                
                NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
                
                ShobhaAsarDataBase * Obj = [[ShobhaAsarDataBase alloc] initWithPrimaryKey:primaryKey];
                NSLog(@"%@",Obj);
                sqlite3_busy_timeout(database, 500);
            }
        }
        
        sqlite3_finalize(selectstmt);
    }
    else sqlite3_close(database);
}

-(NSString *)filePath
{
    NSString *documentsDir=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    
    return [documentsDir stringByAppendingPathComponent:@"shobhaasarDB.sqlite"];
}


-(BOOL)openDB
{
    if(sqlite3_open([[self filePath]UTF8String],&database)!= SQLITE_OK)
    {
        sqlite3_close(database);
        return NO;
    }
    else
    {
        return YES;
    }
}
-(void)closeDB
{
    sqlite3_close(database);
    
}
-(id)initWithPrimaryKey:(NSInteger)pk
{
    self = [super init];
    if (self) {
       
    }
    return self;
    
}


+(void)finalizeStatements
{
    if (database)
    {
        sqlite3_close(database);
    }
    
}


-(void)addProduct_ids:(int)proid addProduct_name:(NSString *)name addProduct_pieces:(int)pieces addProduct_weight:(int)weight addProduct_dia_pcs:(int)dia_pcs addProduct_dia_wt:(int)dia_wt addProduct_cst_pcs:(int)cst_pcs addProduct_cst_wt:(int)cst_wt addProduct_image1:(NSString *)image1 addProduct_image2:(NSString *)image2 addProduct_image3:(NSString *)image3 addProduct_in_stock_status:(int)in_stock_status addProduct_collection_id:(int)collection_id addProduct_metal:(int)metal addProduct_karat:(int)karat addProduct_size:(int)size addProduct_quality:(int)quality addProduct_price:(int)price addProduct_quality_price:(int)quality_price  addProduct_category_id:(int)category_id addProduct_style_id:(NSString *)style_id addProduct_slash_no:(NSString *)slash_no addProduct_location_id:(NSString *)location_id addProduct_sub_category_id:(NSString *)sub_category_id addProduct_created_at:(NSString *)created_at addProduct_updated_at:(NSString *)updated_at
{
    int record_exists = 0;
    
    NSData *  imageData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:image1]];
    NSData *  imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:image2]];
    NSData *  imageData3 = [NSData dataWithContentsOfURL:[NSURL URLWithString:image3]];
    
    
    NSString *sqlStrrecord = [NSString stringWithFormat:@"select * from STYLE_MASTER where proid='%d'",proid];
    
    const char *sqlsqlRecord = [sqlStrrecord cStringUsingEncoding:NSUTF8StringEncoding];
    
    if(sqlite3_prepare_v2(database, sqlsqlRecord, -1, &detailStmt, NULL) != SQLITE_OK)
        
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
        record_exists=1;
        const char * sql = "delete from STYLE_MASTER where proid = ?";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"error while creating delete statement.'%s'", sqlite3_errmsg(database));
        }
        sqlite3_bind_int(deleteStmt, 1, proid);
        
        if (SQLITE_DONE!= sqlite3_step(deleteStmt))
            NSAssert1(0, @"errror while deleting.'%s'", sqlite3_errmsg(database));
    }
    const char *sql = "insert into STYLE_MASTER(proid,name,pieces,weight,dia_pcs,dia_wt,cst_pcs,cst_wt,image1,image2,image3,in_stock_status,collection_id,metal,karat,size,quality,price,quality_price,category_id,style_id,slash_no,location_id,sub_category_id,created_at,updated_at) Values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
        NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    
    
    sqlite3_bind_int(addStmt, 1, proid);
    sqlite3_bind_text(addStmt, 2, [name UTF8String], -1, SQLITE_STATIC);
    sqlite3_bind_int(addStmt, 3, pieces);
    sqlite3_bind_int(addStmt, 4, weight);
    sqlite3_bind_int(addStmt, 5, dia_pcs);
    sqlite3_bind_int(addStmt, 6, dia_wt);
    sqlite3_bind_int(addStmt, 7, cst_pcs);
    sqlite3_bind_int(addStmt, 8, cst_wt);
    
   
    sqlite3_bind_blob(addStmt, 9, [imageData1 bytes], (int)[imageData1 length], SQLITE_STATIC);
    sqlite3_bind_blob(addStmt, 10, [imageData2 bytes], (int)[imageData2 length], SQLITE_STATIC);
    sqlite3_bind_blob(addStmt, 11, [imageData3 bytes], (int)[imageData3 length], SQLITE_STATIC);
    
    sqlite3_bind_int(addStmt, 12, in_stock_status);
    sqlite3_bind_int(addStmt, 13, collection_id);
    sqlite3_bind_int(addStmt, 14, metal);
    
    sqlite3_bind_int(addStmt, 15, karat);
    sqlite3_bind_int(addStmt, 16, size);
    sqlite3_bind_int(addStmt, 17, price);
    
    sqlite3_bind_int(addStmt, 18, quality_price);
    sqlite3_bind_int(addStmt, 19, quality);
    sqlite3_bind_int(addStmt, 20, category_id);
    
    
    sqlite3_bind_text(addStmt, 21, [style_id UTF8String], -1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 22, [slash_no UTF8String], -1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 23, [location_id UTF8String], -1, SQLITE_STATIC);
  
    sqlite3_bind_text(addStmt, 24, [sub_category_id UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(addStmt, 25, [created_at UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_bind_text(addStmt, 26, [updated_at UTF8String], -1, SQLITE_TRANSIENT);
    
   
    
    if(SQLITE_DONE != sqlite3_step(addStmt))
        
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        proID = (int)sqlite3_last_insert_rowid(database);
    NSLog(@"----> %ld",(long)proID);
    
    sqlite3_reset(addStmt);

    
    
}

-(void)addCollection_coll_id:(int)coll_id addCollection_name:(NSString *)name addCollection_image:(NSString*)image addCollection_sequence:(int)sequence addCollection_image_pos:(NSString*)image_pos addCollection_is_new_collection:(NSString*)is_new_collection addCollection_section:(NSString*)section addCollection_background:(NSString*)background addCollection_collection_id:(int)collection_id addCollection_status:(int)status addCollection_created_at:(NSString*)created_at addCollection_updated_at:(NSString*)updated_at
{
    int record_exists = 0;
    
    NSData *  collImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
    NSString *sqlStrrecord = [NSString stringWithFormat:@"select * from COLLECTION_MASTER where coll_id='%d'",coll_id];
    
    const char *sqlsqlRecord = [sqlStrrecord cStringUsingEncoding:NSUTF8StringEncoding];
    
    if(sqlite3_prepare_v2(database, sqlsqlRecord, -1, &detailStmt, NULL) != SQLITE_OK)
        
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
        record_exists=1;
        const char * sql = "delete from COLLECTION_MASTER where coll_id = ?";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"error while creating delete statement.'%s'", sqlite3_errmsg(database));
        }
        sqlite3_bind_int(deleteStmt, 1, coll_id);
        
        if (SQLITE_DONE!= sqlite3_step(deleteStmt))
            NSAssert1(0, @"errror while deleting.'%s'", sqlite3_errmsg(database));
    }
    
   
    const char *sql = "insert into COLLECTION_MASTER(coll_id,name,image,sequence,image_pos,is_new_collection,section,background,collection_id,status,created_at,updated_at) Values(?,?,?,?,?,?,?,?,?,?,?,?)";
    
    if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
        NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    
    
    sqlite3_bind_int(addStmt, 1, coll_id);
    sqlite3_bind_text(addStmt, 2, [name UTF8String], -1, SQLITE_STATIC);
    sqlite3_bind_blob(addStmt, 3, [collImage bytes], (int)[collImage length], SQLITE_STATIC);
    sqlite3_bind_int(addStmt, 4, sequence);
    
    
    sqlite3_bind_text(addStmt, 5, [image_pos UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 6, [is_new_collection UTF8String],-1, SQLITE_STATIC);
     sqlite3_bind_text(addStmt, 7, [section UTF8String],-1, SQLITE_STATIC);
   
    sqlite3_bind_text(addStmt, 8, [background UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_int(addStmt, 9, collection_id);
    sqlite3_bind_int(addStmt, 10, status);
    sqlite3_bind_text(addStmt, 11, [created_at UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 12, [updated_at UTF8String],-1, SQLITE_STATIC);
    
    
    
    
    if(SQLITE_DONE != sqlite3_step(addStmt))
        
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        coll_id = (int)sqlite3_last_insert_rowid(database);
    NSLog(@"----> %ld",(long)coll_id);
    
    sqlite3_reset(addStmt);
    
    
    
}
-(void)addCategory_cat_id:(int)cat_id addCategory_name:(NSString*)name addCategory_image:(NSString*)image addCategory_sequence:(int)sequence addCategory_image_pos:(NSString*)image_pos addCategory_is_new_collection:(NSString*)is_new_collection addCategory_section:(NSString*)section addCategory_background:(NSString*)background addCategory_status:(int)status addCategory_parent_id:(NSString*)parent_id addCategory_category_id:(int)category_id addCategory_created_at:(NSString*)created_at addCategory_updated_at:(NSString*)updated_at
{
    int record_exists = 0;
    
    NSData *  catImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
    NSString *sqlStrrecord = [NSString stringWithFormat:@"select * from CATEGORY_MASTER where cat_id='%d'",cat_id];
    
    const char *sqlsqlRecord = [sqlStrrecord cStringUsingEncoding:NSUTF8StringEncoding];
    
    if(sqlite3_prepare_v2(database, sqlsqlRecord, -1, &detailStmt, NULL) != SQLITE_OK)
        
        NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
    
    while (sqlite3_step(detailStmt) == SQLITE_ROW)
    {
        record_exists=1;
        const char * sql = "delete from CATEGORY_MASTER where cat_id = ?";
        if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"error while creating delete statement.'%s'", sqlite3_errmsg(database));
        }
        sqlite3_bind_int(deleteStmt, 1, cat_id);
        
        if (SQLITE_DONE!= sqlite3_step(deleteStmt))
            NSAssert1(0, @"errror while deleting.'%s'", sqlite3_errmsg(database));
    }
    
   
    const char *sql = "insert into CATEGORY_MASTER(cat_id,name,image,sequence,image_pos,is_new_collection,section,background,status,parent_id,category_id,created_at,updated_at) Values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
        NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
    
    
    sqlite3_bind_int(addStmt, 1, cat_id);
    sqlite3_bind_text(addStmt, 2, [name UTF8String], -1, SQLITE_STATIC);
    sqlite3_bind_blob(addStmt, 3, [catImage bytes], (int)[catImage length], SQLITE_STATIC);
    sqlite3_bind_int(addStmt, 4, sequence);
    
    sqlite3_bind_text(addStmt, 5, [image_pos UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 6, [is_new_collection UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 7, [section UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 8, [background UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_int(addStmt, 9, status);
    
    sqlite3_bind_text(addStmt, 10, [parent_id UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_int(addStmt, 11, category_id );
    sqlite3_bind_text(addStmt, 12, [created_at UTF8String],-1, SQLITE_STATIC);
    sqlite3_bind_text(addStmt, 13, [updated_at UTF8String],-1, SQLITE_STATIC);
    
  
    
    
    if(SQLITE_DONE != sqlite3_step(addStmt))
        
        NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
    else
        cate_ID = (int)sqlite3_last_insert_rowid(database);
    NSLog(@"----> %ld",(long)cate_ID);
    
    sqlite3_reset(addStmt);
    
    
    
}
@end
