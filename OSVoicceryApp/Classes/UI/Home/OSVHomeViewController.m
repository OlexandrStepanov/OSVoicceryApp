//
//  OSVHomeViewController.m
//  OSVoicceryApp
//
//  Created by Alex.S on 26/11/2015.
//  Copyright © 2015 StartApp. All rights reserved.
//

#import "OSVHomeViewController.h"

#import <ApiAI.h>

NSString * const OSVLanguageSelectedUserDefaultsKey = @"OSVLanguageSelectedUserDefaultsKey";

typedef NS_ENUM(NSUInteger, OSVLanguageSelected)
{
    OSVLanguageSelectedEnglish = 1,
    OSVLanguageSelectedRussian
};


@interface OSVHomeViewController()

@property (nonatomic) OSVLanguageSelected selectedLanguage;

@end


@implementation OSVHomeViewController

- (void)viewDidLoad
{
    NSNumber *selectedLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:OSVLanguageSelectedUserDefaultsKey];
    
    if (selectedLanguage)
    {
        //  Setup language right away
        self.selectedLanguage = [selectedLanguage unsignedIntegerValue];
        [self setupApiAI];
    }
    else
    {
        //  Present prompt to user to select language
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Select your language" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *action;
        
        action = [UIAlertAction actionWithTitle:@"English" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self proceedWithSelectedLanguage:OSVLanguageSelectedEnglish];
        }];
        [alertController addAction:action];
        
        action = [UIAlertAction actionWithTitle:@"Русский" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self proceedWithSelectedLanguage:OSVLanguageSelectedRussian];
        }];
        [alertController addAction:action];
        
        [self presentViewController:alertController animated:YES completion:NULL];
    }
    
}

#pragma mark -

- (void)proceedWithSelectedLanguage:(OSVLanguageSelected)language
{
    self.selectedLanguage = language;
    
    //  Save to user settings
    [[NSUserDefaults standardUserDefaults] setObject:@(self.selectedLanguage) forKey:OSVLanguageSelectedUserDefaultsKey];
    
    //  Setup ApiAI accordingly
    [self setupApiAI];
}

- (void)setupApiAI
{
    ApiAI *apiai = [ApiAI sharedApiAI];
    
    id <AIConfiguration> configuration = [[AIDefaultConfiguration alloc] init];
    
    configuration.subscriptionKey = @"ee88e4a6-4ec2-44a7-9468-898fd59d14a7";
    
    switch (self.selectedLanguage) {
        case OSVLanguageSelectedEnglish: {
            configuration.clientAccessToken = @"887aceb60dbb42a19581f7e95eb7b976";
            break;
        }
        case OSVLanguageSelectedRussian: {
            configuration.clientAccessToken = @"48cfd0738e394087bdf29b4a372cd5ed";
            break;
        }
        default: {
            NSAssert(1, @"Selected language should be one of enum values");
            break;
        }
    }
    
    apiai.configuration = configuration;
}

@end
