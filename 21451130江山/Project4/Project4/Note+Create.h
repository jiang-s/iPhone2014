//
//  Note+Create.h
//  Project4
//
//  Created by 江山 on 1/7/15.
//  Copyright (c) 2015 jiangshan. All rights reserved.
//

#import "Note.h"

@interface Note (Create)

+ (Note *)NoteWithTitle:(NSString *)title andContent:(NSString *)content
 inManagedObjectContext:(NSManagedObjectContext *)context;

@end
