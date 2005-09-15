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

#import "ErrorLookup.h"

@implementation ErrorLookup

- (bool) load 
{
	NSString *xmlPath;
	NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
	bool returnvalue = false;
	
	if (xmlPath = [thisBundle pathForResource:@"error" ofType:@"xml"])
	{
		if ([errorTable initWithContentsOfFile:xmlPath])
		{
			returnvalue = true;
		}
		else
		{
			[self loadError];
			returnvalue = false;
		}
	}
	else
	{
		[self loadError];
		returnvalue = false;
	}
	
	loaded = returnvalue;
	
	return returnvalue;
}

- (void) loadError
{
	NSAlert *alert = [[[NSAlert alloc] init] autorelease];
	[alert addButtonWithTitle:@"OK"];
	[alert setMessageText:@"ERROR: Could not load Error Number Database"];
	[alert setInformativeText:@"I could not load the database that translates error codes into readable messages, only error codes will be visible"];
	[alert setAlertStyle:NSWarningAlertStyle];
	
	//[alert beginSheetModalForWindow:[MainController window] modalDelegate:self didEndSelector:nil contextInfo:nil];
	[alert runModal];
	
}

- (NSString *) lookup:(int)errorCode
{
	NSString *string = [[[NSString alloc] init] autorelease];
	
	if(string = [errorTable objectForKey:(id)errorCode])
		return string;
	else
		return [NSString stringWithString:@""];
}

@end
