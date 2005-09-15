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

#import "NSIPAddress.h"

@implementation NSIPAddress

- (bool) setIPFromString:(NSString *)address
{
	int count = 0;
	NSArray * splitAddress = [address componentsSeparatedByString:@"."];
	bool success = true;
	
	for (count; count < 4 ; count++)
	{
		IPbyte[count] /*int temp*/ = [[splitAddress objectAtIndex:count] intValue];
		//NSLog([[splitAddress objectAtIndex:count] stringValue]);
		if (IPbyte[count] < 1 || IPbyte[count] > 255)
		{
			NSScanner * scanner = [NSScanner scannerWithString:[splitAddress objectAtIndex:count]];
			
			if(IPbyte[count] == 0 && [scanner scanInt:nil])
			{
				success = true;
			}
			else
			{
				success = false;
				break;	
			}
		}
	}
	
	return success;
}

- (bool) setNetmaskFromString:(NSString *)address
{
	int count = 0;
	NSArray * splitAddress = [address componentsSeparatedByString:@"."];
	bool success = true;
	
	for (count; count < 4 ; count++)
	{
		NMbyte[count]  = [[splitAddress objectAtIndex:count] intValue];

		if (IPbyte[count] < 1 || IPbyte[count] > 255)
		{
			NSScanner * scanner = [NSScanner scannerWithString:[splitAddress objectAtIndex:count]];
			
			if(IPbyte[count] == 0 && [scanner scanInt:nil])
			{
				success = true;
			}
			else
			{
				success = false;
				break;	
			}
		}
	}
	
	return success;
}

@end
