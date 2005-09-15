/* MainController */
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

#import <Cocoa/Cocoa.h>

#include "ErrorLookup.h"
#include "Nodes.h"
#import "Node.h"
#include "NSIPAddress.h"

@interface MainController : NSObject
{
    IBOutlet id files;
    IBOutlet NSTextField *nodeAddress;
    IBOutlet NSButton *nodeEnabled;
    IBOutlet id nodes;
    IBOutlet NSTableView *nodeTable;
    IBOutlet NSProgressIndicator *scanSpinner;
    IBOutlet NSButton *toggleButton;
    IBOutlet id window;
}
- (IBAction)addNode:(id)sender;
- (IBAction)banNode:(id)sender;
- (IBAction)toggleScan:(id)sender;
@end
