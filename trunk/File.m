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

#import "File.h"

@implementation File

- (id) init
{
	if (self = [super init])
	{
		NSArray * keys   = [NSArray arrayWithObjects:
			@"enabled", @"Status", @"Path", @"DisplayName", @"Size", @"MD5", nil];
		
		NSArray * values = [NSArray arrayWithObjects:
			@"yes", [[NSImage alloc] init], @"", @"", @"0", @"0", nil];
		
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

@end
