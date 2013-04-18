//
//  JANetwork.m
//  AnswerPsychic
//
//  Created by Vasanth on 3/5/10.
//  Copyright 2010 Ask.com. All rights reserved.
//

#import "JANetwork.h"
#import <pthread.h>

static int              gNetworkTaskCount = 0;
static pthread_mutex_t  gMutex = PTHREAD_MUTEX_INITIALIZER;

///////////////////////////////////////////////////////////////////////////////////////////////////
void NetworkRequestStarted() {
  pthread_mutex_lock(&gMutex);

  if (0 == gNetworkTaskCount) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
  }
  gNetworkTaskCount++;

  pthread_mutex_unlock(&gMutex);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
void NetworkRequestStopped() {
  pthread_mutex_lock(&gMutex);

  --gNetworkTaskCount;
  gNetworkTaskCount = MAX(0, gNetworkTaskCount);
    NSLog(@"%d",gNetworkTaskCount);

  if (gNetworkTaskCount == 0) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  }

  pthread_mutex_unlock(&gMutex);
}

