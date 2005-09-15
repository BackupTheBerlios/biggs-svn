/* Copyright (C) 2005 Chris Blackburn

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This Copyright and License notice should remain in place at
all times.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA. */

#import "Directory.h"

@implementation Directory

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)theKey 
{
    bool automatic = true;
	
	if ([theKey isEqualToString:@"files"]) {
        automatic=NO;
    } else {
        automatic=[super automaticallyNotifiesObserversForKey:theKey];
    }
    return automatic;
}

- (id) init
{
	if (self = [super init])
	{
		NSArray * keys   = [NSArray arrayWithObjects:
			@"enabled", @"Status", @"Path", @"Size", nil];
		
		NSArray * values = [NSArray arrayWithObjects:
			@"yes", [[NSImage alloc] init], @"", @"0", nil];
		
		properties = [[NSMutableDictionary alloc]
      initWithObjects: values forKeys: keys];
	}     
	return self;
}

- (void) setProperties: (NSDictionary *)newProperties
{
    if (properties != newProperties)
    {
        [properties autorelease];
        properties = [[NSMutableDictionary alloc] initWithDictionary: newProperties];
    }
}

- (NSDictionary *)properties
{
	return properties;
}

- (void)syncInBackground:(NSArrayController *)filesController
{
	// For now threads are not working
	//[NSThread detachNewThreadSelector:@selector(syncInBackgroundImplementation:) toTarget:[self class] withObject:nil];
	[self syncInBackgroundImplementation:filesController];
}

- (void)syncInBackgroundImplementation:(id)anObject
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	if(anObject)
	{
		NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
		NSString * busyPath = [[NSString alloc] init];
		NSString * tickPath = [[NSString alloc] init];
		
		if((busyPath = [thisBundle pathForResource:@"busy" ofType:@"png"]) && (tickPath = [thisBundle pathForResource:@"tick" ofType:@"png"]))
		{
			NSMutableDictionary * newProperties = [[self properties] mutableCopy];
			int count = 0;
			
			// Set Our Status to Busy
			[newProperties setObject:[[NSImage alloc] initWithContentsOfFile:busyPath] forKey:@"Status"];
			[self setProperties:newProperties];
			
			// Populate the files Array with Filenames
			NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:[newProperties objectForKey:@"Path"]];
			NSString *pname;
			
			while (pname = [direnum nextObject]) 
			{
				if ([[pname pathExtension] isEqualToString:@"rtfd"])
				{
					[direnum skipDescendents]; /* don’t enumerate this directory */
				}
				else 
				{
					NSString * newPath = [[NSString alloc] init];
					
					if(![pname isAbsolutePath])
					{
						NSMutableString * tempString = [[NSMutableString alloc] init];
						
						[tempString appendString:[newProperties objectForKey:@"Path"]];
						[tempString appendString:@"/"];
						[tempString appendString:[pname lastPathComponent]];
						
						newPath = [tempString copy];
						[tempString release];
					}
					else
						newPath = pname;
					
					File * newFile = [[File alloc] init];
					NSMutableDictionary * newFileProperties = [[NSMutableDictionary alloc] init];
					
					NSArray * keys   = [NSArray arrayWithObjects:
						@"enabled", @"Status", @"Path", @"DisplayName", @"Size", @"MD5", nil];
					
					NSArray * values = [NSArray arrayWithObjects:
						@"yes", [[NSImage alloc] initWithContentsOfFile:busyPath], newPath, [newPath lastPathComponent], @"0", @"0", nil];
					
					newFileProperties = [[NSMutableDictionary alloc] initWithObjects: values forKeys: keys];
					[newFile setProperties:newFileProperties];
					
					[anObject willChange:NSKeyValueChangeInsertion valuesAtIndexes:[[NSIndexSet alloc] initWithIndex:[files count]] forKey:@"files"];
					//[files insertObject:newFile atIndex:[files count]];
					[files addObject:newFile];
					//[anObject addObject:newFile];
					[anObject didChange:NSKeyValueChangeInsertion valuesAtIndexes:[[NSIndexSet alloc] initWithIndex:[files count]] forKey:@"files"];
				}
			}
				
			for(count ; count <= [files count] ; count++)
			{

			}
			
			// Set Our Status to Done
			[newProperties setObject:[[NSImage alloc] initWithContentsOfFile:tickPath] forKey:@"Status"];
			[self setProperties:newProperties];
		}
	}
	
    [pool release];
}

- (NSMutableArray *)files
{
	return files;
}
@end
