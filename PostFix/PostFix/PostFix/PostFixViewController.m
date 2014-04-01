/*
 Student Name: Jiasheng Zhou
 Student Id: 4022828
 */

#import "PostFixViewController.h"

@interface PostFixViewController ()

//for displaying input and output on left top of screen
@property (strong, nonatomic) IBOutlet UILabel *answer;
//if user already input a point it should be YES
@property (nonatomic)BOOL hasPoint;
//if pop action just happens, it is YES
@property BOOL afterPop;
// show the divide by 0 error message
@property (strong, nonatomic) IBOutlet UILabel *errorMessage;
// super view of visual stack
@property (strong, nonatomic) IBOutlet UIView *visualStack;
// an array for storing labels of stacks
@property (strong,nonatomic) IBOutletCollection(UILabel) NSMutableArray *stackArray;
// an array for storing images of dividers
@property (strong,nonatomic) IBOutletCollection(UIImageView) NSMutableArray *dividerArray;

// their names can tell every thing
- (IBAction)number:(UIButton *)sender;
- (IBAction)clear:(UIButton *)sender;
- (IBAction)push:(UIButton *)sender;
- (IBAction)pop:(UIButton *)sender;


@end

@implementation PostFixViewController
@synthesize stack;

//@overide clear visual stack
-(void)clearStack
{
    for(int i = 0;i<5;i++){
        [self.stackArray[i] setText:@""];
        if(i<4){
            [self.dividerArray[3-i] setHidden:YES];
        }
    }
}
//@overide be called if a number is divided by zero
-(void)divideByZero
{
    self.errorMessage.text = @"divider can't be zero, input again.";
    self.errorMessage.hidden = NO;
}
//@overide push numbers to screen, it update the whole visual stack everytime stack changes.
-(void)pushToScreen{
    
    [self clearStack];       // clean stack first.
    //there are two situations
    if(self.stack.count >= 5){
        
        for (int i = 0; i<5;i++ ) {
            [self.stackArray[i] setText:[self.stack.numbers[self.stack.count-1-i] stringValue]];
                       
            if(i < 4){
                // unhide divider every time add a visual stack except the top one
                [self.dividerArray[3-i] setHidden:NO];
            }
        }
    }else{
        
        for (int i = 0; i<self.stack.count;i++ ) {
            [self.stackArray[4-i] setText:[self.stack.numbers[i] stringValue]];
            if(i < 4){
                [self.dividerArray[3-i] setHidden:NO];
            }
        }
    }
}

//@overide pop a result to screen
-(void)popToScreen:(NSNumber *)aNum{
    if(aNum != nil) {
        self.answer.text = [NSString stringWithFormat:@"%@",aNum];
        self.afterPop = YES;
    }
}
#define HEIGHT_DIVIDER 3
- (void)viewDidLoad
{
    [super viewDidLoad];

   
    [self initialize];
           
    [self loadUI];
    
}
// initialize property and set delegate
-(void)initialize
{
    self.answer.text = [[NSString alloc]init];
    
    self.hasPoint = NO;
    self.afterPop= NO;
    stack = [[NumStack alloc]init];
    [stack setDelegate:self];
    
    
    self.stackArray = [[NSMutableArray alloc]init];
    self.dividerArray = [[NSMutableArray alloc]init];
}

// load visual stack User interface
-(void)loadUI
{
    //create a background view for visual stack
    CGRect frame = CGRectMake(11, 63, 240,220);
    self.visualStack = [[UIView alloc]initWithFrame:frame];
    [self.view addSubview:self.visualStack];
    UIImage * stackBackground = [UIImage imageNamed:@"stack_background.png"];
    self.visualStack.backgroundColor = [[UIColor alloc]initWithPatternImage:stackBackground];
    
    //calculate the coodination
    double x = 0, y = 0,width = self.visualStack.frame.size.width,height = self.visualStack.frame.size.height;
    double height_stack = (height - 4*HEIGHT_DIVIDER)/5;
    //initialize divider and visual stack label
    for (int i = 0; i<9; i++) {
        
        if(i%2 == 0){
            frame = CGRectMake(x, y, width, height_stack);
            
            [self initialStackArrayWithIndex:i/2 Frame:frame];
            y += height_stack;
        }else{
            frame = CGRectMake(x, y, width, HEIGHT_DIVIDER);
            [self initialDividerArrayWithIndex:i/2 Frame:frame];
            y += HEIGHT_DIVIDER;
        }
    }
    
    [self.visualStack addSubview: self.errorMessage];

}
// function for initialize one stack with particular index and frame
-(void)initialStackArrayWithIndex:(int) index Frame:(CGRect) frame
{
    self.stackArray[index] = [[UILabel alloc]initWithFrame:frame];
   
    [self.stackArray[index] setTextAlignment:NSTextAlignmentCenter];
    //self.stackLabel1.text = @"1";
    [self.stackArray[index] setBackgroundColor:self.visualStack.backgroundColor];
    //[self.stackArray[index] setText:[NSString stringWithFormat:@"%d",index]];
    [self.visualStack addSubview:self.stackArray[index]];


}

// function for initialize one divider with particular index and frame
-(void)initialDividerArrayWithIndex:(int) index Frame:(CGRect) frame
{
    self.dividerArray[index] = [[UIImageView alloc]initWithFrame:frame];
    UIImage *img = [UIImage imageNamed:@"divider.png"];
    [self.dividerArray[index] setImage:img];
    [self.visualStack addSubview:self.dividerArray[index]];
    [self.dividerArray[index] setHidden:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// happens when press any number
- (IBAction)number:(UIButton *)sender {
    //every time you want to input something after pop, clear input field
    if(self.afterPop == YES){
        self.answer.text = @"";
        self.afterPop= NO;
    }
    // when you want input something again after divide by 0 error, hide the error message
    self.errorMessage.hidden = YES;
    //tag: 10 for 0   11 for .
    switch ([sender tag]) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            self.answer.text = [self.answer.text stringByAppendingFormat:@"%d",[sender tag]];
            break;
        case 10:
            self.answer.text = [self.answer.text stringByAppendingFormat:@"%d",0];
            break;
        case 11:
            if (self.hasPoint == NO) {
                self.answer.text = [self.answer.text stringByAppendingString:@"."];
                self.hasPoint = YES;
            }
                        
        default:
            break;
    }
}

// clear stack,visual stack and input field
- (IBAction)clear:(UIButton *)sender {
    
    if([sender tag] == 12){
        self.answer.text = @"";
        [self.stack clear];
        
    }
}

// when press operation pop a value, call stack's pop function in model.
- (IBAction)pop:(UIButton *)sender {
    NSString *operation = nil;
    switch ([sender tag]) {
        case 1:
            operation = @"+";
            break;
        case 2:
            operation = @"-";
            break;
        case 3:
            operation = @"*";
            break;
        case 4:
            operation = @"/";
            break;
            
        default:
            break;
    }
    [stack pop:operation];
    
}

// when press push then push a value to stack's push function.
- (IBAction)push:(UIButton *)sender {
    NSNumber *aNum = [NSNumber numberWithFloat:[self.answer.text floatValue]];
    if([self.answer.text length] > 0){
        [stack push:aNum];
        self.answer.text = @"";
        self.hasPoint = NO;
    }
}

@end