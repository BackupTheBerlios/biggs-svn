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

#import "PreferencesController.h"

@implementation PreferencesController

- (IBAction)addDirectory:(id)sender
{
	NSOpenPanel * panel = [[NSOpenPanel openPanel] retain];
	[panel setCanChooseFiles:NO];
	[panel setCanChooseDirectories:YES];
	[panel setCanCreateDirectories:YES];
	[panel setAllowsMultipleSelection:YES];
	
	[panel beginSheetForDirectory:nil file:nil types:nil modalForWindow:preferencesWindow modalDelegate:self didEndSelector:@selector(openPanelDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (void)openPanelDidEnd:(NSOpenPanel *)panel returnCode:(int)returnCode contextInfo:(void *)contextInfo
{
	if(returnCode == NSOKButton)
	{
		NSArray * paths = [panel filenames];
		NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
		NSString * tickPath = [[NSString alloc] init];
		int count = 0;
		
		if(tickPath = [thisBundle pathForResource:@"tick" ofType:@"png"])
		{
			for(count ; count < [paths count] ; count++)
			{
				Directory * newDirectory = [[Directory alloc] init];
				NSMutableDictionary * newProperties = [[NSMutableArray alloc] init];
			
				NSArray * keys   = [NSArray arrayWithObjects:
					@"enabled", @"Status", @"Path", @"Size", nil];
			
				NSArray * values = [NSArray arrayWithObjects:
					@"yes", [[NSImage alloc] initWithContentsOfFile:tickPath], [paths objectAtIndex:count], @"0", nil];
			
				newProperties = [[NSMutableDictionary alloc] initWithObjects: values forKeys: keys];
				[newDirectory setProperties:newProperties];
				[newDirectory syncInBackground:[files directoriesController]];
				[files addDirectory:newDirectory];
			
				[directoriesTable reloadData];
				[filesTable reloadData];
			}
		}
	}
	[panel release];
}
@end
