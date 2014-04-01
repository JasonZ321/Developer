//
//  CardGameViewController.m
//  stanford2014Assignments1
//
//  Created by Jason Zhou on 14-3-13.
//  Copyright (c) 2014年 Jiasheng Zhou. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
@interface CardGameViewController ()

@property (strong, nonatomic) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;


@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSelection;
@property (nonatomic) int gameMode;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@end

@implementation CardGameViewController

- (IBAction)checkHistory:(UISlider *)sender {
    //NSLog(@"%@",self.game.history);
    //NSLog(@"max: %.5f",[sender maximumValue]);
    //NSLog(@"min: %.5f",[sender minimumValue]);
    /*
        for(NSString *string in self.game.history){
            NSLog(@"%@",string);
        }
    
    */
    if ([self.game.history count] > 0) {
        float sectionValue = 1.0 / [self.game.history count];
        int positionInArray = [sender value] / sectionValue;
        if (positionInArray > [self.game.history count] - 1) {
            positionInArray = [self.game.history count] - 1;
        }
        
        self.messageLabel.text =  self.game.history[positionInArray];
    }
    
    //NSLog(@"%@",self.game.history[positionInArray]);


    
    
}

- (CardMatchingGame *)game
{
    if (!_game)
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
   
    return _game;
}
- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}
- (IBAction)touchCardButton:(UIButton *)sender
{
    self.gameModeSelection.enabled = NO;
    int cardIndex = [self.cardButtons indexOfObject:sender];
    switch (self.gameModeSelection.selectedSegmentIndex) {
        case 0:
            [self.game chooseCardAtIndex:cardIndex];
            break;
        case 1:
            [self.game chooseCardAtIndexFor3:cardIndex];
            break;
        default:
            [self.game chooseCardAtIndex:cardIndex];
            break;
    }
    [self updateUI];
    
    
}
- (IBAction)deal:(UIButton *)sender
{
    
    self.game = [[CardMatchingGame alloc]init];
    self.gameModeSelection.enabled = YES;
    [self updateUI];
}


- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        
        Card *card = [self.game cardAtIndex:cardIndex];
        
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
       // NSLog(@"%@",[self titleForCard:card]);
                [cardButton setBackgroundImage: [self backgroundImageForCard:card]
            forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    self.messageLabel.text = self.game.message;
    [self.slider setValue:1.0];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
