//
//  ContactListViewController.m
//  SocialEvening
//
//  Created by Naveen Shan on 01/11/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "ContactListViewController.h"

#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface ContactListViewController ()

@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) CNContactStore *contactStore;

@property (nonatomic, assign) IBOutlet UITableView *tableView;

@end

@implementation ContactListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Contacts";
    [self authenticateAndFetchContact];
}

#pragma mark - View Methods

- (void)authenticateAndFetchContact {
    if (self.contactStore == nil) {
        self.contactStore = [[CNContactStore alloc] init];
        CNAuthorizationStatus authorizationStatus= [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authorizationStatus == CNAuthorizationStatusNotDetermined ||
            authorizationStatus == CNAuthorizationStatusDenied) {
            [self.contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    [self fetchContacts];
                }
            }];
        } else {
            [self fetchContacts];
        }
    }
    
    if (self.contacts.count == 0) {
        [self fetchContacts];
    }
}

- (void)fetchContacts {
    NSError *error = nil;
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactGivenNameKey, CNContactFamilyNameKey]];
    NSMutableArray *contactList = [NSMutableArray array];
    [self.contactStore enumerateContactsWithFetchRequest:fetchRequest error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        [contactList addObject:contact];
    }];
    
    self.contacts = contactList;
    [self.tableView reloadData];
}

- (void)handleCellSelection:(UITableViewCell *)cell {
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

#pragma mark - View Action

- (IBAction)addTeammate:(id)sender {
    
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    CNContact *contact = self.contacts[indexPath.row];
    if (contact) {
        cell.textLabel.text = contact.givenName;
    }
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [self handleCellSelection:selectedCell];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    [self handleCellSelection:selectedCell];
}

@end
