//
//  OSVVoiceInputScreen.m
//  OSVoicceryApp
//
//  Created by Alex.S on 26/11/2015.
//  Copyright © 2015 StartApp. All rights reserved.
//

#import "OSVVoiceInputScreen.h"
#import <ApiAI/ApiAI.h>
#import "AIVoiceLevelView.h"


@interface OSVVoiceInputScreen()

@property (nonatomic, weak) IBOutlet AIVoiceLevelView *voiceLevelView;

@property (nonatomic, strong) AIVoiceRequest *voiceRequest;

@end


@implementation OSVVoiceInputScreen

- (void)viewDidLoad
{
    ApiAI *apiai = [ApiAI sharedApiAI];
    self.voiceRequest = [apiai voiceRequest];
    
    __weak typeof(self) selfWeak = self;
    
    
    [self.voiceRequest setCompletionBlockSuccess:^(AIRequest *request, id response) {
        __strong typeof(selfWeak) selfStrong = selfWeak;
        
        
    } failure:^(AIRequest *request, NSError *error) {
        __strong typeof(selfWeak) selfStrong = selfWeak;
        
    }];
    
    [apiai enqueue:self.voiceRequest];
}




@end
