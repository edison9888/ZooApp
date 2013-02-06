//
//  AGAlertView.m
//  ZooApp
//
//  Created by Andrea Gerlach on 22.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//


#import "AGAlertView.h"

@implementation AGAlertView

@end


/*
 - (void)createFavAlertViewWithArticle:(NSString*)article object:(NSString*)object fav:(BOOL) fav{
 
 NSString *titleString;
 NSString *messageString;
 NSString *messageEnding = @"Diese können Sie unter der Rubrik \"Mein Zoo\" einsehen.";
 
 
 if (fav) {
 titleString = [NSString stringWithFormat:@"%@ entfernen", object];
 messageString = [NSString stringWithFormat:@"Hiermit entfernen Sie %@ %@ aus Ihrer Favoritenliste. %@", article, object, messageEnding];
 } else {
 titleString = [NSString stringWithFormat:@"%@ favorisieren", object];
 messageString = [NSString stringWithFormat:@"Hiermit fügen Sie %@ %@ Ihrer Favoritenliste hinzu. %@", article, object, messageEnding];
 }
 
 UIAlertView *alert;
 alert = [[UIAlertView alloc] initWithTitle:titleString message:messageString delegate:self cancelButtonTitle:@"Abbrechen" otherButtonTitles:@"Ok", nil];
 
 [alert show];
 }
 
 - (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
 
 if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Ok"]) {
 
 if ([[alertView title] isEqualToString:@"Tier favorisieren"]) {
 
 self.favAnimal = YES;
 // add animal to favorites
 //      [[AGFavManager sharedInstance] addAnimalToFavsWithName:self.currentAnimal.name notified:NO];
 
 } else if ([[alertView title] isEqualToString:@"Tier entfernen"]) {
 
 self.favAnimal = NO;
 // remove animal from favorites
 //      [[AGFavManager sharedInstance] removeAnimalFromFavsWithName:self.currentAnimal.name];
 
 } else  if ([[alertView title] isEqualToString:@"Fütterung favorisieren"]) {
 self.favFeedingTime = YES;
 // methode zum hinzufügen
 NSLog(@"XXXXXXXX Hier bin ich XXXXXXXX Fütterung hinzufügen");
 
 } else if ([[alertView title] isEqualToString:@"Fütterung entfernen"]) {
 self.favFeedingTime = NO;
 // methode zum entfernen
 NSLog(@"XXXXXXXX Hier bin ich XXXXXXXX Fütterung entfernen");
 
 } else if ([[alertView title] isEqualToString:@"Kommentierung favorisieren"]) {
 self.favCommentaryTime = YES;
 // methode zum hinzufügen
 NSLog(@"XXXXXXXX Hier bin ich XXXXXXXX Kommentierung hinzufügen");
 
 } else if ([[alertView title] isEqualToString:@"Kommentierung entfernen"]) {
 self.favCommentaryTime = NO;
 // methode zum entfernen
 NSLog(@"XXXXXXXX Hier bin ich XXXXXXXX Kommentierung entfernen");
 }
 }
 [self checkFavStatus];
 }
 
*/