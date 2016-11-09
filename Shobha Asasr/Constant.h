


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.@"
#define ACCEPTABLE_ONLY @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
//****************************************************
#pragma mark - Parent Params
//****************************************************

extern NSString * const projectTitle;
extern NSString * const BaseUrl;
extern NSString * const register_user;
extern NSString * const get_products;

extern NSString * const get_category;
extern NSString * const style_diamonds;
extern NSString * const style_gemestones;
extern NSString * const style_metals;


extern NSString * const addtocart;
extern NSString * const removecart;
extern NSString * const updatecart;
extern NSString * const get_collections;
extern NSString * const employee;



//****************************************************

