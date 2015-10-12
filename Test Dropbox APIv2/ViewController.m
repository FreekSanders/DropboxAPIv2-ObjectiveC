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
    [self.dropbox filesListFolderWithPath:@"" completion:^(NSArray<NSString *> *files) {
        if(!files) {
            NSLog(@"ERROR listing files");
        }
        else {
            for(NSString *file in files) {
                NSLog(@"%@", file);
            }
        }
    }];
}

- (IBAction)downloadFileButtonPressed:(UIButton *)sender {
    [self.dropbox filesDownloadWithPath:@"/testing.txt" completion:^(NSData *data) {
        if(!data) {
            NSLog(@"ERROR downloading file");
        }
        else {
            NSLog(@"%@", data);
        }
    }];
}

- (IBAction)uploadFileButtonPressed:(UIButton *)sender {
    NSData *data = [@"Hello SwiftyDropbox!" dataUsingEncoding:NSUTF8StringEncoding];
    [self.dropbox filesUploadWithPath:@"/testing.txt" fileData:data completion:^(BOOL success) {
        if(success) {
            NSLog(@"Upload successful");
        }
        else {
            NSLog(@"ERROR downloading file");
        }
    }];
}

- (IBAction)createDirectoryButtonPressed:(UIButton *)sender {
    [self.dropbox filesCreateFolderWithPath:self.directoryTextField.text completion:^(BOOL success) {
        if(success) {
            NSLog(@"Folder creation successful");
        }
        else {
            NSLog(@"ERROR downloading file");
        }
    }];
}

@end
