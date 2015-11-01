//
//  CreateTeamViewController.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "CreateTeamViewController.h"

@interface CreateTeamViewController ()

@property (nonatomic, assign) IBOutlet UILabel *imageHintLabel;
@property (nonatomic, assign) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) IBOutlet UITextField *teamNameField;
@property (nonatomic, assign) IBOutlet UITextView *teammatesTextView;

@property (nonatomic, strong) UIImagePickerController *imagePickController;

@end

@implementation CreateTeamViewController

- (void)initView {
    self.viewModel = [[CreateTeamViewModel alloc] init];
    self.inputModel = [[CreateTeamInputModel alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.viewModel fetchUserLocation];
}

#pragma mark - View Methods

- (void)showImagePickerController {
    if (self.imagePickController == nil) {
        self.imagePickController = [[UIImagePickerController alloc] init];
        self.imagePickController.delegate = (id)self;
        self.imagePickController.allowsEditing = YES;
        self.imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        self.imagePickController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self presentViewController:self.imagePickController animated:YES completion:nil];
}

#pragma mark - View Actions

- (IBAction)selectPhotoButtonClicked:(id)sender {
    [self showImagePickerController];
}

- (IBAction)createTeamButtonClick:(id)sender {
    [self.view endEditing:YES];
    
    self.viewModel.teamName = self.teamNameField.text;
    [self.viewModel createTeam];
}

#pragma mark - UIImagePickerController Delegete

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info   {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.viewModel.teamImage = image;
    [self dismissViewControllerAnimated:YES completion:^{
        self.imageHintLabel.hidden = YES;
        self.imageView.image = image;
    }];
}

@end
