//
//  SongTableViewCell.m
//  Musick
//
//  Created by Eddie Groberski on 2/14/15.
//  Copyright (c) 2015 Eddie Groberski. All rights reserved.
//

#import "SongTableViewCell.h"

@implementation SongTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    //Fix to make UITableViewCellStyleSubtitle work with dequeueReusableCellWithIdentifier in SongTableViewController
    return [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"songCellReuseId"];
}

@end
