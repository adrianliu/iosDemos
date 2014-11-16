//
//  ViewController.m
//  AddressBookDemo
//
//  Created by Arthur Knopper on 24/10/12.
//  Copyright (c) 2012 iOSCreator. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
//#import "AppDelegate.h"
#import "ContactViewController.h"
#import <AddressBook/AddressBook.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *tableData;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
//    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:nil];
//    
//    NSArray *actionButtonItems = @[shareItem, cameraItem];
//    self.navigationItem.rightBarButtonItems = actionButtonItems;

    
    
    
    self.title = @"All Contacts";
    
    UIBarButtonItem *leftBarButton=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(closePicker)];
    
    
    UIBarButtonItem *rightBarButton=[[UIBarButtonItem alloc] initWithTitle:@"LogOut" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    
    [self.navigationItem setLeftBarButtonItem:leftBarButton];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    
    //self.navigationController.navigationBar.backgroundColor=[UIColor redColor];
    
    self.tableData = [[NSMutableArray alloc] init];
    
    [self getPersonOutOfAddressBook];
}

-(void)closePicker{
    
}

-(void)logOut{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getPersonOutOfAddressBook
{
    CFErrorRef error = NULL;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    __block BOOL accessGranted = NO;
    
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        // Semaphore is used for blocking until response
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            
            accessGranted = granted;
            granted ? NSLog(@"Access granted") : NSLog(@"Access denied");
            NSLog(@"Test IN");
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
        NSLog(@"IOS5");
    }

    
    
    
    if (addressBook != nil && accessGranted)
    {
        NSLog(@"Succesful.");
        
        NSArray *allContacts = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
        
        NSUInteger i = 0;
        for (i = 0; i < [allContacts count]; i++)
        {
            Person *person = [[Person alloc] init];
            
            ABRecordRef contactPerson = (__bridge ABRecordRef)allContacts[i];
            
            NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty);
            NSString *lastName =  (__bridge_transfer NSString *)ABRecordCopyValue(contactPerson, kABPersonLastNameProperty);
            NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
            
            person.firstName = firstName;
            person.lastName = lastName;
            person.fullName = fullName;
            
            //email
            ABMultiValueRef emails = ABRecordCopyValue(contactPerson, kABPersonEmailProperty);
            
            NSUInteger j = 0;
            for (j = 0; j < ABMultiValueGetCount(emails); j++)
            {
                NSString *email = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, j);
                if (j == 0)
                {
                    person.homeEmail = email;
                NSLog(@"person.homeEmail = %@ ", person.homeEmail);
                }
                
                else if (j==1)
                    person.workEmail = email;
            }
            
            [self.tableData addObject:person];
        }
    }
    
    CFRelease(addressBook);
}

#pragma mark TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Person *person = [self.tableData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = person.fullName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *person = [self.tableData objectAtIndex:indexPath.row];

    ContactViewController *contactViewController = [[ContactViewController alloc] initWithPerson:person];
    [self.navigationController pushViewController:contactViewController animated:YES];
}



@end
