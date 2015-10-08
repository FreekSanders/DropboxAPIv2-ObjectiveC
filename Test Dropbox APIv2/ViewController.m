//
//  ViewController.m
//  Test Dropbox APIv2
//
//  Created by Freek Sanders on 08-10-15.
//  Copyright © 2015 Freek Sanders. All rights reserved.
//

#import "ViewController.h"
#import "Test_Dropbox_APIv2-Swift.h"

@interface ViewController ()
@property (nonatomic, strong) DropboxService *dropbox;
@property (weak, nonatomic) IBOutlet UITextField *directoryTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dropbox = [[DropboxService alloc] init];
    [self.dropbox setupWithAppKey:@"bwkfsmcsmsyy3yk"];
}

- (IBAction)linkButtonPressed:(UIButton *)sender {
    [self.dropbox link:self];
}

- (IBAction)listFilesButtonPressed:(UIButton *)sender {
    [self.dropbox filesListFolderWithPath:@"" recursive:NO];
}

- (IBAction)downloadFileButtonPressed:(UIButton *)sender {
    [self.dropbox downloadFile];
}

- (IBAction)uploadFileButtonPressed:(UIButton *)sender {
    [self.dropbox uploadFile];
}

- (IBAction)createDirectoryButtonPressed:(UIButton *)sender {
    [self.dropbox filesCreateFolderWithPath:self.directoryTextField.text];
}

@end
