//
//  CreatSqlData.m
//  PodTest
//
//  Created by etcxm on 16/6/12.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "CreatSqlData.h"
#import "FoodData.h"
#import "Foodmodel.h"
#import "movieModel.h"
#import "MovieData.h"
#import "UserModel.h"
#import "UserData.h"
#import "CinemaModel.h"
#import "CinemaData.h"


@implementation CreatSqlData

- (void)creatSqlData{

    
    
    FoodData *foodData = [[FoodData alloc]init];
    [foodData creatUsersTable:@"CREATE TABLE IF NOT EXISTS foods(foodName TEXT PRIMARY KEY,pingfen TEXT,pingjia TEXT ,pjNum TEXT ,imageName TEXT,address TEXT,style TEXT,time TEXT,price TEXT,pricePurchase TEXT ,sold TEXT)"];
    NSArray *foodNameArr = @[@"牛太郎烤肉",@"德庄火锅",@"咏蛙田鸡",@"食域烤肉",@"转转乐",@"蟹蟹侬",@"虾饼蟹酱",@"牛肉火锅",@"天上人间",@"麻辣香锅",@"大侠冒菜"];
    NSArray *pingjiaArr = @[@"服务不是一般的差，点完单等了半个多小时，追问服务员竟然说忘记下单，这也可以，真是醉了，这还不算，加单又过了十几分钟追问服务员说还没加，总共吃饭吃了1个半小时，至少1个小时浪费在服务员没下单的等待上了，这种服务绝对不会再来第二次了！",@"茶点品种不算多也不算少，有一部分是要另外出钱的。我们去吃的午茶，人不算多。茶点的味道做的都还是不错的，上菜速度一开始挺快的，但后面就越来越慢了。不过还是吃的挺饱的。有个不足的地方是，有很多菜品它不配一些特色蘸料，最多只有酸醋和酱油，味道就很寡的。推荐的菜品有虾饺皇，蟹子烧卖皇，凤爪，韩式辣菜包，红枣糕，蜂蜜糕，榴莲酥。。",@"有个叫什么薄饼的，说实话在像千层饼，那也不要紧，主要是难以入口。而且人员似乎不怎么够，上菜速度不是很快，不过后面催菜的时候有一个主管挺好的，赶忙帮我们去拿，不过没问他的名字。而且有的菜没点也上，有的菜反复上，希望改进",@"很少给差评，不过真的很生气，人多也不能这样，19点06分下单的菜，到20点40分还好几个没上，19点48分下单的走的时候就上了两三个，吃个自助都没吃饱，催了好几次也没人管，我也只能无语了，菜单后面被拿走了，要不然还可以拍照",@"还不错，环境很好，服务员好可爱的说，喜欢肠粉，虾皇，杨枝甘露～～制作蛮精致的，就是薯条到我们走了还木有上呢，这～～～",@"在环岛路曾厝垵天桥往会展方向前行大约100米左右然后有个小路口进去，开到底就是酒店里了。 在海边，环境很不错。 上菜第一次速度很快，加单需要等比较长的时间。 整体来说点心的口味中规中矩，没有非常特别的。 推荐他们家的黑椒牛纽和佳丽鲜虾饺，大拌菜很不错，可惜只有量非常少！一般爱吃沙拉的人可以吃五六份。",@"上菜那不是一般的慢，态度也不够好，说实在的不行，下次不会再来",@"款式少，款式及口味比莲坂佳丽差多了，环境真不适合喝茶的地方，都是十人的大圆桌，三四个人坐的话，空荡荡的，一点都不温馨，不过就是服务员的服务态度很好，值得表扬。",@"餐具太太太脏了!碗上杯子上还有黄黄的污渍，换了几个都这样了，太恶心了，能不能洗干净点?把酒楼的档次降低好几层。小店的餐具都不会这样，一个酒楼这样，太令人寒心，都不敢去吃了.",@"去的比较早 所以上菜速度还挺快 环境一般 其他的食物都没有什么出彩之处",@"跟环岛路那家感觉不在同一水平线啊，上菜慢，态度差，东西也不好吃，靠窗一整排空调也不给力，吃得一身汗"];
    NSArray *purchaseArr = @[@"单人自助套餐，节假日通用",@"包含锅底，提供免费WIFI",@"新鲜各种类田鸡，好吃到爆炸",@"最新鲜的烤肉，就在食域，单人晚餐，节假日通用",@"单人自助午餐，山珍海味任你选",@"代金券，相当于7折优惠",@"可累计叠加使用，不限次数",@"免费赠送锅底，免费提供WIFI",@"给你天上人间般的享受，节假日通用",@"麻辣到底，各种口味，任你挑选",@"四人同行，一人免单，到店即可享受优惠"];
    Foodmodel *foodmodel = [[Foodmodel alloc]init];
    for (int i = 0; i < 11; i++ ) {
        
        foodmodel.foodName = [foodNameArr objectAtIndex:i];
        foodmodel.pingfen = ((double)arc4random()/0x100000000)+4;
        foodmodel.pingjia = [pingjiaArr objectAtIndex:i];
        foodmodel.pjNum = arc4random()%10+1;
        foodmodel.imageName = [NSString stringWithFormat:@"food0%d",i];
        foodmodel.style = [NSString stringWithFormat:@"第 %d 粤菜",i];
        foodmodel.time = @"16:00 - 晚上3:00";
        foodmodel.price = arc4random_uniform(100)+30;
        foodmodel.pricePurchase = [purchaseArr objectAtIndex:i];
        foodmodel.sold = arc4random()%100+i;
        foodmodel.address = @"福建厦门市思明区观日路2号中软国际开发10";
        [foodData insertUsersData:foodmodel];
        
    }
    
    
    
    MovieData *movieData = [[MovieData alloc]init];
    //                movieName,moviePingfen,moviePingjia,moviePjNum,movieDuration,movieImageName,movieStyle,movieTime,movieIntroduce,movieStagePhotoArr
    [movieData creatUsersTable:@"CREATE TABLE IF NOT EXISTS movies(movieName TEXT PRIMARY KEY,moviePingfen TEXT,moviePingjia TEXT ,moviePjNum TEXT ,movieDuration TEXT,movieImageName TEXT,movieStyle TEXT,movieTime TEXT,movieIntroduce TEXT ,movieStagePhotoArr TEXT,moviePlayTime TEXT,movieArea TEXT)"];
    
    NSArray *movieNameArr = @[@"叶问3",@"教父",@" 星球大战2：帝国反击战 ",@"飞越疯人院",@"卡萨布兰卡",@"肖申克的救赎",@"黄金三镖客",@"低俗小说",@"魔兽",@"万万没想到",@"速度与激情6",@"盗梦空间",@"记忆裂痕",@"生死停留",@"死亡幻觉",@"禁闭岛"];
    NSArray *movieIntroduceArr = @[@"1959年，叶问 （甄子丹饰）与张永成 （熊黛林饰）将大儿子叶准送回广东，小儿子叶正继续在香港读书。在与马鲸笙 （谭耀文饰）与其老板 （迈克·泰森饰）所带领的帮派抗争的过程中，叶问带领着自己的弟子保卫了小学，并结识了依靠拉车和在地下赌场斗武为生的张天志 （张晋饰），二 人惺惺相惜。 此时，自称 “咏春正宗” 的张天志却向叶问公开宣战，要为自己新开的武馆争取名誉。可是张永成突然病危，让叶问不得不肩负起照顾妻儿的责任。面对家庭和武术，叶问应战张天志，夺回属于他 “咏春正宗” 的头衔，之后叶问潜心研究武学，授徒传拳，成为一代宗师[5-6]  。",@"40年代的美国，“教父”维托·唐·柯里昂（马龙·白兰度 饰）是黑手党柯里昂家族的首领，带领家族从事非法的勾当，但同时他也是许多弱小平民的保护神，深得人们爱戴。因为拒绝了毒枭索洛索的毒品交易要求，柯里昂家族和纽约其他几个黑手党家族的矛盾激化。圣诞前夕，索洛索劫持了“教 父”的参谋汤姆，并派人暗杀“教父”；因为内奸的出卖，“教父”的大儿子逊尼被仇家杀害；小儿子麦克（阿尔·帕西诺 饰）也被卷了进来，失去爱妻。黑手党家族之间的矛盾越来越白热化。年老的“教父”面对丧子之痛怎样统领全局？黑手党之间的仇杀如何落幕？谁是家族的内奸？谁又能够成为新一代的“教父”？血雨腥风和温情脉脉，在这部里程碑式的黑帮史诗巨片里真实上演。",@"《星球大战5：帝国反击战》（Star Wars: Episode V - The Empire Strikes Back）是科幻电影《星球大战》系列的第五集，也是正传系列的第二部，由厄文·克什纳执导，马克·哈米尔、哈里森·福特、凯丽·费雪等主演，于1980年5月上映，讲述了三位主人公在霍斯战役及之后在达戈巴、贝斯坪等地的历险故事。",@"《飞越疯人院》改编自美国作家肯·克西的同名小说，是一部由米洛斯·福尔曼执导，杰克·尼科尔森、路易丝·弗莱彻、丹尼·德维托等主演的剧情电影。影片讲述了迈克·墨菲为了逃避监狱里的强制劳动，装作精神异常，被送进了精神病院，他的到来，给死气沉沉的精神病院带来了剧烈的冲击。该片于1975年11月19在美国上映。1976年该片在第48届奥斯卡颁奖礼上获得了最佳影片、最佳男主角、最佳女主角等5项奖项[1]  ",@"《卡萨布兰卡》是由华纳兄弟影片公司出品的爱情电影，由迈克尔·柯蒂斯执导，亨弗莱·鲍嘉、英格丽·褒曼、克劳德·雷恩斯、保罗·亨雷德等主演。影片讲述了二战时期，商人里克手持宝贵的通行证，反纳粹人士维克多和妻子伊尔莎的到来使得里克与伊尔莎的旧情复燃，两人面对感情和政治的矛盾难以抉择的故事。该片于1942年11月26日在美国上映。",@"《肖申克的救赎》（The Shawshank Redemption）取自斯蒂芬·金《不同的季节》中收录的《丽塔·海华丝及萧山克监狱的救赎》而改编成的《肖申克的救赎》剧本，并由弗兰克·达拉邦特执导，蒂姆·罗宾斯、摩根·弗里曼等主演。",@"《黄金三镖》是一部由赛尔乔·莱昂内执导意大利西部片，该影片系镖客电影三部曲的完结篇。影片由克林特·伊斯特伍德、李·范·克里夫和伊莱·沃勒克等领衔主演，分饰英文片名所指的好人、坏人和丑恶之人。",@"《低俗小说》是由昆汀·塔伦蒂诺执导，布鲁斯·威利斯、乌玛·瑟曼、约翰·特拉沃塔、阿曼达·普拉莫、蒂姆·罗斯等主演的犯罪电影。",@"《魔兽》是由美国传奇影业、环球影业联合出品的奇幻动作片，由邓肯·琼斯执导，崔维斯·费米尔、托比·凯贝尔、宝拉·巴顿、本·施耐泽、本·福斯特、吴彦祖、多米尼克·库珀、罗伯特·卡辛斯基联合主演。",@"《万万没想到》是2015年叫兽易小星执导的奇幻喜剧电影，由黄建新监制，韩寒任艺术指导，杨子姗、白客、陈柏霖、马天宇、刘循子墨等出演。",@"《速度与激情6》是2013年美国犯罪动作片，由林诣彬执导，克里斯·摩根、Gary Scott Thompson编剧，范·迪塞尔、保罗·沃克主演。此部为速度与激情系列的第六部作品，剧情设定于《速度与激情5》之后，《速度与激情3：东京漂移》之前。",@"《盗梦空间》是由克里斯托弗·诺兰执导，莱昂纳多·迪卡普里奥，玛丽昂·歌迪亚等主演的电影。影片剧情游走于梦境与现实之间，被定义为“发生在意识结构内的当代动作科幻片”。",@"《记忆裂痕》是由好莱坞华人导演吴宇森指导，由本·阿弗莱克、乌玛·瑟曼、阿伦·艾克哈特、科姆·菲尔、凯瑟琳·莫利斯主演的一部动作电影。",@"《生死停留》是由马克·福斯特执导，伊万·麦克格雷格、瑞恩·高斯林、娜奥米·沃茨主演的惊悚悬疑电影，于2005年10月21日在美国上映。",@"《死亡幻觉》是由理查德·凯利执导，杰克·吉伦哈尔、凯瑟琳·罗斯、德鲁·巴里摩尔主演的科幻悬疑电影，于2001年10月26日在美国上映。",@"《禁闭岛》改编自美国小说家丹尼斯·勒翰的同名小说，由马丁·斯科塞斯执导，莱昂纳多·迪卡普里奥、马克·鲁弗洛、本·金斯利等主演。该片于2010年2月19日在美国上映。"];
    NSMutableArray *stageArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 6; i++) {
        
        NSString *imageStr = [NSString stringWithFormat:@"movie0%d",i+1];
        [stageArray addObject:imageStr];
        
    }
    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:stageArray];
    NSArray *styleArr = @[@"动作片",@"科幻片",@"恐怖片",@"爱情片"];
    NSArray *areaArr = @[@"海外",@"中国"];
    movieModel *moviemodel = [[movieModel alloc]init];
    NSInteger indexNum;
    NSInteger movNumb2;
    int arcIndex = 1;
    for (int i = 0; i < 16; i++ ) {
        if (i == 0) {
            moviemodel.movieStyle = [NSString stringWithFormat:@"%@/%@",[styleArr objectAtIndex:0],[styleArr objectAtIndex:3]];
            moviemodel.movieArea = areaArr[1];
        }else{
            
            NSInteger movNumb1 = arc4random_uniform(4);
            do{
                movNumb2 = arc4random_uniform(4);
                if (movNumb2 == movNumb1) {
                    arcIndex = 1;
                }
                else{
                    arcIndex = 0;
                }
                
            }while(arcIndex);
            moviemodel.movieStyle = [NSString stringWithFormat:@"%@/%@",[styleArr objectAtIndex:movNumb1],[styleArr objectAtIndex:movNumb2]];
            moviemodel.movieArea = areaArr[0];
        }
        
        moviemodel.movieName = [movieNameArr objectAtIndex:i];
        NSInteger numb = arc4random_uniform(3)+7;
        moviemodel.moviePingfen = ((double)arc4random()/0x100000000)+numb;
        moviemodel.moviePingjia = [NSString stringWithFormat:@"%@,很不错，推荐，可以看的",moviemodel.movieName];
        moviemodel.moviePjNum = arc4random()%10+1;
        moviemodel.movieImageName = [NSString stringWithFormat:@"movie0%d",i+1];
      
        NSInteger movieNumb = arc4random_uniform(29)+1;
        moviemodel.movieTime =[ NSString stringWithFormat:@"2016-0%ld-%ld",numb,movieNumb];
        moviemodel.movieDuration = arc4random_uniform(30)+90;
        moviemodel.movieIntroduce = [movieIntroduceArr objectAtIndex:i];
        moviemodel.movieStagePhotoArr = imageData;
       
        if (i < 8) {
            
            indexNum = 6;
            
        }else if(i >= 8 && i < 12){
            
            indexNum = 7;
          
        }
        else{
            
            indexNum = 8;
        }
        moviemodel.moviePlayTime = indexNum;
        
        
        [movieData insertUsersData:moviemodel];
        
    }
    
    UserData *userData = [[UserData alloc]init];
    
    [userData creatUsersTable:@"CREATE TABLE IF NOT EXISTS user(userPhone TEXT PRIMARY KEY,userImageName TEXT,userMoney TEXT ,userName TEXT ,userLoginPw TEXT,userPayPw TEXT,userSex TEXT,userBirthday TEXT,userAddress TEXT ,userPJ TEXT,userHadPay TEXT,userWaitPay TEXT ,userWaitPingJia TEXT,userAdminName TEXT)"];
    
    CinemaData *cinemaData = [[CinemaData alloc]init];

    [cinemaData creatUsersTable:@"CREATE TABLE IF NOT EXISTS cinemas(cinemaName TEXT PRIMARY KEY,cinemaAdress TEXT,cinemaLowPrice TEXT ,cinemaMovieNumb TEXT ,cinemaSessionNumb TEXT,cinemaDistrict TEXT,cinemaDistance TEXT,cinemaPhone TEXT,cinemaImageName TEXT)"];
    
        /*
        *
                  cinemaName
        //        cinemaAdress
        //        cinemaLowPrice;
        //        cinemaMovieNumb;
        //        cinemaSessionNumb;
        //        *cinemaDistrict;
        //        *cinemaDistance;
        //        *cinemaPhone;
        //        *cinemaImageName;
         
         */
    
    
    NSArray *cinemaNameArr = @[@"厦门金逸影城五缘湾店",@"华彩中兴影城（原大地影城）",@"金逸厦门明发店",@"中影星美国际影城罗宾森点",@"厦门4D5D私人影院",@"厦门中华电影院",@"厦门17.5影城集美店",@"梦露歌剧院影城",@"厦门集美世纪嘉华",@"金逸影城海沧店"];
    NSArray *cinemaAdressArr = @[@"厦门市湖里区金湖路101号乐都汇购物中心4楼",@"厦门市湖里区枋湖客运中心二楼西区",@"厦门市思明区明发商业广场c区3楼",@"厦门市思明区厦禾路899号罗宾森购物广场三楼",@"厦门市思明区和厦门近郊各地",@"厦门市思明区中山路219-225号3楼",@"厦门市集美区乐海路23号新华都购物广场3楼301号",@"厦门市海沧区滨湖北路二路62号B200B300单元",@"厦门市集美区剑南路3号（杏林青少年宫广场）",@"厦门市海沧区新阳街道兴盛路19号5号楼6层"];
    CinemaModel *cinemaModel = [[CinemaModel alloc]init];
    for (int i = 0; i < 10; i++ ) {
        
        cinemaModel.cinemaName = [cinemaNameArr objectAtIndex:i];
        cinemaModel.cinemaAdress = [cinemaAdressArr objectAtIndex:i];
        cinemaModel.cinemaLowPrice = arc4random_uniform(40)+30;
        cinemaModel.cinemaMovieNumb = 8;
        cinemaModel.cinemaSessionNumb = arc4random_uniform(10)+20;
        cinemaModel.cinemaDistrict = [[cinemaAdressArr objectAtIndex:i] substringWithRange:NSMakeRange(3, 3)];  //根据位置和长度获取字符串中的某一段字符
        cinemaModel.cinemaDistance = (float)(4.0+(i/1.0/(i+3)));
        cinemaModel.cinemaPhone = @"188505047061";
        cinemaModel.cinemaImageName = [NSString stringWithFormat:@"cinema0%d",i+1];

        [cinemaData insertUsersData:cinemaModel];
        
    }
    
    
    
    
    NSUserDefaults *userDefau = [NSUserDefaults standardUserDefaults];
    [userDefau setBool:YES forKey:@"haveAddData"];



}

@end
