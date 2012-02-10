//
//  PokemonDetailTabViewController.m
//  Pokemon
//
//  Created by Kaijie Yu on 2/5/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import "PokemonDetailTabViewController.h"

#import "../GlobalConstants.h"
#import "PokemonInfoViewController.h"
#import "PokemonAreaViewController.h"
#import "PokemonSizeViewController.h"


@implementation PokemonDetailTabViewController

@synthesize tabBar = tabBar_;
@synthesize tabBarItems = tabBarItems_;

- (void)dealloc
{
  [tabBar_ release];
  [tabBarItems_ release];
  
  [super dealloc];
}

- (id)initWithPokemonID:(NSInteger)pokemonID
{
  self = [self init];
  if (self) {
    // Add child view controllers to each tab
    PokemonInfoViewController * pokemonInfoViewController = [[PokemonInfoViewController alloc] initWithPokemonID:pokemonID];
    PokemonAreaViewController * pokemonAreaViewController = [[PokemonAreaViewController alloc] initWithPokemonID:pokemonID];
    PokemonSizeViewController * pokemonSizeViewController = [[PokemonSizeViewController alloc] initWithPokemonID:pokemonID];
    
    self.tabBarItems = [NSArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Categories.png", @"image", pokemonInfoViewController, @"viewController", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"MyDownload.png", @"image", pokemonAreaViewController, @"viewController", nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"WordList.png", @"image", pokemonSizeViewController, @"viewController", nil],
                        nil];
    
    [pokemonInfoViewController release];
    [pokemonAreaViewController release];
    [pokemonSizeViewController release];
  }
  return self;
}

- (id)init {
  self = [super init];
  if (self) {
  }
  return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
  [super loadView];
  
  UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
  self.view = view;
  [view release];
  [self.view setBackgroundColor:[UIColor clearColor]];
  
  // Create a custom tab bar passing in the number of items,
  // the size of each item and setting ourself as the delegate
  tabBar_ = [[CustomTabBar alloc] initWithItemCount:self.tabBarItems.count
                                                size:CGSizeMake(kTabBarWdith / self.tabBarItems.count, kTabBarHeight)
                                                 tag:0
                                            delegate:self];
  
  tabBar_.frame = CGRectMake((320.0f - kTabBarWdith) / 2.0f,
                             480.0f - kTabBarHeight - 10.0f,
                             kTabBarWdith,
                             kTabBarHeight);
  [self.view addSubview:tabBar_];
  
  // Select the first tab
  [tabBar_ selectItemAtIndex:0];
  [self touchDownAtItemAtIndex:0];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  
  self.tabBar = nil;
  self.tabBarItems = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - PoketchTabBarDelegate

// Icon for each Tab Bar Item
- (UIImage *)iconFor:(NSUInteger)itemIndex {
  return [UIImage imageNamed:[[self.tabBarItems objectAtIndex:itemIndex] objectForKey:@"image"]];
}

- (void)touchDownAtItemAtIndex:(NSUInteger)itemIndex
{
  // Remove the current view controller's view
  UIView * currentView = [self.view viewWithTag:kPoketchSelectedViewControllerTag];
  [currentView removeFromSuperview];
  
  // Get the right view controller
  UIViewController * viewController = [[self.tabBarItems objectAtIndex:itemIndex] objectForKey:@"viewController"];
  [viewController.view setFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f - kTabBarHeight)];
  [viewController.view setTag:kPoketchSelectedViewControllerTag];
  
  // Add the new view controller's view
  if ([viewController respondsToSelector:@selector(viewWillAppear:)])
    [viewController viewWillAppear:NO];
  
  [self.view insertSubview:viewController.view belowSubview:self.tabBar];
  
  if ([viewController respondsToSelector:@selector(viewDidAppear:)])
    [viewController viewDidAppear:NO];
}

@end
