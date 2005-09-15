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

#import "MainController.h"

@implementation MainController

- (IBAction)addNode:(id)sender
{
	NSIPAddress * address = [[NSIPAddress alloc] init];
	
	if ([address setIPFromString:[nodeAddress stringValue]] == false)
	{
		NSAlert *alert = [[[NSAlert alloc] init] autorelease];
		[alert addButtonWithTitle:@"OK"];
		[alert setMessageText:@"ERROR: You did not enter a valid IP Address"];
		[alert setInformativeText:@"You should enter an address in dot notation e.g. 123.123.123.123"];
		[alert setAlertStyle:NSWarningAlertStyle];
		
		[alert runModal];
	}
	else
	{
		Node * newNode = [[Node alloc] init];
		NSString * enabled = [[NSString alloc] init];
		
		if([nodeEnabled state] == NSOffState)
			enabled = @"";
		else if([nodeEnabled state] == NSOnState)
			enabled = @"yes";
		else // We should *never* get this far
		{
			NSAlert *alert = [[[NSAlert alloc] init] autorelease];
			[alert addButtonWithTitle:@"OK"];
			[alert setMessageText:@"ERROR: Internal Error Occoured"];
			[alert setInformativeText:@"I was not able to tell whether you enabled the new node or not! Please contact the author immediatley this should never happen."];
			[alert setAlertStyle:NSWarningAlertStyle];
			
			[alert runModal];
		}
		
		NSArray * keys   = [NSArray arrayWithObjects:
			@"enabled", @"IP", @"name", @"status", nil];
		
		NSArray * values = [NSArray arrayWithObjects:
			enabled, [nodeAddress stringValue], @"New Node", @"Offline",  nil];
		
		NSDictionary * newProperties = [[NSDictionary alloc]
            initWithObjects: values forKeys: keys];
		
		[newNode setProperties:newProperties];
		
		[nodes addNode:newNode];
		
		[nodeAddress setStringValue:@""];
		[nodeTable reloadData];
	}
}

- (IBAction)banNode:(id)sender
{
}

- (IBAction)toggleScan:(id)sender
{
	if([nodes toggleSharing:sender])
	{
		[scanSpinner startAnimation:sender];
		[sender setTitle:@"Stop"];
	}
	else
	{
		[scanSpinner stopAnimation:sender];
		[sender setTitle:@"Start"];
	}
}

@end
