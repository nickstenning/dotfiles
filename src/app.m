#import <AppKit/NSWorkspace.h>
#import <Foundation/Foundation.h>
#import <stdio.h>

int lookupBundle(NSString *bundleId)
{
  NSString *path = [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:bundleId];

  if (path == NULL) {
    fprintf(stderr, "Application with bundle id '%s' not found!\n", [bundleId UTF8String]);
    return 1;
  }

  printf("%s\n", [path UTF8String]);
  return 0;
}

int main(int argc, const char *argv[])
{
  if (argc != 2) {
    fprintf(stderr, "Usage: app <bundleId>\n");
    fprintf(stderr, "\n");
    fprintf(stderr, "Prints the path to the application with the specified bundle identifier.\n");
    fprintf(stderr, "\n");
    fprintf(stderr, "  e.g. app com.apple.AddressBook\n");
    return 1;
  }

  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  NSString *bundleId = [NSString stringWithUTF8String:argv[1]];

  int retval = lookupBundle(bundleId);

  [pool release];
  return retval;
}
