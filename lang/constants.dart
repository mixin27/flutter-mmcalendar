const languages = [
  [
    "Myanmar Year",
    "မြန်မာနှစ်",
    "ျမန္မာႏွစ္",
    "သက္ကရာဇ်ဍုၚ်",
    "ပီ​​ၵေႃးၸႃႇ",
    "ကီၢ်ပယီၤ",
  ],
  [
    "Good Friday",
    "သောကြာနေ့ကြီး",
    "ေသာၾကာေန႔ႀကီး",
    "သောကြာနေ့ကြီး",
    "ဢၼ်လီဝၼ်းသုၵ်",
    "မုၢ်ဖီဖး",
  ],
  ["New Year's", "နှစ်ဆန်း", "ႏွစ္ဆန္း", "လှာဲသၞာံ", "ပီမႂ်ႇ", "နှစ်ဆန်း"],
  [
    "Independence",
    "လွတ်လပ်ရေး",
    "လြတ္လပ္ေရး",
    "သၠးပွး",
    "ဢၼ်လွတ်ႈလႅဝ်",
    "လွတ်လပ်ရေး",
  ],
  [
    "Union",
    "ပြည်ထောင်စု",
    "ျပည္ေထာင္စု",
    "ကၟိန်ဍုၚ်",
    "ၸိုင်ႈမိူင်းႁူမ်ႈတုမ်ႊ",
    "ပြည်ထောင်စု",
  ],
  [
    "Peasants'",
    "တောင်သူလယ်သမား",
    "ေတာင္သူလယ္သမား",
    "သၟာဗ္ၚ",
    "ၸဝ်ႈႁႆႈၸဝ်ႈၼႃး",
    "တောင်သူလယ်သမား",
  ],
  [
    "Resistance",
    "တော်လှန်ရေး",
    "ေတာ္လွန္ေရး",
    "ပၠန်ဂတးဗၟာ",
    "လွင်ႈလုၵ်ႉၽိုၼ်",
    "တော်လှန်ရေး",
  ],
  [
    "Labour",
    "အလုပ်သမား",
    "အလုပ္သမား",
    "သၟာကမၠောန်",
    "ၵူၼ်းႁဵတ်းၵၢၼ်",
    "အလုပ်သမား",
  ],
  ["Martyrs'", "အာဇာနည်", "အာဇာနည္", "အာဇာနဲ", "ၽူႈႁတ်းငၢၼ်", "အာဇာနည်"],
  [
    "Christmas",
    "ခရစ္စမတ်",
    "ခရစၥမတ္",
    "ခရေဿမာတ်",
    "ပွႆးၶရိတ်ႉသမတ်ႉၸ်",
    "ခရံာ်အိၣ်ဖျဲၣ်မူးပွဲန့ၣ်",
  ],
  ["Buddha", "ဗုဒ္ဓ", "ဗုဒၶ", "သ္ဘၚ်ဖဍာ်ဇြဲ", "ပုတ်ႉထ", "ဗုဒ္ဓ"],
  [
    "Start of Buddhist Lent",
    "ဓမ္မစကြာနေ့",
    "ဓမၼစၾကာေန႔",
    "တ္ၚဲတွံဓဝ်ဓမ္မစက်",
    "ဓမ္မစကြာနေ့",
    "ဓမ္မစကြာနေ့",
  ],
  [
    "End of Buddhist Lent",
    "မီးထွန်းပွဲ",
    "မီးထြန္းပြဲ",
    "တ္ၚဲအဘိဓရ်",
    "ပွႆတႆႈၾႆး",
    "မီးထွန်းပွဲ",
  ],
  [
    "Tazaungdaing",
    "တန်ဆောင်တိုင်",
    "တန္ေဆာင္တိုင္",
    "သ္ဘၚ်ပူဇဴပၟတ်ပၞာၚ်",
    "တန်ဆောင်တိုင်",
    "တန်ဆောင်တိုင်",
  ],
  [
    "National",
    "အမျိုးသား",
    "အမ်ိဳးသား",
    "ကောန်ဂကူဗၟာ",
    "ၵူၼ်းမိူင်",
    "အမျိုးသား",
  ],
  ["Karen", "ကရင်", "ကရင္", "ကရေၚ်", "ယၢင်းၽိူၵ်ႇ", "ကရင်"],
  ["Pwe", "ပွဲ", "ပြဲ", "သ္ဘၚ်", "ပွႆ", "ပွဲ"],
  ["Thingyan", "သင်္ကြန်", "သၾကၤန္", "အတး", "သၢင်းၵျၢၼ်ႇ", "သင်္ကြန်"],
  ["Akyo", "အကြို", "အႀကိဳ", "ဒစး", "အကြို", "ႁပ်ႉ"],
  ["Akyat", "အကြတ်", "အၾကတ္", "ကြာပ်", "ၵျၢပ်ႈ", "အကြတ်"],
  ["Akya", "အကျ", "အက်", "စှေ်", "တူၵ်း", "အကျ"],
  ["Atat", "အတက်", "အတက္", "တိုန်", "ၶိုၼ်ႈ", "အတက်"],
  [
    "Amyeittasote",
    "အမြိတ္တစုတ်",
    "အၿမိတၱစုတ္",
    "ကိုန်အမြိုတ်",
    "အမြိတ္တစုတ်",
    "အမြိတ္တစုတ်",
  ],
  [
    "Warameittugyi",
    "ဝါရမိတ္တုကြီး",
    "ဝါရမိတၱဳႀကီး",
    "ကိုန်ဝါရမိတ္တုဇၞော်",
    "ဝါရမိတ္တုကြီး",
    "ဝါရမိတ္တုကြီး",
  ],
  [
    "Warameittunge",
    "ဝါရမိတ္တုငယ်",
    "ဝါရမိတၱဳငယ္",
    "ကိုန်ဝါရမိတ္တုဍောတ်",
    "ဝါရမိတ္တုငယ်",
    "ဝါရမိတ္တုငယ်",
  ],
  ["Thamaphyu", "သမားဖြူ", "သမားျဖဴ", "ကိုန်လေၚ်ဒိုက်", "သမားဖြူ", "သမားဖြူ"],
  ["Thamanyo", "သမားညို", "သမားညိဳ", "ကိုန်ဟုံဗြမ်", "သမားညို", "သမားညို"],
  ["Yatpote", "ရက်ပုပ်", "ရက္ပုပ္", "ကိုန်လီုလာ်", "ရက်ပုပ်", "ရက်ပုပ်"],
  [
    "Yatyotema",
    "ရက်ယုတ်မာ",
    "ရက္ယုတ္မာ",
    "ကိုန်ယုတ်မာ",
    "ရက်ယုတ်မာ",
    "ရက်ယုတ်မာ",
  ],
  [
    "Mahayatkyan",
    "မဟာရက်ကြမ်း",
    "မဟာရက္ၾကမ္း",
    "ကိုန်ဟွံခိုဟ်",
    "မဟာရက်ကြမ်း",
    "မဟာရက်ကြမ်း",
  ],
  ["Nagapor", "နဂါးပေါ်", "နဂါးေပၚ", "နာ်မံက်", "နဂါးပေါ်", "နဂါးပေါ်"],
  ["Shanyat", "ရှမ်းရက်", "ရွမ္းရက္", "တ္ၚဲဒတန်", "ရှမ်းရက်", "ရှမ်းရက်"],
  ["Mooon", "မွန်", "မြန္", "ပၠန်", "မွၼ်း", "မွန်"],
  [
    "G. Aung San BD",
    "ဗိုလ်ချုပ်မွေးနေ့",
    "ဗိုလ္ခ်ဳပ္ေမြးေန႔",
    "တ္ၚဲသၟိၚ်ဗၟာ အံၚ်သာန်ဒှ်မၞိဟ်",
    "ဝၼ်းၵိူတ်ၸွမ်သိုၵ်",
    "ဗိုလ်ချုပ်မွေးနေ့",
  ],
  [
    "Valentines",
    "ချစ်သူများ",
    "ခ်စ္သူမ်ား",
    "ဝုတ်ဗၠာဲ",
    "ၵေႃႈႁၵ်ႉ",
    "ချစ်သူများ",
  ],
  ["Earth", "ကမ္ဘာမြေ", "ကမၻာေျမ", "ဂၠးကဝ်", "လိၼ်မိူင်း", "ကမ္ဘာမြေ"],
  [
    "April Fools'",
    "ဧပြီအရူး",
    "ဧၿပီအ႐ူး",
    "သ္ပပရအ်",
    "ဢေႇပရႄႇၵူၼ်းယွင်ႇ",
    "အ့ဖြ့ၣ် fool",
  ],
  [
    "Red Cross",
    "ကြက်ခြေနီ",
    "ၾကက္ေျခနီ",
    "ဇိုၚ်ခ္ဍာ်ဍာဲ",
    "ဢၼ်မီးသီလႅင်ႁၢင်ႈၶႂၢႆႇၶႃပေ",
    "ကြက်ခြေနီ",
  ],
  [
    "United Nations",
    "ကုလသမ္မဂ္ဂ",
    "ကုလသမၼဂၢ",
    "ကုလသမ္မဂ္ဂ",
    "ဢၼ်ၽွမ်ႉႁူမ်ႈၸိူဝ်ႉၶိူဝ်းၼမ်",
    "ကုလသမ္မဂ္ဂ",
  ],
  ["Halloween", "သရဲနေ့", "သရဲေန႔", "ဟေဝ်လဝ်ဝိန်", "ဝၼ်းၽဵတ်", "သရဲနေ့"],
  ["Shan", "ရှမ်း", "ရွမ္း", "သေံ", "တႆး", "ရှမ်း"],
  ["Mothers'", "အမေများ", "အေမမ်ား", "မိအံက်", "မႄႈ", "မိၢ်အ"],
  ["Fathers'", "အဖေများ", "အေဖမ်ား", "မအံက်", "ပေႃ", "ပၢ်အ"],
  [
    "Sasana Year",
    "သာသနာနှစ်",
    "သာသနာႏွစ္",
    "သက္ကရာဇ်သာသနာ",
    "ပီသႃႇသၼႃႇ",
    "နံၣ်သာသနာ",
  ],
  ["Eid", "အိဒ်", "အိဒ္", "အိဒ်", "အိဒ်", "အိဒ်"],
  ["Diwali", "ဒီဝါလီ", "ဒီဝါလီ", "ဒီဝါလီ", "ဒီဝါလီ", "ဒီဝါလီ"],
  ["Mahathamaya", "မဟာသမယ", "မဟာသမယ", "မဟာသမယ", "ဢၼ်ယႂ်ႇၽွမ်ႉႁူမ်ႈ", "မဟာသမယ"],
  ["Garudhamma", "ဂရုဓမ္မ", "ဂ႐ုဓမၼ", "ဂရုဓမ္မ", "ဂရုဓမ္မ", "ဂရုဓမ္မ"],
  ["Metta", "မေတ္တာ", "ေမတၱာ", "မေတ္တာ", "မႅတ်ႉတႃႇ", "မေတ္တာ"],
  [
    "Taungpyone",
    "တောင်ပြုန်း",
    "ေတာင္ျပဳန္း",
    "တောင်ပြုန်း",
    "တောင်ပြုန်း",
    "တောင်ပြုန်း",
  ],
  ["Yadanagu", "ရတနာ့ဂူ", "ရတနာ့ဂူ", "ရတနာ့ဂူ", "ရတနာ့ဂူ", "ရတနာ့ဂူ"],
  [
    "Authors'",
    "စာဆိုတော်",
    "စာဆိုေတာ္",
    "စာဆိုတော်",
    "ၽူႈတႅမ်ႈၽႅၼ်",
    "စာဆိုတော်",
  ],
  ["World", "ကမ္ဘာ့", "ကမၻာ့", "ကမ္ဘာ့", "လူၵ်", "ကမ္ဘာ့"],
  ["Teachers'", "ဆရာများ", "ဆရာမ်ား", "ဆရာများ", "ၶူးသွၼ်", "ဆရာများ"],
  [
    "Holiday",
    "ရုံးပိတ်ရက်",
    "႐ုံးပိတ္ရက္",
    "ရုံးပိတ်ရက်",
    "ဝၼ်းပိၵ်ႉလုမ်း",
    "ရုံးပိတ်ရက်",
  ],
  ["Chinese", "တရုတ်", "တ႐ုတ္", "တရုတ်", "ၵူၼ်းၸၢဝ်းၶေ", "တရုတ်"],
  [
    "Easter",
    "ထမြောက်ရာနေ့",
    "ထေျမာက္ရာေန႔",
    "ထမြောက်ရာနေ့",
    "ပၢင်ႇပွႆးၶွပ်ႈၶူပ်ႇၸဝ်ႈၶရိတ်",
    "ထမြောက်ရာနေ့",
  ],
  ["0", "၀", "၀", "၀", "0", "၀"],
  ["1", "၁", "၁", "၁", "1", "၁"],
  ["2", "၂", "၂", "၂", "2", "၂"],
  ["3", "၃", "၃", "၃", "3", "၃"],
  ["4", "၄", "၄", "၄", "4", "၄"],
  ["5", "၅", "၅", "၅", "5", "၅"],
  ["6", "၆", "၆", "၆", "6", "၆"],
  ["7", "၇", "၇", "၇", "7", "၇"],
  ["8", "၈", "၈", "၈", "8", "၈"],
  ["9", "၉", "၉", "၉", "9", "၉"],
  ["Sunday", "တနင်္ဂနွေ", "တနဂၤေႏြ", "တ္ၚဲအဒိုတ်", "ဝၼ်းဢႃးတိတ်ႉ", "မုၢ်ဒဲး"],
  ["Monday", "တနင်္လာ", "တနလၤာ", "တ္ၚဲစန်", "ဝၼ်းၸၼ်", "မုၢ်ဆၣ်"],
  ["Tuesday", "အင်္ဂါ", "အဂၤါ", "တ္ၚဲအင္ၚာ", "ဝၼ်းဢၢင်းၵၢၼ်း", "မုၢ်ယူာ်"],
  ["Wednesday", "ဗုဒ္ဓဟူး", "ဗုဒၶဟူး", "တ္ၚဲဗုဒ္ဓဝါ", "ဝၼ်းပုတ်ႉ", "မုၢ်ပျဲၤ"],
  ["Thursday", "ကြာသပတေး", "ၾကာသပေတး", "တ္ၚဲဗြဴဗတိ", "ဝၼ်းၽတ်း", "မုၢ်လ့ၤဧိၤ"],
  [
    "Friday",
    "သောကြာ",
    "ေသာၾကာ",
    "သောကြာ",
    "တ္ၚဲသိုက်",
    "ဝၼ်းသုၵ်း",
    "မုၢ်ဖီဖး",
  ],
  ["Saturday", "စနေ", "စေန", "တ္ၚဲသ္ၚိသဝ်", "ဝၼ်းသဝ်", "မုၢ်ဘူၣ်"],
  ["Sabbath Eve", "အဖိတ်", "အဖိတ္", "တ္ၚဲတိၚ်", "ၽိတ်ႈ", "အဖိတ်"],
  ["Sabbath", "ဥပုသ်", "ဥပုသ္", "တ္ၚဲသဳ", "သိၼ်", "အိၣ်ဘှံး"],
  ["Yatyaza", "ရက်ရာဇာ", "ရက္ရာဇာ", "တ္ၚဲရာဇာ", "ဝၼ်းထုၼ်း", "ရက်ရာဇာ"],
  ["Pyathada", "ပြဿဒါး", "ျပႆဒါး", "တ္ၚဲပြာဗ္ဗဒါ", "ဝၼ်းပျၢတ်ႈ", "ပြဿဒါး"],
  ["Afternoon", "မွန်းလွဲ", "မြန္းလြဲ", "မွန်းလွဲ", "ဝၢႆးဝၼ်း", "မွန်းလွဲ"],
  [
    "January",
    "ဇန်နဝါရီ",
    "ဇန္နဝါရီ",
    "ဂျာန်နျူအာရဳ",
    "ၸၼ်ႇဝႃႇရီႇ",
    "ယနူၤအါရံၤ",
  ],
  [
    "February",
    "ဖေဖော်ဝါရီ",
    "ေဖေဖာ္ဝါရီ",
    "ဝှေဝ်ဗျူအာရဳ",
    "ၾႅပ်ႉဝႃႇရီႇ",
    "ဖ့ၤဘြူၤအါရံၤ",
  ],
  ["March", "မတ်", "မတ္", "မာတ်ချ်", "မျၢတ်ႉၶျ်", "မၢ်ၡး"],
  ["April", "ဧပြီ", "ဧၿပီ", "ဨပြေယ်လ်", "ဢေႇပရႄႇ", "အ့ဖြ့ၣ်"],
  ["May", "မေ", "ေမ", "မေ", "မေ", "မ့ၤ"],
  ["June", "ဇွန်", "ဇြန္", "ဂျုန်", "ၵျုၼ်ႇ", "ယူၤ"],
  ["July", "ဇူလိုင်", "ဇူလိုင္", "ဂျူလာၚ်", "ၵျူႇလၢႆႇ", "ယူၤလံ"],
  ["August", "ဩဂုတ်", "ဩဂုတ္", "အဝ်ဂါတ်", "ဢေႃးၵၢတ်ႉ", "အီကူး"],
  [
    "September",
    "စက်တင်ဘာ",
    "စက္တင္ဘာ",
    "သိတ်ထီဗာ",
    "သႅပ်ႇထႅမ်ႇပႃႇ",
    "စဲးပတ့ဘၢၣ်",
  ],
  [
    "October",
    "အောက်တိုဘာ",
    "ေအာက္တိုဘာ",
    "အံက်ထဝ်ဗာ",
    "ဢွၵ်ႇထူဝ်ႇပႃႇ",
    "အီးကထိဘၢၣ်",
  ],
  [
    "November",
    "နိုဝင်ဘာ",
    "နိုဝင္ဘာ",
    "နဝ်ဝါမ်ဗာ",
    "ၼူဝ်ႇဝႅမ်ႇပႃႇ",
    "နိၣ်ဝ့ဘၢၣ်",
  ],
  ["December", "ဒီဇင်ဘာ", "ဒီဇင္ဘာ", "ဒီဇြေန်ဗာ", "တီႇသႅမ်ႇပႃႇ", "ဒံၣ်စ့ဘၢၣ်"],
  ["Tagu", "တန်ခူး", "တန္ခူး", "ဂိတုစဲ", "ႁႃႈ", "လါချံ"],
  ["Kason", "ကဆုန်", "ကဆုန္", "ဂိတုပသာ်", "ႁူၵ်း", "ဒ့ၣ်ညါ"],
  ["Nayon", "နယုန်", "နယုန္", "ဂိတုဇှေ်", "ၸဵတ်း", "လါနွံ"],
  ["Waso", "ဝါဆို", "ဝါဆို", "ဂိတုဒ္ဂိုန်", "ပႅတ်ႇ", "လါဃိး"],
  ["Wagaung", "ဝါခေါင်", "ဝါေခါင္", "ဂိတုခ္ဍဲသဳ", "ၵဝ်ႈ", "လါခူး"],
  ["Tawthalin", "တော်သလင်း", "ေတာ္သလင္း", "ဂိတုဘတ်", "သိပ်း", "ဆံးမုၢ်"],
  [
    "Thadingyut",
    "သီတင်းကျွတ်",
    "သီတင္းကြ်တ္",
    "ဂိတုဝှ်",
    "သိပ်းဢဵတ်း",
    "ဆံးဆၣ်",
  ],
  [
    "Tazaungmon",
    "တန်ဆောင်မုန်း",
    "တန္ေဆာင္မုန္း",
    "ဂိတုက္ထိုန်",
    "သိပ်းသွင်",
    "လါနီ",
  ],
  ["Nadaw", "နတ်တော်", "နတ္ေတာ္", "ဂိတုမြေက္ကသဵု", "ၸဵင်", "လါပျုၤ"],
  ["Pyatho", "ပြာသို", "ျပာသို", "ဂိတုပှော်", "ၵမ်", "သလ့ၤ"],
  ["Tabodwe", "တပို့တွဲ", "တပို႔တြဲ", "ဂိတုမာ်", "သၢမ်", "ထ့ကူး"],
  ["Tabaung", "တပေါင်း", "တေပါင္း", "ဂိတုဖဝ်ရဂိုန်", "သီႇ", "သွ့ကီ"],
  ["First", "ပ", "ပ", "ပ", "ပ", "၁ "],
  ["Second", "ဒု", "ဒု", "ဒု", "တု", "၂ "],
  ["Late", "နှောင်း", "ေႏွာင္း", "နှောင်း", "ဝၢႆး", "စဲၤ"],
  ["Waxing", "လဆန်း", "လဆန္း", "မံက်", "လိူၼ်မႂ်ႇ", "လါထီၣ်"],
  ["Waning", "လဆုတ်", "လဆုတ္", "စွေက်", "လိူၼ်လွင်ႈ", "လါလီၤ"],
  ["Full Moon", "လပြည့်", "လျပည့္", "ပေၚ်", "လိူၼ်မူၼ်း", "လါပှဲၤ"],
  ["New Moon", "လကွယ်", "လကြယ္", "အိုတ်", "လိူၼ်လပ်း", "လါဘၢ"],
  ["Nay", "နေ့", "ေန႔", "တ္ၚဲ", "ဝၼ်း", "နံၤ"],
  ["Day", "နေ့", "ေန႔", "တ္ၚဲ", "ဝၼ်း", "နံၤ"],
  ["Yat", "ရက်", "ရက္", "ရက်", "ဝၼ်း", "ရက်"],
  ["Year", "နှစ်", "ႏွစ္", "နှစ်", "ပီ", "နံၣ်"],
  ["Ku", "ခု", "ခု", "သၞာံ", "ၶု", ""],
  ["Naga", "နဂါး", "နဂါး", "နဂါး", "ႁူဝ်", "နဂါး"],
  ["Head", "ခေါင်း", "ေခါင္း", "ခေါင်း", "ၼၵႃး", "ခေါင်း"],
  ["Facing", "လှည့်", "လွည့္", "လှည့်", "ဝၢႆႇ", "လှည့်"],
  ["East", "အရှေ့", "အေရွ႕", "အရှေ့", "တၢင်းဢွၵ်ႇ", "အရှေ့"],
  ["West", "အနောက်", "အေနာက္", "အနောက်", "တၢင်းတူၵ်း", "အနောက်"],
  ["South", "တောင်", "ေတာင္", "တောင်", "တၢင်းၸၢၼ်း", "တောင်"],
  ["North", "မြောက်", "ေျမာက္", "မြောက်", "တၢင်းႁွင်ႇ", "မြောက်"],
  ["Mahabote", "မဟာဘုတ်", "မဟာဘုတ္", "မဟာဘုတ်", "မဟာဘုတ်", "မဟာဘုတ်"],
  ["Born", "ဖွား", "ဖြား", "ဖွား", "ဢၼ်မီးပႃႇရမီ", "ဖွား"],
  ["Binga", "ဘင်္ဂ", "ဘဂၤ", "ဘင်္ဂ", "ဘင်္ဂ", "ဘင်္ဂ"],
  ["Atun", "အထွန်း", "အထြန္း", "အထွန်း", "အထွန်း", "အထွန်း"],
  ["Yaza", "ရာဇ", "ရာဇ", "ရာဇ", "ရာဇ", "ရာဇ"],
  ["Adipati", "အဓိပတိ", "အဓိပတိ", "အဓိပတိ", "အဓိပတိ", "အဓိပတိ"],
  ["Marana", "မရဏ", "မရဏ", "မရဏ", "မရဏ", "မရဏ"],
  ["Thike", "သိုက်", "သိုက္", "သိုက်", "သိုက်", "သိုက်"],
  ["Puti", "ပုတိ", "ပုတိ", "ပုတိ", "ပုတိ", "ပုတိ"],
  ["Ogre", "ဘီလူး", "ဘီလူး", "ဘီလူး", "ၽီလူ", "ဘီလူး"],
  ["Elf", "နတ်", "နတ္", "နတ်", "ၽီမႅၼ်းဢွၼ်", "နတ်"],
  ["Human", "လူ", "လူ", "လူ", "ဢၼ်ပဵၼ်ၵူၼ်", "လူ"],
  ["Nakhat", "နက္ခတ်", "နကၡတ္", "နက္ခတ်", "လႅင်ႊလၢဝ်", "နက္ခတ်"],
  ["Hpusha", "ပုဿ", "ပုႆ", "ပုဿ", "ပုဿ", "ပုဿ"],
  ["Magha", "မာခ", "မာခ", "မာခ", "မာခ", "မာခ"],
  ["Phalguni", "ဖ္လကိုန်", "ဖႅကိုန္", "ဖ္လကိုန်", "ဖ္လကိုန်", "ဖ္လကိုန်"],
  ["Chitra", "စယ်", "စယ္", "စယ်", "စယ်", "စယ်"],
  ["Visakha", "ပိသျက်", "ပိသ်က္", "ပိသျက်", "ပိသျက်", "ပိသျက်"],
  ["Jyeshtha", "စိဿ", "စိႆ", "စိဿ", "စိဿ", "စိဿ"],
  ["Ashadha", "အာသတ်", "အာသတ္", "အာသတ်", "အာသတ်", "အာသတ်"],
  ["Sravana", "သရဝန်", "သရဝန္", "သရဝန်", "သရဝန်", "သရဝန်"],
  ["Bhadrapaha", "ဘဒြ", "ဘျဒ", "ဘဒြ", "ဘဒြ", "ဘဒြ"],
  ["Asvini", "အာသိန်", "အာသိန္", "အာသိန်", "အာသိန်", "အာသိန်"],
  ["Krittika", "ကြတိုက်", "ၾကတိုက္", "ကြတိုက်", "ကြတိုက်", "ကြတိုက်"],
  [
    "Mrigasiras",
    "မြိက္ကသိုဝ်",
    "ၿမိကၠသိုဝ္",
    "မြိက္ကသိုဝ်",
    "မြိက္ကသိုဝ်",
    "မြိက္ကသိုဝ်",
  ],
  ["Calculator", "တွက်စက်", "တြက္စက္", "တွက်စက်", "သွၼ်", "တွက်စက်"],
  //[". ","။ ","။ ","။ ","။ ","။ "],
  //[", ","၊ ","၊ ","၊ ","၊ ","၊ "],
];

const rulers = [
  {
    "name": "Popa Sawrahan (ပုပ္ပားစောရဟန်း)",
    "beginning_jdn": 1944957,
    "ending_jdn": 1954904,
    "dynasty": "Early_Pagan",
    "url":
        "https://my.wikipedia.org/wiki/%E1%80%95%E1%80%AF%E1%80%95%E1%80%B9%E1%80%95%E1%80%AB%E1%80%B8_%E1%80%85%E1%80%B1%E1%80%AC%E1%80%9B%E1%80%9F%E1%80%94%E1%80%BA%E1%80%B8",
  },
  {
    "name": "Shwe Ohnthi (ရွှေအုန်းသီး)",
    "beginning_jdn": 1954904,
    "ending_jdn": 1959201,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Peit Thon (ပိတ်သုံ)",
    "beginning_jdn": 1959201,
    "ending_jdn": 1962123,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Peit Taung (ပိတ်တောင်း)",
    "beginning_jdn": 1962123,
    "ending_jdn": 1980386,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Min Khwe (စောခွေး)",
    "beginning_jdn": 1980386,
    "ending_jdn": 1982577,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Myingyway (မြင်းကျွေး)",
    "beginning_jdn": 1982577,
    "ending_jdn": 1986230,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Theinga (သိန်ခဲ)",
    "beginning_jdn": 1986230,
    "ending_jdn": 1989152,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Thein Khun (သိန်ခွန်)",
    "beginning_jdn": 1989152,
    "ending_jdn": 1992804,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Shwe Laung (ရွှေလောင်း)",
    "beginning_jdn": 1992804,
    "ending_jdn": 1996092,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Htun Htwin (ထွန်တွင်း)",
    "beginning_jdn": 1996092,
    "ending_jdn": 1999379,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Shwe Hmauk (ရွှေမှောက်)",
    "beginning_jdn": 1999379,
    "ending_jdn": 2007780,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Htun Lut (ထွန်လတ်)",
    "beginning_jdn": 2007780,
    "ending_jdn": 2013989,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Saw Khin Hnit (စောခင်နှစ်)",
    "beginning_jdn": 2013989,
    "ending_jdn": 2023851,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Khe Lu (ခဲလူး)",
    "beginning_jdn": 2023851,
    "ending_jdn": 2030060,
    "dynasty": "Early_Pagan",
    "url":
        "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom#Middle_Early_Pagan",
  },
  {
    "name": "Pyinbya (ပျဉ်ပြား)",
    "beginning_jdn": 2030060,
    "ending_jdn": 2044670,
    "dynasty": "Early_Pagan",
    "url": "https://en.wikipedia.org/wiki/Pyinbya",
  },
  {
    "name": "Tannet (တန်နက်)",
    "beginning_jdn": 2044670,
    "ending_jdn": 2051244,
    "dynasty": "Early_Pagan",
    "url": "https://en.wikipedia.org/wiki/Tannet_of_Pagan",
  },
  {
    "name": "Sale Ngahkwe (စလေငခွေး)",
    "beginning_jdn": 2051244,
    "ending_jdn": 2062202,
    "dynasty": "Early_Pagan",
    "url": "https://en.wikipedia.org/wiki/Sale_Ngahkwe",
  },
  {
    "name": "Theinhko (သိန်းခို)",
    "beginning_jdn": 2062202,
    "ending_jdn": 2070237,
    "dynasty": "Early_Pagan",
    "url": "https://en.wikipedia.org/wiki/Theinhko",
  },
  {
    "name":
        "Nyaung-u Sawrahan [Cucumber King] (ညောင်ဦး စောရဟန်း [တောင်သူကြီးမင်း])",
    "beginning_jdn": 2070237,
    "ending_jdn": 2086674,
    "dynasty": "Early_Pagan",
    "url": "https://en.wikipedia.org/wiki/Nyaung-u_Sawrahan",
  },
  {
    "name": "Kunhsaw Kyaunghpyu (ကွမ်းဆော် ကြောင်းဖြူ)",
    "beginning_jdn": 2086674,
    "ending_jdn": 2093979,
    "dynasty": "Early_Pagan",
    "url": "https://en.wikipedia.org/wiki/Kunhsaw_Kyaunghpyu",
  },
  {
    "name": "Kyiso (ကျဉ်စိုး)",
    "beginning_jdn": 2093979,
    "ending_jdn": 2100278,
    "dynasty": "Early_Pagan",
    "url": "https://en.wikipedia.org/wiki/Kyiso",
  },
  {
    "name": "Sokkate (စုက္ကတေး)",
    "beginning_jdn": 2100278,
    "ending_jdn": 2102602,
    "dynasty": "Early_Pagan",
    "url": "https://en.wikipedia.org/wiki/Sokkate",
  },
  {
    "name": "Anawrahta Minsaw (အနော်ရထာ မင်းစော)",
    "beginning_jdn": 2102602,
    "ending_jdn": 2114533,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Anawrahta",
  },
  {
    "name": "Sawlu (စောလူး)",
    "beginning_jdn": 2114533,
    "ending_jdn": 2117100,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Sawlu",
  },
  {
    "name": "Kyansittha (ကျန်စစ်သား)",
    "beginning_jdn": 2117100,
    "ending_jdn": 2127582,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Kyansittha",
  },
  {
    "name": "Alaungsithu (အလောင်းစည်သူ)",
    "beginning_jdn": 2127582,
    "ending_jdn": 2147305,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Alaungsithu",
  },
  {
    "name": "Narathu (နရသူ)",
    "beginning_jdn": 2147305,
    "ending_jdn": 2148797,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Narathu",
  },
  {
    "name": "Naratheinkha (နရသိင်္ခ)",
    "beginning_jdn": 2148797,
    "ending_jdn": 2149982,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Naratheinkha",
  },
  {
    "name": "Narapati Sithu (နရပတိ စည်သူ)",
    "beginning_jdn": 2149982,
    "ending_jdn": 2163605,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Narapatisithu",
  },
  {
    "name": "Htilominlo (ထီးလိုမင်းလို)",
    "beginning_jdn": 2163605,
    "ending_jdn": 2172341,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Htilominlo",
  },
  {
    "name": "Naratheinga Uzana (နရသိင်္ဃ ဥဇနာ)",
    "beginning_jdn": 2170681,
    "ending_jdn": 2172341,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Naratheinga_Uzana",
  },
  {
    "name": "Kyaswa (ကျစွာ)",
    "beginning_jdn": 2172341,
    "ending_jdn": 2178106,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Kyaswa",
  },
  {
    "name": "Uzana (ဥဇနာ)",
    "beginning_jdn": 2178106,
    "ending_jdn": 2179938,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Uzana_of_Pagan",
  },
  {
    "name": "Narathihapate (နရသီဟပတေ့)",
    "beginning_jdn": 2179938,
    "ending_jdn": 2191316,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Narathihapate",
  },
  {
    "name": "Kyawswa (ကျော်စွာ)",
    "beginning_jdn": 2192015,
    "ending_jdn": 2195138,
    "dynasty": "Pagan",
    "url": "https://en.wikipedia.org/wiki/Kyawswa_of_Pagan",
  },
  {
    "name":
        "Co-rulers: Athinkhaya, Yazathingyan, Thihathu (အသင်္ခယာ၊ ရာဇသင်္ကြန်၊ သီဟသူ)",
    "beginning_jdn": 2195138,
    "ending_jdn": 2199638,
    "dynasty": "Myinsaing",
    "url": "https://en.wikipedia.org/wiki/Athinkhaya",
  },
  {
    "name": "Co-rulers: Yazathingyan, Thihathu (ရာဇသင်္ကြန်၊ သီဟသူ)",
    "beginning_jdn": 2199638,
    "ending_jdn": 2200669,
    "dynasty": "Myinsaing",
    "url": "https://en.wikipedia.org/wiki/Yazathingyan",
  },
  {
    "name": "Thihathu (သီဟသူ)",
    "beginning_jdn": 2200669,
    "ending_jdn": 2205046,
    "dynasty": "Pinya",
    "url": "https://en.wikipedia.org/wiki/Thihathu",
  },
  {
    "name": "Uzana I of Pinya (ပထမ ဥဇနာ [ပင်းယ])",
    "beginning_jdn": 2205046,
    "ending_jdn": 2210737,
    "dynasty": "Pinya",
    "url": "https://en.wikipedia.org/wiki/Uzana_I_of_Pinya",
  },
  {
    "name": "Sithu of Pinya [Myinsaing Sithu] (စည်သူ [မြင်စိုင်းစည်သူ])",
    "beginning_jdn": 2210737,
    "ending_jdn": 2212042,
    "dynasty": "Pinya",
    "url": "https://en.wikipedia.org/wiki/Sithu_of_Pinya",
  },
  {
    "name": "Ngarsishin Kyawswa (ငါးစီးရှင် ကျော်စွာ)",
    "beginning_jdn": 2212042,
    "ending_jdn": 2214491,
    "dynasty": "Pinya",
    "url": "https://en.wikipedia.org/wiki/Kyawswa_I_of_Pinya",
  },
  {
    "name": "Kyawswange (ကျော်စွာငယ်)",
    "beginning_jdn": 2214491,
    "ending_jdn": 2217520,
    "dynasty": "Pinya",
    "url": "https://en.wikipedia.org/wiki/Kyawswa_II_of_Pinya",
  },
  {
    "name": "Narathu of Pinya (နရသူ [ပင်းယ])",
    "beginning_jdn": 2217520,
    "ending_jdn": 2219411,
    "dynasty": "Pinya",
    "url": "https://en.wikipedia.org/wiki/Narathu_of_Pinya",
  },
  {
    "name": "Uzana Pyaung (ဥဇနာ ပြောင်)",
    "beginning_jdn": 2219411,
    "ending_jdn": 2219503,
    "dynasty": "Pinya",
    "url": "https://en.wikipedia.org/wiki/Uzana_II_of_Pinya",
  },
  {
    "name": "Athinhkaya Sawyun (အသင်္ခယာ စောယွမ်း)",
    "beginning_jdn": 2201496,
    "ending_jdn": 2205780,
    "dynasty": "Sagaing",
    "url": "https://en.wikipedia.org/wiki/Sawyun",
  },
  {
    "name": "Tarabyagyi (တရဖျားကြီး)",
    "beginning_jdn": 2205780,
    "ending_jdn": 2208667,
    "dynasty": "Sagaing",
    "url": "https://en.wikipedia.org/wiki/Tarabya_I_of_Sagaing",
  },
  {
    "name": "Thiri Thihathura Shwetaungtet (သီရိ သီဟသူရ ရွှေတောင်တက်)",
    "beginning_jdn": 2208667,
    "ending_jdn": 2210128,
    "dynasty": "Sagaing",
    "url": "https://en.wikipedia.org/wiki/Shwetaungtet",
  },
  {
    "name": "Kyaswa of Sagaing (ကျစွာ [စစ်ကိုင်း])",
    "beginning_jdn": 2210128,
    "ending_jdn": 2213415,
    "dynasty": "Sagaing",
    "url": "https://en.wikipedia.org/wiki/Kyaswa_of_Sagaing",
  },
  {
    "name": "Nawrahta Minye (နော်ရထာ မင်းရဲ)",
    "beginning_jdn": 2213415,
    "ending_jdn": 2214205,
    "dynasty": "Sagaing",
    "url": "https://en.wikipedia.org/wiki/Nawrahta_Minye",
  },
  {
    "name": "Tarabyange (တရဖျားငယ်)",
    "beginning_jdn": 2214205,
    "ending_jdn": 2214929,
    "dynasty": "Sagaing",
    "url": "https://en.wikipedia.org/wiki/Tarabya_II_of_Sagaing",
  },
  {
    "name": "Minbyauk Thihapate (မင်းပြောက် သီဟပတေ့)",
    "beginning_jdn": 2214929,
    "ending_jdn": 2219350,
    "dynasty": "Sagaing",
    "url": "https://en.wikipedia.org/wiki/Minbyauk_Thihapate",
  },
  {
    "name": "Thadominbya (သတိုးမင်းဖျား)",
    "beginning_jdn": 2219350,
    "ending_jdn": 2220602,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Thadominbya",
  },
  {
    "name": "Swasawke (စွာစော်ကဲ)",
    "beginning_jdn": 2220602,
    "ending_jdn": 2232499,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Swasawke",
  },
  {
    "name": "Tarabya of Ava (တရဖျား)",
    "beginning_jdn": 2232499,
    "ending_jdn": 2232737,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Tarabya_of_Ava",
  },
  {
    "name": "Minkhaung I (ပထမ မင်းခေါင်)",
    "beginning_jdn": 2232737,
    "ending_jdn": 2240475,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Minkhaung_I",
  },
  {
    "name": "Thihathu of Ava (သီဟသူ [အင်းဝ])",
    "beginning_jdn": 2240475,
    "ending_jdn": 2241752,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Thihathu_of_Ava",
  },
  {
    "name": "Minhlange (မင်းလှငယ်)",
    "beginning_jdn": 2241752,
    "ending_jdn": 2241844,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Minhlange",
  },
  {
    "name": "Kale Kyetaungnyo (ကလေး ကျေးတောင်ညို)",
    "beginning_jdn": 2241844,
    "ending_jdn": 2242044,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Kale_Kyetaungnyo",
  },
  {
    "name": "Mohnyin Thado (မိုးညှင်းသတိုး)",
    "beginning_jdn": 2242044,
    "ending_jdn": 2246773,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Mohnyin_Thado",
  },
  {
    "name": "Minyekyawswa of Ava (မင်းရဲကျော်စွာ [အင်းဝ])",
    "beginning_jdn": 2246773,
    "ending_jdn": 2247749,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Minyekyawswa_of_Ava",
  },
  {
    "name": "Narapati of Ava (နရပတိ [အင်းဝ])",
    "beginning_jdn": 2247749,
    "ending_jdn": 2257450,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Narapati_of_Ava",
  },
  {
    "name": "Thihathura of Ava (သီဟသူရ [အင်းဝ])",
    "beginning_jdn": 2257450,
    "ending_jdn": 2261841,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Thihathura_of_Ava",
  },
  {
    "name": "Minkhaung II (ဒုတိယ မင်းခေါင်)",
    "beginning_jdn": 2261841,
    "ending_jdn": 2269395,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Minkhaung_II",
  },
  {
    "name": "Thihathura II of Ava (ဒုတိယ သီဟသူရ [အင်းဝ])",
    "beginning_jdn": 2263455,
    "ending_jdn": 2269361,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Thihathura_II_of_Ava",
  },
  {
    "name": "Shwenankyawshin Narapati (ရွှေနန်းကြော့ရှင် နရပတိ)",
    "beginning_jdn": 2269395,
    "ending_jdn": 2278867,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Shwenankyawshin",
  },
  {
    "name": "Thohanbwa (သိုဟန်ဘွား)",
    "beginning_jdn": 2278867,
    "ending_jdn": 2284424,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Thohanbwa",
  },
  {
    "name": "Hkonmaing (ခုံမှိုင်း)",
    "beginning_jdn": 2284425,
    "ending_jdn": 2285613,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Hkonmaing",
  },
  {
    "name": "Mobye Narapati (မိုးဗြဲ နရပတိ)",
    "beginning_jdn": 2285613,
    "ending_jdn": 2287834,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Mobye_Narapati",
  },
  {
    "name": "Sithu Kyawhtin [Narapati Sithu] (စည်သူကျော်ထင် [နရပတိ စည်သူ])",
    "beginning_jdn": 2287834,
    "ending_jdn": 2289043,
    "dynasty": "Ava",
    "url": "https://en.wikipedia.org/wiki/Sithu_Kyawhtin",
  },
  {
    "name": "Thado Minsaw of Prome (သတိုးမင်းစော)",
    "beginning_jdn": 2262359,
    "ending_jdn": 2278430,
    "dynasty": "Prome",
    "url": "https://en.wikipedia.org/wiki/Thado_Minsaw_of_Prome",
  },
  {
    "name": "Bayin Htwe (ဘုရင်ထွေး)",
    "beginning_jdn": 2278430,
    "ending_jdn": 2280956,
    "dynasty": "Prome",
    "url": "https://en.wikipedia.org/wiki/Bayin_Htwe",
  },
  {
    "name": "Narapati of Prome (နရပတိ [ပြည်])",
    "beginning_jdn": 2280956,
    "ending_jdn": 2283209,
    "dynasty": "Prome",
    "url": "https://en.wikipedia.org/wiki/Narapati_of_Prome",
  },
  {
    "name": "Minkhaung of Prome ( မင်းခေါင် [ပြည်])",
    "beginning_jdn": 2283209,
    "ending_jdn": 2284412,
    "dynasty": "Prome",
    "url": "https://en.wikipedia.org/wiki/Minkhaung_of_Prome",
  },
  {
    "name": "Wareru (ဝါရီရူး)",
    "beginning_jdn": 2191228,
    "ending_jdn": 2198440,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Wareru",
  },
  {
    "name": "Hkun Law (ခွန်လော)",
    "beginning_jdn": 2198440,
    "ending_jdn": 2199960,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Hkun_Law",
  },
  {
    "name": "Saw O (စောအော)",
    "beginning_jdn": 2200000,
    "ending_jdn": 2204527,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Saw_O",
  },
  {
    "name": "Saw Zein (စောဇိတ်)",
    "beginning_jdn": 2204527,
    "ending_jdn": 2206931,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Saw_Zein",
  },
  {
    "name": "Zein Pun (ဇိတ်ပွန်)",
    "beginning_jdn": 2206931,
    "ending_jdn": 2206938,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Zein_Pun",
  },
  {
    "name": "Saw E (စောအဲ)",
    "beginning_jdn": 2206938,
    "ending_jdn": 2206961,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Saw_E",
  },
  {
    "name": "Binnya E Law (ဗညားအဲလော)",
    "beginning_jdn": 2206961,
    "ending_jdn": 2213415,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Binnya_E_Law",
  },
  {
    "name": "Binnya U (ဗညားဦး)",
    "beginning_jdn": 2213415,
    "ending_jdn": 2226567,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Binnya_U",
  },
  {
    "name": "Razadarit (ရာဇာဓိရာဇ်)",
    "beginning_jdn": 2226567,
    "ending_jdn": 2240110,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Razadarit",
  },
  {
    "name": "Binnya Dhammaraza (ဗညားဓမ္မရာဇာ)",
    "beginning_jdn": 2240110,
    "ending_jdn": 2241174,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Binnya_Dhammaraza",
  },
  {
    "name": "Binnya Ran I (ပထမ ဗညားရံ)",
    "beginning_jdn": 2241174,
    "ending_jdn": 2249210,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Binnya_Ran_I",
  },
  {
    "name": "Binnya Waru (ဗညားဗရူး)",
    "beginning_jdn": 2249210,
    "ending_jdn": 2251185,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Binnya_Waru",
  },
  {
    "name": "Binnya Kyan (ဗညားကျန်း)",
    "beginning_jdn": 2251185,
    "ending_jdn": 2251918,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Binnya_Kyan",
  },
  {
    "name": "Leik Munhtaw (လိပ်မွတ်ထော)",
    "beginning_jdn": 2251918,
    "ending_jdn": 2252132,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Leik_Munhtaw",
  },
  {
    "name": "Shin Sawbu (ရှင်စောပု)",
    "beginning_jdn": 2252132,
    "ending_jdn": 2258341,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Shin_Sawbu",
  },
  {
    "name": "Dhammazedi (ဓမ္မစေတီ)",
    "beginning_jdn": 2258341,
    "ending_jdn": 2266011,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Dhammazedi",
  },
  {
    "name": "Binnya Ran II (ဒုတိယ ဗညားရံ)",
    "beginning_jdn": 2266011,
    "ending_jdn": 2278430,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Binnya_Ran_II",
  },
  {
    "name": "Takayutpi (သုရှင်တကာရွတ်ပိ)",
    "beginning_jdn": 2278430,
    "ending_jdn": 2283178,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Takayutpi",
  },
  {
    "name": "Smim Sawhtut (သမိန်စောထွတ်)",
    "beginning_jdn": 2287347,
    "ending_jdn": 2287408,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Smim_Sawhtut",
  },
  {
    "name": "Smim Htaw (သမိန်ထော)",
    "beginning_jdn": 2287408,
    "ending_jdn": 2287997,
    "dynasty": "Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Smim_Htaw",
  },
  {
    "name": "Narameikhla Min Saw Mon(နရမိတ်လှ မင်းစောမွန်)",
    "beginning_jdn": 2243108,
    "ending_jdn": 2244590,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Saw_Mon",
  },
  {
    "name": "Min Khayi(မင်းခရီ)",
    "beginning_jdn": 2244590,
    "ending_jdn": 2253958,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Khayi",
  },
  {
    "name": "Ba Saw Phyu(ဘစောဖြူ)",
    "beginning_jdn": 2253958,
    "ending_jdn": 2262575,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Ba_Saw_Phyu",
  },
  {
    "name": "Min Dawlya(မင်းဒေါလျာ)",
    "beginning_jdn": 2262575,
    "ending_jdn": 2266042,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Dawlya",
  },
  {
    "name": "Ba Saw Nyo(ဘစောညို)",
    "beginning_jdn": 2266042,
    "ending_jdn": 2266742,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Ba_Saw_Nyo",
  },
  {
    "name": "Min Ran Aung(မင်းရန်အောင်)",
    "beginning_jdn": 2266742,
    "ending_jdn": 2266923,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Ran_Aung",
  },
  {
    "name": "Salingathu(စလင်္ကာသူ)",
    "beginning_jdn": 2266923,
    "ending_jdn": 2269701,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Salingathu",
  },
  {
    "name": "Min Raza(မင်းရာဇာ)",
    "beginning_jdn": 2269701,
    "ending_jdn": 2273986,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Raza_of_Mrauk-U",
  },
  {
    "name": "Gazapati(ဂဇာပတိ)",
    "beginning_jdn": 2273986,
    "ending_jdn": 2274412,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Gazapati",
  },
  {
    "name": "Min Saw O(မင်းစောအို)",
    "beginning_jdn": 2274412,
    "ending_jdn": 2274593,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Saw_O",
  },
  {
    "name": "Thazata(သဇာတ)",
    "beginning_jdn": 2274593,
    "ending_jdn": 2276694,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Thazata",
  },
  {
    "name": "Minkhaung of Mrauk-U(မင်းခေါင်)",
    "beginning_jdn": 2276694,
    "ending_jdn": 2280402,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Minkhaung_of_Mrauk-U",
  },
  {
    "name": "Min Bin(မင်းပင်၊ မင်းဗာကြီး)",
    "beginning_jdn": 2280402,
    "ending_jdn": 2288667,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Bin",
  },
  {
    "name": "Min Dikkha(မင်းတိက္ခာ)",
    "beginning_jdn": 2288667,
    "ending_jdn": 2289452,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Dikkha",
  },
  {
    "name": "Min Saw Hla(မင်းစောလှ)",
    "beginning_jdn": 2289452,
    "ending_jdn": 2292514,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Saw_Hla",
  },
  {
    "name": "Min Sekkya(မင်းစကြာ)",
    "beginning_jdn": 2292514,
    "ending_jdn": 2295268,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Sekkya",
  },
  {
    "name": "Min Phalaung(မင်းဖလောင်း)",
    "beginning_jdn": 2295268,
    "ending_jdn": 2303076,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Phalaung",
  },
  {
    "name": "Min Razagyi (မင်းရာဇာကြီး)",
    "beginning_jdn": 2303076,
    "ending_jdn": 2310016,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Razagyi",
  },
  {
    "name": "Min Khamaung (မင်းခမောင်း)",
    "beginning_jdn": 2303076,
    "ending_jdn": 2313617,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Khamaung",
  },
  {
    "name": "Thiri Thudhamma (သီရိသုဓမ္မ)",
    "beginning_jdn": 2313617,
    "ending_jdn": 2319476,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Thiri_Thudhamma",
  },
  {
    "name": "Min Sanay (မင်းစနေ)",
    "beginning_jdn": 2319476,
    "ending_jdn": 2319495,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Min_Sanay",
  },
  {
    "name": "Narapati of Mrauk-U (နရပတိ)",
    "beginning_jdn": 2319495,
    "ending_jdn": 2322231,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Narapati_of_Mrauk-U",
  },
  {
    "name": "Thado of Mrauk-U (သတိုဝ်မင်းတရား)",
    "beginning_jdn": 2322231,
    "ending_jdn": 2324562,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Thado_of_Mrauk-U",
  },
  {
    "name": "Sanda Thudhamma(စန္ဒသုဓမ္မရာဇာ)",
    "beginning_jdn": 2324562,
    "ending_jdn": 2332638,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Sanda_Thudhamma",
  },
  {
    "name": "Oaggar Bala(ဥဂ္ဂါဗလရာဇာ)",
    "beginning_jdn": 2332638,
    "ending_jdn": 2336600,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Oaggar Bala",
  },
  {
    "name": "Wara Dhammaraza(၀ရဓမ္မရာဇာ)",
    "beginning_jdn": 2336600,
    "ending_jdn": 2339222,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Wara_Dhammaraza",
  },
  {
    "name": "Muni Thudhammaraza(မဏိသုဓမ္မရာဇာ)",
    "beginning_jdn": 2339222,
    "ending_jdn": 2340135,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Muni_Thudhammaraza",
  },
  {
    "name": "Sanda Thuriya I(စန္ဒသုရိယ ၁)",
    "beginning_jdn": 2340135,
    "ending_jdn": 2340728,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Sanda_Thuriya_I",
  },
  {
    "name": "Nawrahta (ငတုံအနော်ရထာ)",
    "beginning_jdn": 2340728,
    "ending_jdn": 2340742,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Nawrahta_of_Mrauk-U",
  },
  {
    "name": "Mayuppiya (မဂုမ္မီယ)",
    "beginning_jdn": 2340742,
    "ending_jdn": 2341010,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Mayuppiya",
  },
  {
    "name": "Kalamandat (ကာလဗန္ဒလ)",
    "beginning_jdn": 2341010,
    "ending_jdn": 2341398,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Kalamandat",
  },
  {
    "name": "Naradipati I (ပထမ နာရာဓိပတိ)",
    "beginning_jdn": 2341398,
    "ending_jdn": 2342140,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Naradipati_I",
  },
  {
    "name": "Sanda Wimala I (ပထမ စန္ဒဝိမလရာဇာ)",
    "beginning_jdn": 2342141,
    "ending_jdn": 2344617,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Sanda_Wimala_I",
  },
  {
    "name": "Sanda Thuriya II (စန္ဒသုရိယရာဇာ ၂)",
    "beginning_jdn": 2344621,
    "ending_jdn": 2345868,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Sanda_Thuriya_II",
  },
  {
    "name": "Sanda Wizaya I (ပထမ စန္ဒဝိဇလရာဇာ)",
    "beginning_jdn": 2345929,
    "ending_jdn": 2353385,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Sanda_Wizaya_I",
  },
  {
    "name": "Sanda Thuriya III (စန္ဒသုရိယရာဇာ ၃)",
    "beginning_jdn": 2353385,
    "ending_jdn": 2354391,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Sanda_Thuriya_III",
  },
  {
    "name": "Naradipati II (နာရာဓိပတိ ၂)",
    "beginning_jdn": 2354391,
    "ending_jdn": 2354756,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Naradipati_II",
  },
  {
    "name": "Narapawara (နာရာပါဝရ)",
    "beginning_jdn": 2354756,
    "ending_jdn": 2355730,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Narapawara",
  },
  {
    "name": "Sanda Wizaya II (စန္ဒဝိဇလ ၂)",
    "beginning_jdn": 2355730,
    "ending_jdn": 2355935,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Sanda_Wizaya_II",
  },
  {
    "name": "Madarit (မဒရာဇ်ရာဇာ)",
    "beginning_jdn": 2355938,
    "ending_jdn": 2357714,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Madarit",
  },
  {
    "name": "Nara Apaya (နရာအဘယရာဇာ)",
    "beginning_jdn": 2357714,
    "ending_jdn": 2364553,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Nara_Apaya",
  },
  {
    "name": "Thirithu (သီရိသူ)",
    "beginning_jdn": 2364553,
    "ending_jdn": 2364651,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Thirithu",
  },
  {
    "name": "Sanda Parama (စန္ဒ၀ရမ)",
    "beginning_jdn": 2364651,
    "ending_jdn": 2365469,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Sanda_Parama",
  },
  {
    "name": "Apaya (အဘယ)",
    "beginning_jdn": 2365469,
    "ending_jdn": 2369017,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Apaya",
  },
  {
    "name": "Sanda Thumana (စန္ဒသုမန)",
    "beginning_jdn": 2369017,
    "ending_jdn": 2370221,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Sanda_Thumana",
  },
  {
    "name": "Sanda Wimala II (စန္ဒဝိမလ ၂)",
    "beginning_jdn": 2370221,
    "ending_jdn": 2370252,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Sanda_Wimala_II",
  },
  {
    "name": "Sanda Thaditha (စန္ဒသတိဿ)",
    "beginning_jdn": 2370252,
    "ending_jdn": 2372257,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Sanda_Thaditha",
  },
  {
    "name": "Maha Thammada (သမ္မတ)",
    "beginning_jdn": 2372258,
    "ending_jdn": 2373020,
    "dynasty": "Mrauk_U",
    "url": "https://en.wikipedia.org/wiki/Maha_Thammada_of_Mrauk-U",
  },
  {
    "name": "Mingyinyo(မင်းကြီးညို)",
    "beginning_jdn": 2272874,
    "ending_jdn": 2280218,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Mingyinyo",
  },
  {
    "name": "Tabinshwehti(တပင်‌ရွှေထီး)",
    "beginning_jdn": 2280218,
    "ending_jdn": 2287315,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Tabinshwehti",
  },
  {
    "name": "Bayinnaung Kyawhtin Nawrahta(ဘုရင့်နောင်ကျော်ထင်နော်ရထာ)",
    "beginning_jdn": 2287315,
    "ending_jdn": 2298801,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Bayinnaung",
  },
  {
    "name": "Nanda Bayin(နန္ဒဘုရင်)",
    "beginning_jdn": 2298801,
    "ending_jdn": 2305435,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Nanda_Bayin",
  },
  {
    "name": "Nyaungyan Min(ညောင်ရမ်းမင်း)",
    "beginning_jdn": 2305435,
    "ending_jdn": 2307583,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Nyaungyan_Min",
  },
  {
    "name": "Anaukpetlun(အနောက်ဖက်လွန်)",
    "beginning_jdn": 2307583,
    "ending_jdn": 2315865,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Anaukpetlun",
  },
  {
    "name": "Minyedeippa(မင်းရဲဒိဗ္ဗ)",
    "beginning_jdn": 2315865,
    "ending_jdn": 2316271,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Minyedeippa",
  },
  {
    "name": "Thalun(သာလွန်မင်း)",
    "beginning_jdn": 2316271,
    "ending_jdn": 2323219,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Thalun",
  },
  {
    "name": "Pindale Min(ပင်းတလဲမင်း)",
    "beginning_jdn": 2323219,
    "ending_jdn": 2327882,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Pindale_Min",
  },
  {
    "name": "Pye Min(ပြည်မင်း)",
    "beginning_jdn": 2327882,
    "ending_jdn": 2331850,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Pye_Min",
  },
  {
    "name": "Narawara(နရာဝရ)",
    "beginning_jdn": 2331850,
    "ending_jdn": 2332169,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Narawara",
  },
  {
    "name": "Minyekyawdin(မင်းရဲကျော်ထင်)",
    "beginning_jdn": 2332169,
    "ending_jdn": 2341366,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Minyekyawdin",
  },
  {
    "name": "Sanay Min(စနေမင်း)",
    "beginning_jdn": 2341366,
    "ending_jdn": 2347319,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Sanay_Min",
  },
  {
    "name": "Taninganway Min(တနင်္ဂနွေမင်း)",
    "beginning_jdn": 2347319,
    "ending_jdn": 2354343,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Taninganway_Min",
  },
  {
    "name": "Mahadhammaraza Dipadi(မဟာဓမ္မရာဇာဓိပတိ)",
    "beginning_jdn": 2354343,
    "ending_jdn": 2361046,
    "dynasty": "Taungoo",
    "url": "https://en.wikipedia.org/wiki/Mahadhammaraza_Dipadi",
  },
  {
    "name": "Smim Htaw Buddhaketi(သမိန်ထောဗုဒ္ဓကိတ္တိ)",
    "beginning_jdn": 2356887,
    "ending_jdn": 2359473,
    "dynasty": "Restored_Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Smim_Htaw_Buddhaketi",
  },
  {
    "name": "Binnya Dala(ဗညားဒလ)",
    "beginning_jdn": 2359473,
    "ending_jdn": 2362917,
    "dynasty": "Restored_Hanthawaddy",
    "url": "https://en.wikipedia.org/wiki/Binnya_Dala",
  },
  {
    "name": "Alaungpaya(အလောင်းဘုရား)",
    "beginning_jdn": 2361024,
    "ending_jdn": 2364018,
    "dynasty": "Konbaung",
    "url": "https://en.wikipedia.org/wiki/Alaungpaya",
  },
  {
    "name": "Naungdawgyi(နောင်တော်ကြီး)",
    "beginning_jdn": 2364018,
    "ending_jdn": 2365314,
    "dynasty": "Konbaung",
    "url": "https://en.wikipedia.org/wiki/Naungdawgyi",
  },
  {
    "name": "Hsinbyushin(ဆင်ဖြူရှင်)",
    "beginning_jdn": 2365314,
    "ending_jdn": 2369892,
    "dynasty": "Konbaung",
    "url": "https://en.wikipedia.org/wiki/Hsinbyushin",
  },
  {
    "name": "Singu Min(စဉ့်ကူးမင်း)",
    "beginning_jdn": 2369892,
    "ending_jdn": 2371958,
    "dynasty": "Konbaung",
    "url": "https://en.wikipedia.org/wiki/Singu_Min",
  },
  {
    "name": "Phaungkaza Maung Maung(ဖောင်းကားစားမောင်မောင်)",
    "beginning_jdn": 2371958,
    "ending_jdn": 2371964,
    "dynasty": "Konbaung",
    "url": "https://en.wikipedia.org/wiki/Phaungkaza_Maung_Maung",
  },
  {
    "name": "Bodawpaya(ဘိုးတော်ဘုရား)",
    "beginning_jdn": 2371964,
    "ending_jdn": 2385591,
    "dynasty": "Konbaung",
    "url": "https://en.wikipedia.org/wiki/Bodawpaya",
  },
  {
    "name": "Bagyidaw(ဘကြီးတော်)",
    "beginning_jdn": 2385591,
    "ending_jdn": 2392115,
    "dynasty": "Konbaung",
    "url": "https://en.wikipedia.org/wiki/Bagyidaw",
  },
  {
    "name": "Tharrawaddy Min(သာယာဝတီမင်း)",
    "beginning_jdn": 2392115,
    "ending_jdn": 2395618,
    "dynasty": "Konbaung",
    "url": "https://en.wikipedia.org/wiki/Tharrawaddy_Min",
  },
  {
    "name": "Pagan Min(ပုဂံမင်း)",
    "beginning_jdn": 2395618,
    "ending_jdn": 2397903,
    "dynasty": "Konbaung",
    "url": "https://en.wikipedia.org/wiki/Pagan_Min",
  },
  {
    "name": "Mindon Min(မင်းတုန်းမင်း)",
    "beginning_jdn": 2397903,
    "ending_jdn": 2407259,
    "dynasty": "Konbaung",
    "url": "https://en.wikipedia.org/wiki/Mindon_Min",
  },
  {
    "name": "Thibaw Min(သီပေါ‌မင်း)",
    "beginning_jdn": 2407259,
    "ending_jdn": 2409875,
    "dynasty": "Konbaung",
    "url": "https://en.wikipedia.org/wiki/Thibaw_Min",
  },
  {
    "name": "Arthur Purves Phayre",
    "beginning_jdn": 2401172,
    "ending_jdn": 2403014,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Arthur_Purves_Phayre",
  },
  {
    "name": "Albert Fytche",
    "beginning_jdn": 2403014,
    "ending_jdn": 2404536,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Albert_Fytche",
  },
  {
    "name": "Ashley Eden",
    "beginning_jdn": 2404536,
    "ending_jdn": 2405993,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Ashley_Eden",
  },
  {
    "name": "Augustus Rivers Thompson",
    "beginning_jdn": 2405993,
    "ending_jdn": 2407074,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Augustus_Rivers_Thompson",
  },
  {
    "name": "Charles Umpherston Aitchison",
    "beginning_jdn": 2407074,
    "ending_jdn": 2407899,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Charles_Umpherston_Aitchison",
  },
  {
    "name": "Charles Edward Bernard",
    "beginning_jdn": 2407899,
    "ending_jdn": 2408872,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Charles_Bernard_(civil_servant)",
  },
  {
    "name": "Charles Hawkes Todd Crosthwaite",
    "beginning_jdn": 2408872,
    "ending_jdn": 2409908,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Charles_Crosthwaite",
  },
  {
    "name": "Charles Hawkes Todd Crosthwaite",
    "beginning_jdn": 2409908,
    "ending_jdn": 2409964,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Charles_Crosthwaite",
  },
  {
    "name": "Charles Hawkes Todd Crosthwaite",
    "beginning_jdn": 2409964,
    "ending_jdn": 2410175,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Charles_Crosthwaite",
  },
  {
    "name": "Charles Edward Bernard",
    "beginning_jdn": 2410175,
    "ending_jdn": 2410343,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Charles_Bernard_(civil_servant)",
  },
  {
    "name": "Charles Hawkes Todd Crosthwaite",
    "beginning_jdn": 2410343,
    "ending_jdn": 2411712,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Charles_Crosthwaite",
  },
  {
    "name": "Alexander Mackenzie",
    "beginning_jdn": 2411712,
    "ending_jdn": 2413287,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Alexander_Mackenzie_(civil_servant)",
  },
  {
    "name": "Frederick William Richard Fryer",
    "beginning_jdn": 2413287,
    "ending_jdn": 2414046,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Frederick_William_Richard_Fryer",
  },
  {
    "name": "Frederick William Richard Fryer",
    "beginning_jdn": 2414046,
    "ending_jdn": 2416209,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Frederick_William_Richard_Fryer",
  },
  {
    "name": "Hugh Shakespear Barnes",
    "beginning_jdn": 2416209,
    "ending_jdn": 2416975,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Hugh_Shakespear_Barnes",
  },
  {
    "name": "Herbert Thirkell White",
    "beginning_jdn": 2416975,
    "ending_jdn": 2418811,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Herbert_Thirkell_White",
  },
  {
    "name": "Harvey Adamson",
    "beginning_jdn": 2418811,
    "ending_jdn": 2420799,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Harvey_Adamson",
  },
  {
    "name": "George Shaw",
    "beginning_jdn": 2419903,
    "ending_jdn": 2420073,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/George_Shaw_(civil_servant)",
  },
  {
    "name": "Spencer Harcourt Butler",
    "beginning_jdn": 2420799,
    "ending_jdn": 2421494,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Harcourt_Butler",
  },
  {
    "name": "Walter Francis Rice",
    "beginning_jdn": 2421494,
    "ending_jdn": 2421640,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Walter_Francis_Rice",
  },
  {
    "name": "Reginald Henry Craddock",
    "beginning_jdn": 2421640,
    "ending_jdn": 2423410,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Reginald_Craddock",
  },
  {
    "name": "Spencer Harcourt Butler",
    "beginning_jdn": 2423410,
    "ending_jdn": 2423422,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Harcourt_Butler",
  },
  {
    "name": "Spencer Harcourt Butler",
    "beginning_jdn": 2423422,
    "ending_jdn": 2425235,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Harcourt_Butler",
  },
  {
    "name": "Charles Alexander Innes",
    "beginning_jdn": 2425235,
    "ending_jdn": 2427062,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Charles_Alexander_Innes",
  },
  {
    "name": "Hugh Landsdowne Stephenson",
    "beginning_jdn": 2427062,
    "ending_jdn": 2428297,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Hugh_Lansdown_Stephenson",
  },
  {
    "name": "Archibald Douglas Cochrane",
    "beginning_jdn": 2428297,
    "ending_jdn": 2428625,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Archibald_Cochrane_(politician)",
  },
  {
    "name": "Archibald Douglas Cochrane",
    "beginning_jdn": 2428625,
    "ending_jdn": 2430121,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Archibald_Cochrane_(politician)",
  },
  {
    "name": "Reginald Hugh Dorman-Smith",
    "beginning_jdn": 2430121,
    "ending_jdn": 2432064,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Reginald_Dorman-Smith",
  },
  {
    "name": "Shōjirō Iida",
    "beginning_jdn": 2430470,
    "ending_jdn": 2430802,
    "dynasty": "Japanese_Occupation",
    "url": "https://en.wikipedia.org/wiki/Sh%C5%8Djir%C5%8D_Iida",
  },
  {
    "name": "Masakazu Kawabe",
    "beginning_jdn": 2430802,
    "ending_jdn": 2431333,
    "dynasty": "Japanese_Occupation",
    "url": "https://en.wikipedia.org/wiki/Masakazu_Kawabe",
  },
  {
    "name": "Heitarō Kimura",
    "beginning_jdn": 2431333,
    "ending_jdn": 2431683,
    "dynasty": "Japanese_Occupation",
    "url": "https://en.wikipedia.org/wiki/Heitar%C5%8D_Kimura",
  },
  {
    "name": "Admiral Lord Louis Mountbatten",
    "beginning_jdn": 2431091,
    "ending_jdn": 2431730,
    "dynasty": "British_Colonial_Period",
    "url":
        "https://en.wikipedia.org/wiki/Louis_Mountbatten,_1st_Earl_Mountbatten_of_Burma",
  },
  {
    "name": "Hubert Elvin Rance",
    "beginning_jdn": 2431730,
    "ending_jdn": 2432064,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Hubert_Rance",
  },
  {
    "name": "Hubert Elvin Rance",
    "beginning_jdn": 2432064,
    "ending_jdn": 2432555,
    "dynasty": "British_Colonial_Period",
    "url": "https://en.wikipedia.org/wiki/Hubert_Rance",
  },
  {
    "name": "Sao Shwe Thaik (စဝ်ရွှေသိုက်)",
    "beginning_jdn": 2432555,
    "ending_jdn": 2434088,
    "dynasty": "Union_of_Burma",
    "url": "https://en.wikipedia.org/wiki/Sao_Shwe_Thaik",
  },
  {
    "name": "Ba U (ဘဦး)",
    "beginning_jdn": 2434088,
    "ending_jdn": 2435911,
    "dynasty": "Union_of_Burma",
    "url": "https://en.wikipedia.org/wiki/Ba_U",
  },
  {
    "name": "Mahn Win Maung (မန်းဝင်းမောင်)",
    "beginning_jdn": 2435911,
    "ending_jdn": 2437726,
    "dynasty": "Union_of_Burma",
    "url": "https://en.wikipedia.org/wiki/Win_Maung",
  },
  {
    "name": "Ne Win (နေဝင်း)",
    "beginning_jdn": 2437726,
    "ending_jdn": 2442109,
    "dynasty": "Union_of_Burma",
    "url": "https://en.wikipedia.org/wiki/Ne_Win",
  },
  {
    "name": "Ne Win (နေဝင်း)",
    "beginning_jdn": 2442109,
    "ending_jdn": 2444918,
    "dynasty": "Socialist_Republic",
    "url": "https://en.wikipedia.org/wiki/Ne_Win",
  },
  {
    "name": "စန်းယု - San Yu ",
    "beginning_jdn": 2444918,
    "ending_jdn": 2447370,
    "dynasty": "Socialist_Republic",
    "url": "https://en.wikipedia.org/wiki/San_Yu",
  },
  {
    "name": "စိန်လွင် - Sein Lwin ",
    "beginning_jdn": 2447370,
    "ending_jdn": 2447386,
    "dynasty": "Socialist_Republic",
    "url": "https://en.wikipedia.org/wiki/Sein_Lwin",
  },
  {
    "name": "အေးကို - Aye Ko ",
    "beginning_jdn": 2447386,
    "ending_jdn": 2447393,
    "dynasty": "Socialist_Republic",
    "url": "https://en.wikipedia.org/wiki/Aye_Ko",
  },
  {
    "name": "မောင်မောင် - Maung Maung ",
    "beginning_jdn": 2447393,
    "ending_jdn": 2447423,
    "dynasty": "Socialist_Republic",
    "url": "https://en.wikipedia.org/wiki/Maung_Maung",
  },
  {
    "name": "စောမောင် - Saw Maung ",
    "beginning_jdn": 2447423,
    "ending_jdn": 2448736,
    "dynasty": "Union_of_Myanmar",
    "url": "https://en.wikipedia.org/wiki/Saw_Maung",
  },
  {
    "name": "သန်းရွှေ - Than Shwe",
    "beginning_jdn": 2448736,
    "ending_jdn": 2450758,
    "dynasty": "Union_of_Myanmar",
    "url": "https://en.wikipedia.org/wiki/Than_Shwe",
  },
  {
    "name": "သန်းရွှေ - Than Shwe",
    "beginning_jdn": 2450758,
    "ending_jdn": 2455651,
    "dynasty": "Union_of_Myanmar",
    "url": "https://en.wikipedia.org/wiki/Than_Shwe",
  },
  {
    "name": "သိန်းစိန် - Thein Sein ",
    "beginning_jdn": 2455651,
    "ending_jdn": 2457477,
    "dynasty": "Republic_Myanmar",
    "url": "https://en.wikipedia.org/wiki/Thein_Sein",
  },
  {
    "name": "ထင်ကျော် - Htin Kyaw ",
    "beginning_jdn": 2457478,
    "ending_jdn": 2458207,
    "dynasty": "Republic_Myanmar",
    "url": "https://en.wikipedia.org/wiki/Htin_Kyaw",
  },
  {
    "name": "ဝင်းမြင့် - Win Myint ",
    "beginning_jdn": 2458208,
    "ending_jdn": 2459303,
    "dynasty": "Republic_Myanmar",
    "url": "https://en.wikipedia.org/wiki/Win_Myint",
  },
];

const dynasties = [
  {
    "id": "konbaung",
    "description": "Konbaung (ကုန်းဘောင်ခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Konbaung_Dynasty",
  },
  {
    "id": "restored_hanthawaddy",
    "description": "Restored Hanthawaddy Kingdom (ဟံသာဝတီပဲခူးတိုင်းပြည်)",
    "url": "https://en.wikipedia.org/wiki/Restored_Hanthawaddy_Kingdom",
  },
  {
    "id": "taungoo",
    "description": "Taungoo (တောင်ငူခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Taungoo_Dynasty",
  },
  {
    "id": "mrauk_u",
    "description": "Mrauk-U Dynasty (မြောက်‌ဦး)",
    "url": "https://en.wikipedia.org/wiki/Kingdom_of_Mrauk_U",
  },
  {
    "id": "hanthawaddy",
    "description": "Hanthawaddy Dynasty (ဟံသာဝတီ)",
    "url": "https://en.wikipedia.org/wiki/Hanthawaddy_Kingdom",
  },
  {
    "id": "prome",
    "description": "Prome Dynasty (ဒုတိယ သရေခေတ္တရာ)",
    "url": "https://en.wikipedia.org/wiki/Prome_Kingdom",
  },
  {
    "id": "ava",
    "description": "Ava Dynasty (အင်းဝခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Kingdom_of_Ava",
  },
  {
    "id": "sagaing",
    "description": "Sagaing Kingdom (စစ်ကိုင်းခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Sagaing_Kingdom",
  },
  {
    "id": "pinya",
    "description": "Pinya Kingdom (ပင်းယခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Pinya_Kingdom",
  },
  {
    "id": "myinsaing",
    "description": "Myinsaing Kingdom (မြင်စိုင်းခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Myinsaing_Kingdom",
  },
  {
    "id": "pagan",
    "description": "Pagan Kingdom (ပုဂံခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Pagan_Kingdom",
  },
  {
    "id": "early_pagan",
    "description": "Early Pagan Kingdom (ခေတ်ဦး ပုဂံ ပြည်)",
    "url": "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom",
  },
  {
    "id": "british_colonial_period",
    "description": "British Colonial Period (ဗြိတိသျှကိုလိုနီခေတ်)",
    "url": "https://en.wikipedia.org/wiki/British_rule_in_Burma",
  },
  {
    "id": "japanese_occupation",
    "description": "Japanese Occupation (ဂျပန်ခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Japanese_occupation_of_Burma",
  },
  {
    "id": "union_of_burma",
    "description": "Union of Burma",
    "url":
        "https://en.wikipedia.org/wiki/Post-independence_Burma,_1948%E2%80%9362",
  },
  {
    "id": "socialist_republic",
    "description": "Socialist Republic of the Union of Burma",
    "url": "https://en.wikipedia.org/wiki/Burmese_Way_to_Socialism",
  },
  {
    "id": "union_of_myanmar",
    "description": "Union of Myanmar",
    "url": "https://en.wikipedia.org/wiki/State_Peace_and_Development_Council",
  },
  {
    "id": "republic_myanmar",
    "description": "Republic of the Union of Myanmar",
    "url": "https://en.wikipedia.org/wiki/Myanmar",
  },
];

const dynastyMap = {
  "konbaung": {
    "description": "Konbaung (ကုန်းဘောင်ခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Konbaung_Dynasty",
  },
  "restored_hanthawaddy": {
    "description": "Restored Hanthawaddy Kingdom (ဟံသာဝတီပဲခူးတိုင်းပြည်)",
    "url": "https://en.wikipedia.org/wiki/Restored_Hanthawaddy_Kingdom",
  },
  "taungoo": {
    "description": "Taungoo (တောင်ငူခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Taungoo_Dynasty",
  },
  "mrauk_u": {
    "description": "Mrauk-U Dynasty (မြောက်‌ဦး)",
    "url": "https://en.wikipedia.org/wiki/Kingdom_of_Mrauk_U",
  },
  "hanthawaddy": {
    "description": "Hanthawaddy Dynasty (ဟံသာဝတီ)",
    "url": "https://en.wikipedia.org/wiki/Hanthawaddy_Kingdom",
  },
  "prome": {
    "description": "Prome Dynasty (ဒုတိယ သရေခေတ္တရာ)",
    "url": "https://en.wikipedia.org/wiki/Prome_Kingdom",
  },
  "ava": {
    "description": "Ava Dynasty (အင်းဝခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Kingdom_of_Ava",
  },
  "sagaing": {
    "description": "Sagaing Kingdom (စစ်ကိုင်းခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Sagaing_Kingdom",
  },
  "pinya": {
    "description": "Pinya Kingdom (ပင်းယခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Pinya_Kingdom",
  },
  "myinsaing": {
    "description": "Myinsaing Kingdom (မြင်စိုင်းခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Myinsaing_Kingdom",
  },
  "pagan": {
    "description": "Pagan Kingdom (ပုဂံခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Pagan_Kingdom",
  },
  "early_pagan": {
    "description": "Early Pagan Kingdom (ခေတ်ဦး ပုဂံ ပြည်)",
    "url": "https://en.wikipedia.org/wiki/Early_Pagan_Kingdom",
  },
  "british_colonial_period": {
    "description": "British Colonial Period (ဗြိတိသျှကိုလိုနီခေတ်)",
    "url": "https://en.wikipedia.org/wiki/British_rule_in_Burma",
  },
  "japanese_occupation": {
    "description": "Japanese Occupation (ဂျပန်ခေတ်)",
    "url": "https://en.wikipedia.org/wiki/Japanese_occupation_of_Burma",
  },
  "union_of_burma": {
    "description": "Union of Burma",
    "url":
        "https://en.wikipedia.org/wiki/Post-independence_Burma,_1948%E2%80%9362",
  },
  "socialist_republic": {
    "description": "Socialist Republic of the Union of Burma",
    "url": "https://en.wikipedia.org/wiki/Burmese_Way_to_Socialism",
  },
  "union_of_myanmar": {
    "description": "Union of Myanmar",
    "url": "https://en.wikipedia.org/wiki/State_Peace_and_Development_Council",
  },
  "republic_myanmar": {
    "description": "Republic of the Union of Myanmar",
    "url": "https://en.wikipedia.org/wiki/Myanmar",
  },
};

const chronicles = [
  {
    "Julian Day Number": 1995076,
    "Myanmar Year": 111,
    "Myanmar Month": "Late Tagu",
    "Moon Phase": "Waxing",
    "Fortnight Day": 11,
    "Day of the Week": "Sunday",
    "description": "Foundation of Arimaddana."
  },
  {
    "Julian Day Number": 2031512,
    "Myanmar Year": 211,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waxing",
    "Fortnight Day": 6,
    "Day of the Week": "Monday",
    "description": "Foundation of Pagan."
  },
  {
    "Julian Day Number": 2107906,
    "Myanmar Year": 420,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Thursday",
    "description":
        "ဂဝံကျောင်း ကျောက်စာ၊ လက်သည်းရှည်ဘုရား၊ ပုဂံမြို့၊ အနော်ရထာမင်းကြီး။ ကျောင်းပြု၍ ဆင်၊ မြင်း၊ လယ်၊ မြေလှူဒါန်း။ သကရစ် ၄၂၀ ဘဿနှစ် တပေါင်လ္ဆန် ၅ ရက် ၅ နိယ်လျှင် ဘုန်တန်ခိုဝ် ပ္လည်ာနှင် ပ္လည်စုံမ်စွာသော စ်အနောရဓါ မင်ကြီကာ ၁ သူမ္လင် လောက် အဓုံမ်ကိုဝ် ယရုယ် သ္ခိင်ကဝံ ထု၏ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၁၀။"
  },
  {
    "Julian Day Number": 2125483,
    "Myanmar Year": 469,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Thursday",
    "description":
        "ပရိမ္မထီးလိုင်သျှင်ဘုရားကျောက်စာ၊ ထီးလှိုင်ရှင်ဘုရား၊ ပရိမ္မရွာ၊ မြောင်မြို့နယ်၊ စေတီတည်၍၊ ကျွန်၊ စပါး၊ ငရုတ်၊ ချင်း၊ ဆား၊ ငါးပိ စသည်လှူဒါန်း။ သကရဇ် ၄၆၉ ခူ မာဃ ဂံဝဇ္ဆိုဏ် သိရိ ဘဝနာ ဒိတျ ဝံင်္သ ရာဇာဓိ ရာဇာ။ မဟ ဗ္ဗလော ဇိနိတွာန ၊ မဟိံ သဗ္ဗံ နိဗာနံ သမ္ပတာရ ယန္တိ ။ ကုဆုန်လ္ဆန် ၁၀ ၅ နိယ် မိမိဖွာရာ ပရိမ်ပြည်နှိုက် ဓိလိုင်သျင် မင်ကြီ စေတီ တည်၏ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၅ (က)။"
  },
  {
    "Julian Day Number": 2127136,
    "Myanmar Year": 473,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Friday",
    "description":
        "လှည်းထောင်ဘုရားကျောက်စာ၊ တောင်ပြုန်းကြီး၊ အလောင်းစည်သူမင်းကြီး။ ဘုရားတည်ကျောင်းပြု၍ မြေလှူဒါန်း။ သက္ကရာစ် ၄၇၃ ခု တန်စောင်မုန် လဆန် ဆဲရက် သောက်ကြာ နံနက် သရဝန် နက်သတ် နှစ်ဆဲ နှစ်လုံမ်လျှင် ပ္လုတဝ်မူ၏ ၊ ငါပ္လုသော ဖုရာ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၄ (က)။"
  },
  {
    "Julian Day Number": 2149217,
    "Myanmar Year": 534,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 2,
    "Day of the Week": "Monday",
    "description":
        "၅၃၄ (*၅၃၉) ခု ။ ကုဆုန်လ္ဆန် ၂ ရျက် တနှင်လာညန် သန်ကောင်လွန်ပေသော ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် (၇၈-က)။"
  },
  {
    "Julian Day Number": 2150320,
    "Myanmar Year": 537,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Friday",
    "description":
        "သင်ကြီးငါယန်သင် ကျောက်စာ။ သိမ်နှင့်ပုထိုးပြု၍ ကျွန်၊ လယ်၊ ယာ၊ နွား၊ စသည့် လှူဒါန်း။ ... သကရစ် (၅၃) ၇ ခု ကြတီုက်နှစ် ကူဆူန်လ္ဆန် ၁၀ ရျာက် သုက္ကြာနိယ္အ်အာ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၃။ (ကြတိုက်နှစ်ဆိုပါက ၅၃၈ ဖြစ်သင့်သည်။)"
  },
  {
    "Julian Day Number": 2152069,
    "Myanmar Year": 541,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Friday",
    "description":
        "ကျစွာမင် မိထွေးတော်ကျောင်း ကျောက်စာ။ သကရစ် ၅၄၁ ခု။ မာဃနှစ်။ တပိုဝ်ထွယ်လ္ဆုတ် (၅ ရျ)က်။ ၆ နိယ် သင်ကြီ ငထာသင်... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၅၈။"
  },
  {
    "Julian Day Number": 2152959,
    "Myanmar Year": 544,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waning",
    "Fortnight Day": 7,
    "Day of the Week": "Friday",
    "description":
        "အိုနူသင် ကျောက်စာ၊ ကျွန် လှူဒါန်း။ သကရစ် ၅၄၄ ခု ဗိသျက်နှစ် မ္လယ်တာလဆုတ် ၇ ရျာက် သုကြာနိ ဖုန်အသည် ကြိယ် အိုနူသင် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၂၁။"
  },
  {
    "Julian Day Number": 2153441,
    "Myanmar Year": 545,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 3,
    "Day of the Week": "Thursday",
    "description":
        "စည်သူမင်းကြီး ကျောက်စာ။  သက္ကရစ် ၅၄၅ ခု စိသ နှစ် တန်ဆောင်မုန် လ္ဆန် ၃ ရျက် ကြာသပတေနိယ္အ်အာ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၄ (ခ)။"
  },
  {
    "Julian Day Number": 2153574,
    "Myanmar Year": 545,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Thursday",
    "description":
        "ပရိမ္မထီးလိုင်သျှင်ဘုရားကျောက်စာ၊ ထီးလှိုင်ရှင်ဘုရား၊ ပရိမ္မရွာ၊ မြောင်မြို့နယ်၊ အလောင်းစည်သူမင်းကြီး။ ဂူ ဘုရားပြု၍ လယ်မြေလှူဒါန်း။ သက္ကစ် ၅၄၅ ခု စိတ်သနှစ် တပေါင်လ္ဆုတ် ၅ ရျက် ၅ နိယ်လျှင် နတ်ရွာသဖွယ် ဖ္လစ်သော ပရိမ်မည်သပြည်နှိုက် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၅ (ခ)။"
  },
  {
    "Julian Day Number": 2157668,
    "Myanmar Year": 557,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Wednesday",
    "description":
        "သူကြွယ်ကျောင်း ကျောက်စာ။ သက္ကရစ် ၅၅၇ ခု နံယုံလ္ဆန် ၇ ရျက် ၄ နေ့လျှင်  ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ (၂) ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၄၉၀။"
  },
  {
    "Julian Day Number": 2158888,
    "Myanmar Year": 560,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Friday",
    "description":
        "မောင်းမ စောခင်မိငယ် ကျောက်စာ။ ဓမ္မရာဇိကဘုရား၊ ပုဂံမြို့။ လှူဒါန်း။ သကရစ် ၅၆၀ ဖဿနှစ် သန္တူလ္ဆုတ် ၂ ရျက် သုကြာနိယ် မောင်မ ခင်မိငယ် ဖုရှာ လှူသော တန်ရောက်လယ် ၅၀ လှူ၏ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၃၇။ <br/><br/> ပုဂံ ရွှေကျာင်း အရှေ့ဂူ ကျောက်စာ။  သကရစ် ၅၆၀ ဖဿနှစ် သန္တူလ္ဆုတ် ၂ ရျက် သောကြာနိယ်အာ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၇။"
  },
  {
    "Julian Day Number": 2159759,
    "Myanmar Year": 562,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Monday",
    "description":
        "စည်သူမင်းကြီး ကျောက်စာ၊ စည်သူမင်းကြီးလင်မယား။ ပုထိုး၊ ဂူ၊ တံတိုင်းပြု၍ ကျွန်၊ လယ် စသည်လှူဒါန်း။ သက္ကရစ် ၅၆၂ ခု ကြတိုက်နှစ် တပေါင်လ္ဆုန် ၅ ရျက် ၂ နိယ် သစ်မတီအရပ်နှိုက် စည်သူမင်ကြီသည် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၂၃။"
  },
  {
    "Julian Day Number": 2161311,
    "Myanmar Year": 567,
    "Myanmar Month": "Kason",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Saturday",
    "description":
        "သင်ငါနှစ်လို့သင် ကျောက်စာ၊ သင်ငါနှစ်လို့သင်။ ဂူဘုရားအားကျွန်၊ နွား၊ လယ် စသည်လှူဒါန်း။ မ္လတ်စွာသော ပုရှာသ္ခိင် သာသနာ လွန်လိယ်ပြီသော အနှစ် ၁၇၅၀ သကရစ် ၅၆၇ စေယ်နှစ် ။ ကုဆုန်လ ပ္လည် စနိယ်နိယ်အာ သင်ငါနှစ်လိုဝ္အ်သင် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၂၄ (က ၊ ခ)။ ( က ရှိ ၅၆၇ မှာ သာသနာနှစ်နှင့် မကိုက်ပဲ ခ ရှိ ၅၆၈ မှာကိုက်ညီသည်။ သို့သော် စေယ်နှစ်ဆိုပါက က ရှိ ၅၆၇ မှာကိုက်ညီသည်။ မောင်းမ စောခင်မိငယ် ကျောက်စာ အရ ၅၆၈ ကဆုန်လပြည့်မှာ ဗုဒ္ဓဟူးဖြစ်သဖြင့်၊ ဤ ခုနှစ်မှာ ၅၆၇ ဟု ယူဆရသည်။)"
  },
  {
    "Julian Day Number": 2161665,
    "Myanmar Year": 568,
    "Myanmar Month": "Kason",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Wednesday",
    "description":
        "မောင်းမ စောခင်မိငယ် ကျောက်စာ။ ဓမ္မရာဇိကဘုရား၊ ပုဂံမြို့။ လှူဒါန်း။ သကရစ် ၅၆၈ ခု ပိသျက်နှစ် ကဆုန်လပ္လည် ပုတ္တဟူနိယ် မောင်မ စဝ်ခင်မိငယ် ဖုရှာကိုဝ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၃၇။"
  },
  {
    "Julian Day Number": 2162746,
    "Myanmar Year": 571,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Thursday",
    "description":
        "မင်းမတ်နဂါပိုရ်မိဖွါးကျောက်စာ။ သကရစ် ၅၇၁ ခု အာသိန်နှစ်၊ ကုဆုန်လ္ဆန် ၇ ရျက် ၅ နိယ်အာ၊ မင်မတ် နဂါပိုရ် မိဖွါ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၃။  "
  },
  {
    "Julian Day Number": 2163605,
    "Myanmar Year": 573,
    "Myanmar Month": "Tawthalin",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Thursday",
    "description": "Htilominlo comes to power."
  },
  {
    "Julian Day Number": 2169199,
    "Myanmar Year": 588,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Friday",
    "description":
        "ဖျက္ကသု ကျောက်စာ။ ဖျက္ကသုမင်း။ လယ်၊ မြေ လှူဒါန်း။ သာကရစ် ၅၈၈ ခု ပုဿနှစ် နတ္တဝ်လဆု . ၅ သုကြာနိယ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၂၉။"
  },
  {
    "Julian Day Number": 2170481,
    "Myanmar Year": 592,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Saturday",
    "description":
        "မကွေးသူ မုဆိုးမ ကျောက်စာ။ သကရစ် ၅၉၂ ခု ဖ္လကိုန်  မ္လွယ်တာလဆန် ၅ ရျက် စနိယ်နိယ်အာ ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၁၈။"
  },
  {
    "Julian Day Number": 2171439,
    "Myanmar Year": 594,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Friday",
    "description":
        "အမတ်အစလပိဇည်တို့ကျောက်စာ။ သကရစ် ၅၉၄ ခု တပိုဝ်ထွယ် လဆု ၂ င်္ရျ သုကြနိ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၉။  "
  },
  {
    "Julian Day Number": 2172263,
    "Myanmar Year": 597,
    "Myanmar Month": "Kason",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Wednesday",
    "description":
        "သူကြွယ်ငါစပါသင် ကျောက်စာ။ သကရစ် ၅၉၇ ခုကုဆုန် လပ္လည္အ် ပုတ္တဟောနိယ္အ် သုကြွယ် ငါစပါသင် ...။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၈၉(က)။"
  },
  {
    "Julian Day Number": 2172725,
    "Myanmar Year": 598,
    "Myanmar Month": "Tawthalin",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Wednesday",
    "description":
        "သိရိတရိဘဝနာတိတျပဝရ မဟာ ဓမ္မရာဇာ စေည်ု။ ဘုရားတည်၊ ကျောင်းဆောက်၍၊ လယ်၊ မြေ လှူဒါန်း။ သက္ကရာဇ် ၅၉၈ ကြတိုက်နှစ် တော်သလင်လဆန် ၇ ရက် ဗုဒ္ဓဟုနိယ်၊ သိရိ တရိ ဘဝနာ တိတျ ပဝရ မဟာဓမ္မရာဇာ စေည်ု အမည်တော်ဟိသော ဖုရာဆုတောင်သော ၊ မင်မြတ်သှ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၂၈။"
  },
  {
    "Julian Day Number": 2173332,
    "Myanmar Year": 600,
    "Myanmar Month": "Tagu",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Monday",
    "description":
        "မဟာဂေါတမဘုရားကျောက်စာ။ သကရစ် ၆၀၀ ပုဿနှစ် တန်ခူလ္ဆုတ် ၅ ရျက် တနှင်လာနိယ်... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၁။  "
  },
  {
    "Julian Day Number": 2173680,
    "Myanmar Year": 601,
    "Myanmar Month": "Tagu",
    "Moon Phase": "Full moon",
    "Fortnight Day": 2,
    "Day of the Week": "Saturday",
    "description":
        "အမတ်အစလပိဇည်တို့ကျောက်စာ။ သကရစ် ၆၀၁ ခု။ တန်ထူလပ္လည် စနိယ်နိယ်... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၉။  "
  },
  {
    "Julian Day Number": 2173699,
    "Myanmar Year": 601,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Thursday",
    "description":
        "ငကောင်ရင်သင်ဂူကျောင်းကျောက်စာ။ သက္ကရစ် ၆၀၁ ခု၊ မာခနှစ် ကဆုန်လဆန် ၅ ရျက် ကြာသပတေနိယ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၁၄။  "
  },
  {
    "Julian Day Number": 2173825,
    "Myanmar Year": 601,
    "Myanmar Month": "Tawthalin",
    "Moon Phase": "Waxing",
    "Fortnight Day": 13,
    "Day of the Week": "Thursday",
    "description":
        "လေးမျက်နှာဘုရား ကျောက်စာ။ သကရစ် ၆၀၁ မာခနှစ် တ်သလင်လဆန် ၁၃ ရျက် ကြသပတေ ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၀၂။"
  },
  {
    "Julian Day Number": 2173827,
    "Myanmar Year": 601,
    "Myanmar Month": "Tawthalin",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Saturday",
    "description":
        "သင်လျင်သိရတ်မောင်နှံကျောက်စာ။ သကရစ် ၆၀၁ ။ မာခနှစ် တဝ်သလင်လဆန် ၁၅ ရျက် စနိယ်နိယ္အ်လျှင် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၁၀။  "
  },
  {
    "Julian Day Number": 2173980,
    "Myanmar Year": 601,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Friday",
    "description":
        "ရတနာသုံးပါးအားကျွန်လယ်လှူသောကျောက်စာ။ သကရစ် ၆၀၁ ခု မာခါနှစ် တပိုဝ်ထွယ် လဆုတ် ၅ ရျက် သုကြာနိယ်... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၆။  "
  },
  {
    "Julian Day Number": 2173991,
    "Myanmar Year": 601,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 1,
    "Day of the Week": "Monday",
    "description":
        "မင်းမတ်နဂါပိုရ်မိဖွါးကျောက်စာ။ သကရစ် ၆၀၁ ခု မာဃနှစ်၊ တပေါင်လ္ဆန် ၁ ရျက် ၂ နိယ်အာ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၃။  "
  },
  {
    "Julian Day Number": 2174151,
    "Myanmar Year": 602,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Monday",
    "description":
        "ဖုန်းသည် သင်ကြီး ငါပံသင် ကျောက်စာ။ သကရစ် ၆၀၂ ခု ကုဆုန်လဆန် ၁၂ ရျက် တနှင်္လာနိယ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၁၅။"
  },
  {
    "Julian Day Number": 2174152,
    "Myanmar Year": 602,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waxing",
    "Fortnight Day": 13,
    "Day of the Week": "Wednesday",
    "description":
        "သူကြွယ် ငစုယ်သင် ဘုရားကြီး ကျောက်စာ။ သကရစ် ၆၀၂ ခု ဖုတ်သနှစ် မ္လွယ်တာလ္ဆန် ၁၃ ရျက် ၄ နိယ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၂၁။"
  },
  {
    "Julian Day Number": 2174154,
    "Myanmar Year": 602,
    "Myanmar Month": "Waso",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Monday",
    "description":
        "ဖုန်မ္လတ်ပုရှာ မယ်တော် ကျောက်စာ။ လှူဒါန်း။ သကရစ် ၆၀၂ ခု ဖ္လကိုန် သံဝစ္ဆိုဝ်ရနှစ် မ္လယ်တာလပ္လည် တန်နှင်လာနိယ် ဖုန်မ္လတ်ပုရှာ မယ်တော်ကာ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၂၈။"
  },
  {
    "Julian Day Number": 2174163,
    "Myanmar Year": 602,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waning",
    "Fortnight Day": 9,
    "Day of the Week": "Thursday",
    "description":
        "မကွေးသူ မုဆိုးမ ကျောက်စာ။ သကရစ် ၆၀၂ ခု  မ္လွယ်တာလဆုတ် ၉ ရျက်ကြသပတိယ်နိယ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၁၉။"
  },
  {
    "Julian Day Number": 2174272,
    "Myanmar Year": 602,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Monday",
    "description":
        "ငဇဝ်သင် ကျောက်စာ။ သကရစ် ၆၀၂ ခု  ဖလကိုန်နှစ် တန်ဆောင်မှုန် လပ္လည် သတင် တနှင်လာနိယ္အ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၂၀။"
  },
  {
    "Julian Day Number": 2174410,
    "Myanmar Year": 603,
    "Myanmar Month": "Tagu",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Monday",
    "description":
        "ဖွားစောခေါ် အမိပုရှာစော ကျောက်စာ။ သကရစ် ၆၀၃ ခု။ တန်ခူလဆန် ၇ ရျက်။ တနှင်လာနိယ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၂၉။"
  },
  {
    "Julian Day Number": 2174447,
    "Myanmar Year": 603,
    "Myanmar Month": "Kason",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Wednesday",
    "description":
        "ဖွားစောခေါ် အမိပုရဟားစော ကျောက်စာ။ သကရစ် ၆၀၃ ခု။ စယ်နှစ်။ ကုဆုန်လပ္လည် ဗုဒ္ဓဟူနိယ္အ်နှိုက် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၂၄။"
  },
  {
    "Julian Day Number": 2174617,
    "Myanmar Year": 603,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 8,
    "Day of the Week": "Friday",
    "description":
        "သ္ခိင်ဖွားကြီးမြေး စိုးမင်း ကျောက်စာ။ သကရစ် ၆၀၃ ခု စယ်နှစ် တန်ဆောင်မှုန်လ္ဆန် ၈ ရ္ယာက် သုကြာနိယ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၂၇။"
  },
  {
    "Julian Day Number": 2174772,
    "Myanmar Year": 604,
    "Myanmar Month": "Tagu",
    "Moon Phase": "Waxing",
    "Fortnight Day": 13,
    "Day of the Week": "Thursday",
    "description":
        "ရွှေဂူဘုရား ကျောက်စာ။ သကရစ် ၆၀၄ ခု ဗိသျက် သံဝစ္ဆိုဝ်နှစ် တန်ခူလဆန် ၁၃ ရျက် ကြဿပတိယ်နိယ္အ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၅၆။"
  },
  {
    "Julian Day Number": 2174798,
    "Myanmar Year": 604,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Friday",
    "description":
        "ကျစွာမင် မိထွေးတော်ကျောင်း ကျောက်စာ။ သကရစ် ၆၀၄ ခု။ ကဆုန်လ္ဆန် ၁၀ ရျက် သုကြာနိယ်... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၅၉။"
  },
  {
    "Julian Day Number": 2174804,
    "Myanmar Year": 604,
    "Myanmar Month": "Kason",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Wednesday",
    "description":
        "သံဗျင် အစလဘိရစ် ဒါနပတိ မောင်နှံ ကျောက်စာ။ သကရစ် ၆၀၄ ခု ဖ္လကုန်နှစ် ကုဆုန်လ ပ္လည် ပုတ္တ ဟူနိယ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၃၀။"
  },
  {
    "Julian Day Number": 2174913,
    "Myanmar Year": 604,
    "Myanmar Month": "Wagung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 6,
    "Day of the Week": "Wednesday",
    "description":
        "မြေအတွက် အချင်းများသော ကျောက်စာ။ သကရစ် ၆၀၄ ခု ဗိသျက်နှစ် နံကာလဆန် ၆ ရျက် ပုတ္တဟူနိယ် ... ။ ကျစွာမင် မိထွေးတော်ကျောင်း ကျောက်စာ။ သကရစ် ၆၀၄ ခု နံကာလ္ဆန် ၆ ရျက် ပုတ္တဟူနိယ်အာ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၅၂၊ ၅၉။"
  },
  {
    "Julian Day Number": 2174951,
    "Myanmar Year": 604,
    "Myanmar Month": "Tawthalin",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Thursday",
    "description":
        "သူကြွယ် ငါမြှောက်သင် ကျောက်စာ။ သကရစ် ၆၀၄ ခု ပိသျက် သံမဆ္စိုရာနှာစ် တဝ်သ္လင်လပ္လည် ကြတ္သပတိယ်နိယ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၅၃။"
  },
  {
    "Julian Day Number": 2175005,
    "Myanmar Year": 604,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Thursday",
    "description":
        "သ္ခိင် ငမည်သင် ဂုဏာတိရိတ် ကျောက်စာ။ သကရစ် ၆၀၄ ခု ဗိသျက်နှစ် တန်ဆောင်မှုန်လဆန် ၁(၀) ရျက် ကြသပတိယ်နိယ္အ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၅၄။"
  },
  {
    "Julian Day Number": 2175054,
    "Myanmar Year": 604,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waning",
    "Fortnight Day": 14,
    "Day of the Week": "Thursday",
    "description":
        "ညောင်ရံကြီး သမီး ကျောက်စာ။ သကရစ် ၆၀၄ ခု။ ပိသျက်နှစ်။ နတ်တော် လဆုတ် ၁၄ ရျက် သတင် ကြဿတိယ်နိယ္အ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၃၃။"
  },
  {
    "Julian Day Number": 2175057,
    "Myanmar Year": 604,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waxing",
    "Fortnight Day": 3,
    "Day of the Week": "Sunday",
    "description":
        "ညောင်ရံကြီး သမီး ကျောက်စာ။ သကရစ် ၆၀၄ ခု။ ပိသျက်နှစ်။ ပ္လသိုဝ်လဆန် ၃ ရျက် တန်နှင်ကုနုယ်နိယ္အ် ... ။ ရှေးဟောင်းမြန်မာကျောက်စာများ-ဒုတိယတွဲ။ စာမျက်နှာ ၃၃။"
  },
  {
    "Julian Day Number": 2175600,
    "Myanmar Year": 606,
    "Myanmar Month": "Waso",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Monday",
    "description":
        "ဖုမ်မသင်ကြံကျောင်းကျောက်စာ။ သကရာဇ် ၆၀၅ ခု အာသိတ်နှစ် (နှစ်အမည်အရ ၆၀၆ ဖြစ်မှ ကိုက်ညီမည်) မ္လယ်တာလ္ဆန် ၁၅ ရျက် ဝါဆိုသတ .... င် တနှင်လာနိယ်လျှင်။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၅၇။"
  },
  {
    "Julian Day Number": 2181040,
    "Myanmar Year": 621,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Tuesday",
    "description":
        "ငါလပ်သင် ကျောက်စာ။ လှူဒါန်း။ သကရစ် ၆၂၁ ခု အာသတ်နှစ် နံယုန်လဆုတ် ၅ ရျက် ၃ နိယ္အ် ငါလပ်သင် က္လောင် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၂ (က)။"
  },
  {
    "Julian Day Number": 2181652,
    "Myanmar Year": 622,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Friday",
    "description":
        "မဟာရစ်စေတီ ကျောက်စာ။ လှူဒါန်း။ သကရစ် ၆၂၂ ခု ကြတိုက်နှစ် တပိုဝ္အ်ထွယ်လ္ဆန် ၁၂ ရျက် သုကြာနိယ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၇ (က)။"
  },
  {
    "Julian Day Number": 2182117,
    "Myanmar Year": 624,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 8,
    "Day of the Week": "Monday",
    "description":
        "အိုန်ရောက်သင် ကျောက်စာ။ လှူဒါန်း။ သကရစ် ၆၂၄ ခု ပုတ် သနှစ် ကဆုန်လဆန် ၈ ရျက် တနင်ကနုယ်နိယ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၁။"
  },
  {
    "Julian Day Number": 2182408,
    "Myanmar Year": 624,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 3,
    "Day of the Week": "Friday",
    "description":
        "စိုးမင်းကြာသဝတ် လင်မယား ကျောက်စာ။  သကရစ် ၆၂၄ ခု ပုဿနှစ် တပေါင်လ္ဆန် ၃ ရျက် သောက်ြာနိယ်အာ ...  ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၁၀၀ (က)။"
  },
  {
    "Julian Day Number": 2185816,
    "Myanmar Year": 634,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waxing",
    "Fortnight Day": 13,
    "Day of the Week": "Thursday",
    "description":
        "မင်းဖကြီး ကျောက်စာ။ လှူဒါန်း။ .ကရစ် ၆၃၄ ခု ကြတိုက်နှစ်တေ မ္လွယ်တာလဆ. ၁၃ ရျက် ကြာသပတိယ်နိယ်လျှင် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၆၀။"
  },
  {
    "Julian Day Number": 2186041,
    "Myanmar Year": 634,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 3,
    "Day of the Week": "Friday",
    "description":
        "ရမ္မနာသင် ကျောက်စာ။ လှူဒါန်း။ သဂ္ဂရစ် ၆၃၄ ခု ကြတိုက်နှစ် (တပို)ဝ်ထွယ်လဆန် ၃ ရျက် ၆ နိယ်လျှင် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၆၃။"
  },
  {
    "Julian Day Number": 2186172,
    "Myanmar Year": 635,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 13,
    "Day of the Week": "Wednesday",
    "description":
        "မြင်းခုန်တိုင် သ္ခိင်မဟာထီ ကျောက်စာ။ လှူဒါန်း။ သကရစ် ၆၃၅ ခု မြိက္ကသိရ်နှစ် နံယုန်လဆန် ၁၃ ရျာက် ဗုဒ္ဓဟော နံနက် နိယ်တက် ၄၅ ဖ္လွါလျှင် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၆၄။"
  },
  {
    "Julian Day Number": 2188270,
    "Myanmar Year": 640,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Monday",
    "description":
        "ငါကြည်စုသင် လင်မယား ကျောက်စာ။ လှူဒါန်း။ သကရစ် ၆၄၀ ခု ။ တပေါင်လပ္လည် တန်နှင်လာနိယ် ။  ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၈ (ခ)။"
  },
  {
    "Julian Day Number": 2188587,
    "Myanmar Year": 641,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Wednesday",
    "description":
        "မဟာရစ်စေတီ ကျောက်စာ။ လှူဒါန်း။ သကရစ် ၆၄၁ ခု စိဿ်နှစ် တပိုဝ်ဓွယ်လ္ဆန် ၁၀ ရျက် ၄ နိယ် တက်နိယ် ၃၆ ဖ္လွါလျှင် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၇ (ခ)။"
  },
  {
    "Julian Day Number": 2189058,
    "Myanmar Year": 643,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 6,
    "Day of the Week": "Friday",
    "description":
        "သူကြွယ် အစလပို့ ကျောက်စာ။ လှူဒါန်း။ သကရစ် ၆၄၃ ခု ဖတ္တ်နှစ် ခူဆုန်လဆန် ၆ ရျက် သုကြာနိယ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၅။"
  },
  {
    "Julian Day Number": 2189802,
    "Myanmar Year": 645,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Sunday",
    "description":
        "သတင်းသည် အပယ်ငယ် ကျောက်စာ။  သကရစ် ၆၄၅ ခု အာသိန်နှစ် အဓိမတ် နံယုန်လဆန် ၁၂ ရျက် တနှင်ဂုနိုယ်နိယ်လျှင် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၄ (က)။"
  },
  {
    "Julian Day Number": 2191567,
    "Myanmar Year": 650,
    "Myanmar Month": "Tagu",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Monday",
    "description":
        "ငါဖွယ်သင်လင်မယား ကျောက်စာ။ သကရစ် ၆၅၀ ခု တန်ခူလဆန် ၅ ရျက် တနှင်လာနိယ် ... ။  မန္တလေးနန်းတွင်းကျောက်စာရုံ (၂) ရှိကျောက်စာများ။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၄၆၈ (က)။"
  },
  {
    "Julian Day Number": 2192147,
    "Myanmar Year": 651,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waning",
    "Fortnight Day": 8,
    "Day of the Week": "Sunday",
    "description":
        "မဟာရစ်စေတီ ကျောက်စာ။ လှူဒါန်း။ သကရစ် ၆၅၁ ခု စယ်နှစ် သန္တူလ္ဆုတ် ၈ ရျက် ၁ နိယ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၇ (ခ)။"
  },
  {
    "Julian Day Number": 2193376,
    "Myanmar Year": 654,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Thursday",
    "description": "Athinkhaya, Yazathingyan, Thihathu appointed viceroys."
  },
  {
    "Julian Day Number": 2193607,
    "Myanmar Year": 655,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Thursday",
    "description":
        "ပုထိုးနီမင်းနှင့်မင်းကျစွာကျောက်စာ။ သကရစ် ၆၅၅ ခု သရဝန်နှစ် တန်ဆောင်မှုန် (လ္ဆန်။ သာသနာ ၇ ရက်ကြာသပတိ...)၊ နေိယ်လျှင် ပုထိုင်နီမင်နှင်မင်က္လဟွာ မောင်နှံ ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၁၀(က)။"
  },
  {
    "Julian Day Number": 2193915,
    "Myanmar Year": 656,
    "Myanmar Month": "Wagung",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Thursday",
    "description":
        "သ္ခိင်ကုနကမ္ဘီ ကျောက်စာ။ သကရစ် ၆၅၆ ခု ဘတ်နှစ် နံကာလ္ဆုတ် ၅ ရျက် ၅ နိယ်လျှင် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၂ (ခ)။"
  },
  {
    "Julian Day Number": 2193998,
    "Myanmar Year": 656,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Wednesday",
    "description":
        "သူကြွယ် ငက္လုံသင် ကျောက်စာ။ လှူဒါန်း။ သကရစ် ၆၅၆ ခု ။ သရဝန်နှစ် (? possible year error)။ တန်ဆောင်မှုန်လပ္လည် ။ ပုတ္တ (ဟူနိ)ယ် ။ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၆၈။"
  },
  {
    "Julian Day Number": 2194673,
    "Myanmar Year": 658,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waxing",
    "Fortnight Day": 14,
    "Day of the Week": "Sunday",
    "description":
        "မ္လတ်ကြီးစွာ သိမ်ကျောင်း ကျောက်စာ။ ရာဇသင်ကြံ၊ သံပျင်သိင်္ကသူ။ လှူဒါန်း။ သကရစ် ၆၅၈ သန္တု လ္ဆန် ၁၄ ရျက် (၁ နိယ်) နှိုက် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၀။"
  },
  {
    "Julian Day Number": 2194743,
    "Myanmar Year": 658,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waning",
    "Fortnight Day": 7,
    "Day of the Week": "Saturday",
    "description":
        "သီဟသူရမင်းကြီးကျောက်စာ။ သီဟသူကုလားကျောင်း၊ ကျောင်းဝင်းအတွင်း၊ မြင်စိုင်းမြို့။ လှူဒါန်း။ သကရစ် ၆၅၈ ခု ကြတိုက်နှစ် နတ္တ်လ္ဆုတ် ၇ ရျက် ၀နေ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၄။"
  },
  {
    "Julian Day Number": 2195091,
    "Myanmar Year": 659,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 15,
    "Day of the Week": "Thursday",
    "description":
        "မ္လတ်ကြီးစွာ သိမ်ကျောင်း ကျောက်စာ။ ရာဇသင်ကြံ၊ သံပျင်သိင်္ကသူ။ လှူဒါန်း။ သကရစ် ၆၅၉ ခု တန်ဆောင်မှုန်လ္ဆန် ၁၅ ရျက် ၅ နိယ်နှိုက္က်ာ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၀။"
  },
  {
    "Julian Day Number": 2195147,
    "Myanmar Year": 659,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waxing",
    "Fortnight Day": 13,
    "Day of the Week": "Thursday",
    "description":
        "မင်းမတ် သတျာပိစည်း ကျောက်စာ။ လှူဒါန်း။ သက်ရစ် ၆၅၉ ခု မြိုက္က်သိုဝ်နှစ် ပ္လသိုဝ်လ္ဆန် ၁၃ ရျက် ၅ နိယ်လျှင် နန်က္လမင် ကွန်ပြောက်ကြီ ထွက်တဝ်မူသော မင်မတ် သတျာပိစည် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၁ (က)။"
  },
  {
    "Julian Day Number": 2195169,
    "Myanmar Year": 659,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 3,
    "Day of the Week": "Friday",
    "description":
        "သိမ်ကျောင်း စေတီအား မြေလှူသော ကျောက်စာ။ သကရစ် ၆၅၉ ခု မြိုက္ကသိုဝ်နှစ် တပိုဝ်ထွယ်လ္ဆန်း ၃ ရျက် သူကြာနိယ် ...  ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၉၅။"
  },
  {
    "Julian Day Number": 2195183,
    "Myanmar Year": 659,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waning",
    "Fortnight Day": 4,
    "Day of the Week": "Friday",
    "description":
        "သံပျင် သတျာပတေ့ကျောင်း ကျောက်စာ။ သံပျင် သတျာပတေ့။ လှူဒါန်း။ သကရစ် ၆၅၉ ခု မြိက်ကသိုလ်နှစ် တပိုဝ်ထွယ်လ္ဆုတ် ၄ ရျက် သုကြာနိယ် ပန်ပွတ်ရပ်စေတီ မ္လစ်နှိုက် သံပျင် သတျာပတိယ် ကုလာက္လောင်ပြသတ် စလစ်ဥိထွက် ပ္လု၏ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၃၆။"
  },
  {
    "Julian Day Number": 2195620,
    "Myanmar Year": 661,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Monday",
    "description":
        "မိသင်၏သား ငါတပါညီ ကျောက်စာ။ လှူဒါန်း။ သကရစ် ၆၆၁ မာခနှစ် ခုဆုန် လဆန် ဆယ်ရျက် တနှင်လာနိယ္အ်၊ မိသင် သာ ငါတပါ ငီ ပေါက်တိုဝ်ရပ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၃။"
  },
  {
    "Julian Day Number": 2195648,
    "Myanmar Year": 661,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Monday",
    "description":
        "မ္လတ်ကြီးစွာ သိမ်ကျောင်း ကျောက်စာ။ ရာဇသင်ကြံ၊ သံပျင်သိင်္ကသူ။ လှူဒါန်း။ သကရစ် ၆61 ခု နံမျုန်လ္ဆန် ၁၂ ရျက် ၂ နိယ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၀။"
  },
  {
    "Julian Day Number": 2196712,
    "Myanmar Year": 664,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 13,
    "Day of the Week": "Monday",
    "description":
        "ရွှေနန်းသျှင်ကျောင်း ကျောက်စာ။  သက္ကရစ် ၆၆၄ ခု ဖုဿနှစ် (should be ပိသျက်?) ကဆုန် လ္ဆန် ၁၃ ရျက် ၂ နိယ် ရှုဲနန်သျင် လှူသော ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၅။"
  },
  {
    "Julian Day Number": 2197332,
    "Myanmar Year": 665,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Friday",
    "description":
        "အသင်္ခယာကျောင်း ကျောက်စာ။  သက္ကရစ် ၆၆၅ ခု စိဿနှစ် ပ္လတ်သိုဝ်လ္ဆန် ၁၂ ရျက် သောက်ကြာနေလျှင် သာသနာ ၅၀၀၀ လျှင် ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၆ (က)။"
  },
  {
    "Julian Day Number": 2199000,
    "Myanmar Year": 670,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waning",
    "Fortnight Day": 10,
    "Day of the Week": "Sunday",
    "description":
        "မင်းမတ်ကြီး သုံးယောက်နှမ ကျောက်စာ။ သကရစ် ၆၇၀ ကြာတိုက်နှစ် မ္လွယ်တာလ္ဆုတ် ၁၀ ရျက် ၊ တနှင်ကနှုယ်နိယ်အာ ၊ မင်မတ်ကြီ သုံယောက်နှမ ...  ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၈၆။"
  },
  {
    "Julian Day Number": 2198820,
    "Myanmar Year": 669,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waning",
    "Fortnight Day": 9,
    "Day of the Week": "Tuesday",
    "description":
        "လှည်းငှူးနှင့် အမတ်ကြီး ရာဇာသင်ကြံတို့ ကျောက်စာ။ သကရစ် ၆၆၉ ခုအာသိန်နှစ် တပိုဝ်ထွယ် လ္ဆုတ် ၉ ရျက် အင်ကာနိယ် လှည်ငှူသ ...  ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၈၇။"
  },
  {
    "Julian Day Number": 2199305,
    "Myanmar Year": 671,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Thursday",
    "description":
        "ရတနာစေတီ ကျောက်စာ။ သကရစ် ၆၇၁ ခု မြက္ကသိုဝ်နှစ် နံယုန် လ္ဆန် ၅ ရျက် ကြာသပတိယ် ...  ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၈၃ (က)။"
  },
  {
    "Julian Day Number": 2200631,
    "Myanmar Year": 674,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 3,
    "Day of the Week": "Sunday",
    "description":
        "အဘယတေ တောကျောင်း မြတ်ကြီးစေတီ ကျောက်စာ။ သကရစ် ၆၇၄ ခု ဖ္လကိုန်နှစ် တပိုဝ်ထွယ် လ္ဆန် ၃ ရက် ၁ နိယ်လျှင် သ္ခိင် အဘယထေ တဝ်က္လောင် ...  ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၈၁။"
  },
  {
    "Julian Day Number": 2200669,
    "Myanmar Year": 674,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Wednesday",
    "description": "Foundation of Pinya."
  },
  {
    "Julian Day Number": 2200986,
    "Myanmar Year": 675,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Friday",
    "description":
        "ကိုရံသူကြီးကျောင်း ကျောက်စာ။ သကရစ်ကာ ၆၇၅ ခု စိဿနှစ် (*မှတ်ချက် - ၆၇၅ ဆိုပါက စယ်နှစ်ဖြစ်သင့်သည်) ပ္လသိုဝ်လဆန် ၄ ရျက် သုက်ကြာနိယ်ေတ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၈၀။"
  },
  {
    "Julian Day Number": 2201496,
    "Myanmar Year": 677,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Thursday",
    "description": "Sagaing Kingdom founded."
  },
  {
    "Julian Day Number": 2203117,
    "Myanmar Year": 681,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 9,
    "Day of the Week": "Monday",
    "description":
        "မြင်စိုင်းကျောင်း ကျောက်စာ။  သက္ကရစ် ၆၈၁ ခု အာသိန်နှစ် တန်ဆောင်မုန်လ္ဆန် ၉ ရျက် ၂ နိယ်  သာသနာ ၅၀၀၀ တည်စိမ်သောငှာ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၆ (ခ)။"
  },
  {
    "Julian Day Number": 2204941,
    "Myanmar Year": 686,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 2,
    "Day of the Week": "Friday",
    "description":
        "ကန်စွက်ကျောင်း ကျောက်စာ။ သကရစ် ၆၈၆ ခု ဓိမှတိနှစ် တန်ဆောင်မှုန်။ လ္ဆန် သာသနာ ၂ ရျက် ၆ နိယ် တောင်ပနှိုက်။ တောင်ပမင် စေတီ ...  ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၉၄။"
  },
  {
    "Julian Day Number": 2205535,
    "Myanmar Year": 688,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waxing",
    "Fortnight Day": 6,
    "Day of the Week": "Thursday",
    "description":
        "ရာဇသင်ကြံ မျောက်သား ကျောက်စာ။ သက္စြ် ၆၈၈ ၊ နွယ်တာလ္ဆန် ၆ ၊ ၅ ၊ စစ်သူကြီ ရယ်စစင်ကြံ ...  ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၉၆။"
  },
  {
    "Julian Day Number": 2206515,
    "Myanmar Year": 690,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Thursday",
    "description":
        "သရအိုင် သာရီရိက စေတီတော် ကျောက်စာ။ ကရစ် ၆၉၀ အာသတ်(နှစ်) တပေါင် .န် ၁၀ ရျက် ၅ နိယ်လျှင် ဖုန်မ္တတ်ကြိစွာ ...  ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၉၇။"
  },
  {
    "Julian Day Number": 2207887,
    "Myanmar Year": 694,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waning",
    "Fortnight Day": 9,
    "Day of the Week": "Thursday",
    "description":
        "မင်းမတ် အထင်္ကပိစည်းကျောင်း ကျောက်စာ။ သက္ကရစ် ၆၉၄ ခု ကြတိုက်နှစ် တန်ဆောင်မှုန်လ္ဆုတ် ၉ ရျက် ၅ နေအာ မင်မတ်ထင်္ကပိစည်ကာ  ...  ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၉၈ (က)။"
  },
  {
    "Julian Day Number": 2209053,
    "Myanmar Year": 697,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Monday",
    "description":
        "မထောစေတီ ကျောက်စာ။  သကရစ် ၆၉၇ ခု မာခနှစ် တပိုဝ်ထလ္ဆန် ၇ ရျက် ၂ နိယ်အာ ...  ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၁၀၁။"
  },
  {
    "Julian Day Number": 2209175,
    "Myanmar Year": 698,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 11,
    "Day of the Week": "Thursday",
    "description":
        "တန်လိုင်သူကြီးဖုံမသင်ကြံကျောက်စာ။ သကရစ် ၆၉၈ စဲနှစ် နမျုန်လ္ဆန်၁၁ ၅နိယ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၀၈။"
  },
  {
    "Julian Day Number": 2209585,
    "Myanmar Year": 699,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Monday",
    "description":
        "သုံးပန်လှဘုရား ကျောက်စာ။  သကရစ် ၆၉၉ ခု စယ်နှစ် မ္လွယ်တာလ္ဆန် ဆဲရျက် တနှင်လာနေ ဖုံမ္မကြံ မောင်နှံ ကောင်မှုပ္လုရုယ် ...  ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် ၁၁၃။"
  },
  {
    "Julian Day Number": 2214285,
    "Myanmar Year": 712,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waning",
    "Fortnight Day": 1,
    "Day of the Week": "Thursday",
    "description":
        "သကရာဇ် ၇၁(၂) ပိဿျက်နှစ် နံယုန် လ လ္ဆုတ် တရျက် ကြသပတေနေ နေတက် ၇ ဖ္လွါလျှင် တေည်သတေ ... ။ အလှူရှင် -ငကြိသင်။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် (၇၈-ခ)။"
  },
  {
    "Julian Day Number": 2215073,
    "Myanmar Year": 714,
    "Myanmar Month": "Wagung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Monday",
    "description":
        "သကရစ် ၇၁၄ ခု၊ အသတ်နှစ် နံကာလဆန် ၄ ရျက် တန်နှင်လာနိယ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ (၂) ရှိကျောက်စာများ။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၄၇၉။"
  },
  {
    "Julian Day Number": 2215292,
    "Myanmar Year": 714,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waning",
    "Fortnight Day": 3,
    "Day of the Week": "Wednesday",
    "description":
        "မိတ္ထိလာလင်စင်းကန်ရိုးယှိ ကျောက်စာ။ သကရစ် ၇၁၄ ခု အာသတ်နှစ် တပေါင်လ္ဆုတ် ၃ ရျက် ပုတ္တဟူနိယ်လျှင် ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ (၂) ရှိကျောက်စာများ။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၄၆၉။"
  },
  {
    "Julian Day Number": 2216434,
    "Myanmar Year": 718,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 8,
    "Day of the Week": "Thursday",
    "description":
        "မင်းနန်သူကျောင်းကျောက်စာ။ ...ရစ် ၇၁၈ ခု ကြတိုက်နှစ် ကဆုန်လ္ဆန် ၈ ရျက် (၅နေအား) ရတနာသုံမ်ပါ ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၂၆ (က)။"
  },
  {
    "Julian Day Number": 2216756,
    "Myanmar Year": 718,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Monday",
    "description":
        "မာရဖင်ရတနာ စည်းခုံဘုရားကျောံစာ။ သကရစ် ၇၁၈ ခု တပေါင်လ္ဆန် ၅ ရျက် ၂လာနေလျှင် ...။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၉၃။"
  },
  {
    "Julian Day Number": 2216924,
    "Myanmar Year": 719,
    "Myanmar Month": "Wagung",
    "Moon Phase": "Waning",
    "Fortnight Day": 8,
    "Day of the Week": "Thursday",
    "description":
        "တလုပ်မြို့သက်တော်ရဘုရားကျောက်စာ။သကြစ် ၇၁၉ ခုမြိုင်က္ကသိုဝ်နှစ်ဝါခေါင်လဆုတ်၈ရက် ၅ နေိယ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၃၀။"
  },
  {
    "Julian Day Number": 2218441,
    "Myanmar Year": 723,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Tuesday",
    "description":
        "ရွှေစည်းခုံဘုရားကျောက်စာ။ သကရစ် ၇၂၃ ခု စယ်နှစ် တံဆောင်မုန်လ္ဆန် ၇ ရျက် ၃ နိယ် နက္ခ်တ် ၂၆ ခုပြိစ္ဆာလက်လျှင် ရွာ . တည်၏ ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၁၈။"
  },
  {
    "Julian Day Number": 2218961,
    "Myanmar Year": 724,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Sunday",
    "description":
        "အမတ်ကြီးသရေအသင်္ခယာ ကျောက်စာ။ သကရစ် ၇၂၄ ခု ပိဿျက်နှစ်တပေါင်းလ္ဆန် ၁၀ရျက်၁နွေနိယ် ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ (၂) ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၄၃၈(က)။"
  },
  {
    "Julian Day Number": 2219652,
    "Myanmar Year": 726,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 6,
    "Day of the Week": "Tuesday",
    "description": "Foundation of Inwa."
  },
  {
    "Julian Day Number": 2220369,
    "Myanmar Year": 727,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Friday",
    "description":
        "မိတ္တရ သိန်းစည်း အမတ်ကြီး ကျောက်စာ၊ မိတ္တရ သိန်းစည်း အမတ်ကြီး၊ မိဖုရားစောဥမ္မဒန္တီ စန္တသူအမတ်ကြီး။ ကျောင်း၊ မြေ၊ လယ် လှူဒါန်း။ ... သကရစ် ၇၂၇ ခု တပိုဝ်ထွယ်လပ္လည် သောက်ကြာနေ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၁။ ကျောက်တိုင်အမှတ် နံပါတ် ၁၈။ (Year should be 728 if it is friday. 7 and 8 error is common.)"
  },
  {
    "Julian Day Number": 2220747,
    "Myanmar Year": 729,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 8,
    "Day of the Week": "Friday",
    "description": "Razadarit’s DOB."
  },
  {
    "Julian Day Number": 2222556,
    "Myanmar Year": 734,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Monday",
    "description":
        "သကရာဇ် ၇၃၄ ခု ဖ္လကိုန်နှစ် တပိုဝ်ထွယ် လပ္လည် တနှင်လာ နံနက်စေတီသည်သတေ ... ။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် (၇၈-က)။"
  },
  {
    "Julian Day Number": 2223369,
    "Myanmar Year": 737,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 6,
    "Day of the Week": "Tuesday",
    "description":
        "သက္ကရာဇ် ၇၃၇ ခု ကဆုန်လဆန် ၆ ရျက် အင်္ကာနေလျင် ... ။ အလှူရှင် -ငကြိသင်။ မန္တလေးနန်းတွင်းကျောက်စာများ အတွဲ ၂။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံ (၁) အတွင်း။ ကျောက်တိုင်အမှတ် နံပါတ် (၇၈-ခ)။"
  },
  {
    "Julian Day Number": 2226567,
    "Myanmar Year": 745,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Monday",
    "description": "Razadarit comes to power."
  },
  {
    "Julian Day Number": 2228075,
    "Myanmar Year": 749,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 14,
    "Day of the Week": "Thursday",
    "description":
        "သူကြီး ကျောက်စာ။ နမောတဿတိ၊ သက္ကရာဇ် ၇၄၉ ခု၊ ပြိဿနှစ် တပေါင် လ္ဆန် တဆယ် ၄ ရျက်၊ ကြာသပတေနိယ်အာ၊ မြမ္မာပြည် အကြေအညာ  ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ (၂) ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၇၄၉။"
  },
  {
    "Julian Day Number": 2230727,
    "Myanmar Year": 757,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 8,
    "Day of the Week": "Wednesday",
    "description":
        "ပုခြည်သူကြီး ကျောက်စာ။ ... ရစ် ၇၅၇၊ နယုန်လ္ဆန် ၈ ရျက် ၄ နေ ပုခြည်သူကြီ... ။  မန္တလေးနန်းတွင်းကျောက်စာရုံ (၂) ရှိကျောက်စာများ။ မန္တလေးမြို့၊ နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၄၇၀။"
  },
  {
    "Julian Day Number": 2231097,
    "Myanmar Year": 758,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waning",
    "Fortnight Day": 9,
    "Day of the Week": "Wednesday",
    "description":
        "မာရဖင်ရတနာ စည်းခုံဘုရားကျောံစာ။ သက္ကရစ် ၇၅၈ ခု နံမျုန် လ္ဆုတ် ၉ ရျက် ပုတ်တဟူနေလျှင် ...။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၉၃။"
  },
  {
    "Julian Day Number": 2233185,
    "Myanmar Year": 763,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Thursday",
    "description":
        "ပျူကန်မင်းမတ်သရေလင်မယားကျောင်းကျောံစာ။ ... ၇၆၃ ခု၊ အာသိုတ်နှစ် (နှစ်အမည်သရဝန်နှစ်ဖြစ်မှကိုက်ညီမည်) တပေါင်လပ္လည် ကြာ ...။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၇၈။"
  },
  {
    "Julian Day Number": 2234932,
    "Myanmar Year": 768,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Monday",
    "description": "Minye Kyawswa takes Launggyet."
  },
  {
    "Julian Day Number": 2237958,
    "Myanmar Year": 776,
    "Myanmar Month": "Late Tagu",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Wednesday",
    "description": "Minye Kyawswa dies."
  },
  {
    "Julian Day Number": 2239232,
    "Myanmar Year": 780,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Wednesday",
    "description":
        "တန်ဆောင်းကျောင်း ကျောက်စာ။ သက္ကရစ် ၇၈၀ ဝါကျွတ်လဆန် ၁၀ ရက် ပိတဟူနေနှိုက် ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၀၅(မျက်နှာ)။"
  },
  {
    "Julian Day Number": 2239373,
    "Myanmar Year": 780,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 1,
    "Day of the Week": "Thursday",
    "description":
        "ယောက်ခမတော်ကျောင်းကျောက်စာ။ သက္ကရဇ် ၇၈၀ မာခနှစ် တပေါင်လဆန်တရက် ကြာသပဒေနေနှိုက်၊ မ္လိယ်သျှင်နှစ်ပါ စကာမျာကြသည် ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၀၅(ကျော)။"
  },
  {
    "Julian Day Number": 2243108,
    "Myanmar Year": 791,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waning",
    "Fortnight Day": 1,
    "Day of the Week": "Thursday",
    "description": "Min Saw Mon becomes king."
  },
  {
    "Julian Day Number": 2243847,
    "Myanmar Year": 793,
    "Myanmar Month": "Kason",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Friday",
    "description":
        "စည်းခုံဘုရား ကျောက်စာ။ သက္ကရာဇ် ၇၉၃ ကဆုန်လပ္လည်သတင်သောက်ကြာနေိ ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ (၂) ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၄၃၅(က)။"
  },
  {
    "Julian Day Number": 2244590,
    "Myanmar Year": 795,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waning",
    "Fortnight Day": 6,
    "Day of the Week": "Saturday",
    "description": "Min Saw Mon dies."
  },
  {
    "Julian Day Number": 2245253,
    "Myanmar Year": 797,
    "Myanmar Month": "Tagu",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Thursday",
    "description":
        "ဘုရားထုရွာသူကြီး ကျောက်စာ။ လှူဒါန်း။ သကရစ် ၇၉၇ ခု ၊ တန်ခုလဆန် ခုနှစ်ရက် ကြာသပတေနေ၊ ဖုရာထုရွာသူကြိ ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ (၂) ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၄၃၄(က)။"
  },
  {
    "Julian Day Number": 2253758,
    "Myanmar Year": 820,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Thursday",
    "description":
        "နရပတိမင်းကျောင်းကျောက်စာ။ သက္ကြစ် ၈၂၀။ ဝါဆိုလ္ဆန် ငါရက် ကြာသပတေနေညနေလွဲခုနစ်ခါနှိုက်လျှင် ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ (၂) ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၄၅၈(က)။"
  },
  {
    "Julian Day Number": 2254065,
    "Myanmar Year": 821,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Wednesday",
    "description":
        "နရပတိမင်းကျောင်းကျောက်စာ။ သက္ကြစ် ၈၂၁။ ကဆုန် လ္ဆုတ် ၂ ရျက် ပုတ္တဟူနေ (နေတက်တပဟိုဝ်တွင်လျှင်) ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ (၂) ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၄၅၈(က)။"
  },
  {
    "Julian Day Number": 2257784,
    "Myanmar Year": 831,
    "Myanmar Month": "Waso",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Monday",
    "description":
        "စူဠာမုဏိဘုရား ကျောက်စာ။ ၈၃၁ ။ နွဲတာလပြည်၊ တနှင်လာ ရက်နှိုက်၊ နှစ်သိန်လေသောင်၊ အထုဟိသ ... ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ (၂) ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၄၅၇။"
  },
  {
    "Julian Day Number": 2265960,
    "Myanmar Year": 853,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Friday",
    "description": "Foundation of Dwarawaddy (Toungoo)."
  },
  {
    "Julian Day Number": 2269428,
    "Myanmar Year": 863,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waning",
    "Fortnight Day": 9,
    "Day of the Week": "Thursday",
    "description": "Coronation of Narapati II of Ava."
  },
  {
    "Julian Day Number": 2270840,
    "Myanmar Year": 867,
    "Myanmar Month": "Tagu",
    "Moon Phase": "Waning",
    "Fortnight Day": 3,
    "Day of the Week": "Tuesday",
    "description":
        "သက္ကရာဇ် ၈၆၇ တန်ခုလဆုတ် သုံရက် အင်ကာနေ၊ နက်သတ်သုံလုံ။ မန္တလေးနန်းတွင်းကျောက်စာရုံ(၂)ရှိကျောက်စာများ။ မန္တလေးမြို့နန်းတွင်းကျောက်စာရုံငယ်။ ကျောက်တိုင်အမှတ် နံပါတ် ၅၇၃။"
  },
  {
    "Julian Day Number": 2272876,
    "Myanmar Year": 872,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Friday",
    "description": "Mingyi Nyo declares independence from Ava."
  },
  {
    "Julian Day Number": 2273003,
    "Myanmar Year": 872,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waning",
    "Fortnight Day": 9,
    "Day of the Week": "Saturday",
    "description": "Narapati II founds a new palace."
  },
  {
    "Julian Day Number": 2278115,
    "Myanmar Year": 886,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "New moon",
    "Fortnight Day": 15,
    "Day of the Week": "Saturday",
    "description": "Ava falls to the Confederation (1st time)."
  },
  {
    "Julian Day Number": 2278866,
    "Myanmar Year": 888,
    "Myanmar Month": "Late Tagu",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Wednesday",
    "description": "Ava falls to the Confederation (2nd and final time)."
  },
  {
    "Julian Day Number": 2280218,
    "Myanmar Year": 892,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Thursday",
    "description": "Tabinshwehti becomes king."
  },
  {
    "Julian Day Number": 2280402,
    "Myanmar Year": 893,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 11,
    "Day of the Week": "Saturday",
    "description": "Min Bin becomes king of Mrauk-U."
  },
  {
    "Julian Day Number": 2280965,
    "Myanmar Year": 894,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waxing",
    "Fortnight Day": 15,
    "Day of the Week": "Tuesday",
    "description": "Min Bin takes Dhaka."
  },
  {
    "Julian Day Number": 2281024,
    "Myanmar Year": 894,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 15,
    "Day of the Week": "Saturday",
    "description": "Min Bin celebrates victory over Bengal."
  },
  {
    "Julian Day Number": 2284411,
    "Myanmar Year": 904,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Thursday",
    "description": "Prome surrenders to Toungoo forces."
  },
  {
    "Julian Day Number": 2284949,
    "Myanmar Year": 905,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Wednesday",
    "description": "Confederation begins campaign to retake Prome."
  },
  {
    "Julian Day Number": 2286039,
    "Myanmar Year": 908,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Monday",
    "description": "Toungoo begins Arakan campaign."
  },
  {
    "Julian Day Number": 2286121,
    "Myanmar Year": 908,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 2,
    "Day of the Week": "Saturday",
    "description": "Toungoo forces capture Launggyet."
  },
  {
    "Julian Day Number": 2286128,
    "Myanmar Year": 908,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 9,
    "Day of the Week": "Saturday",
    "description": "Treaty of Mrauk-U signed."
  },
  {
    "Julian Day Number": 2286781,
    "Myanmar Year": 910,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waxing",
    "Fortnight Day": 13,
    "Day of the Week": "Monday",
    "description": "Siam campaign begins."
  },
  {
    "Julian Day Number": 2286783,
    "Myanmar Year": 910,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Wednesday",
    "description": "Burmese armies leave Kanchanaburi for Ayutthaya."
  },
  {
    "Julian Day Number": 2286889,
    "Myanmar Year": 910,
    "Myanmar Month": "Late Tagu",
    "Moon Phase": "Waxing",
    "Fortnight Day": 3,
    "Day of the Week": "Thursday",
    "description": "Tabinshwehti gets back to Pegu."
  },
  {
    "Julian Day Number": 2287316,
    "Myanmar Year": 912,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waning",
    "Fortnight Day": 1,
    "Day of the Week": "Thursday",
    "description": "Tabinshwehti assassinated."
  },
  {
    "Julian Day Number": 2287524,
    "Myanmar Year": 912,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Thursday",
    "description": "Bayinnaung marches to Toungoo."
  },
  {
    "Julian Day Number": 2287571,
    "Myanmar Year": 912,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Sunday",
    "description": "Bayinnaung takes Toungoo."
  },
  {
    "Julian Day Number": 2287802,
    "Myanmar Year": 913,
    "Myanmar Month": "Tawthalin",
    "Moon Phase": "New moon",
    "Fortnight Day": 15,
    "Day of the Week": "Sunday",
    "description": "Bayinnaung takes Prome."
  },
  {
    "Julian Day Number": 2287997,
    "Myanmar Year": 913,
    "Myanmar Month": "Late Tagu",
    "Moon Phase": "Waning",
    "Fortnight Day": 3,
    "Day of the Week": "Saturday",
    "description": "Bayinnaung takes Pegu."
  },
  {
    "Julian Day Number": 2288668,
    "Myanmar Year": 915,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Friday",
    "description": "Coronation of Bayinnaung and Atula Thiri at Pegu."
  },
  {
    "Julian Day Number": 2289043,
    "Myanmar Year": 916,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 2,
    "Day of the Week": "Tuesday",
    "description": "Bayinnaung takes Ava."
  },
  {
    "Julian Day Number": 2289700,
    "Myanmar Year": 918,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waxing",
    "Fortnight Day": 8,
    "Day of the Week": "Monday",
    "description": "Bayinnaung prepares to invade cis-Salween Shan states."
  },
  {
    "Julian Day Number": 2289760,
    "Myanmar Year": 918,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 9,
    "Day of the Week": "Friday",
    "description": "Bayinnaung begins campaign to Shan states."
  },
  {
    "Julian Day Number": 2289777,
    "Myanmar Year": 918,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waning",
    "Fortnight Day": 11,
    "Day of the Week": "Monday",
    "description": "Bayinnaung conquers Mong Mit (Momeik) and Hsipaw (Thibaw)."
  },
  {
    "Julian Day Number": 2289791,
    "Myanmar Year": 918,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 11,
    "Day of the Week": "Monday",
    "description":
        "Bayinnaung dedicates a pagoda each at Mong Mit and at Hsipaw."
  },
  {
    "Julian Day Number": 2289831,
    "Myanmar Year": 918,
    "Myanmar Month": "Late Tagu",
    "Moon Phase": "Waning",
    "Fortnight Day": 6,
    "Day of the Week": "Saturday",
    "description": "Bayinnaung conquers Mong Yang (Mohnyin)."
  },
  {
    "Julian Day Number": 2289837,
    "Myanmar Year": 918,
    "Myanmar Month": "Late Tagu",
    "Moon Phase": "Waning",
    "Fortnight Day": 12,
    "Day of the Week": "Friday",
    "description": "Bayinnaung conquers Mong Kawng (Mogaung)."
  },
  {
    "Julian Day Number": 2289851,
    "Myanmar Year": 919,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Friday",
    "description": "Bayinnaung leaves Mong Kawng (Mogaung)."
  },
  {
    "Julian Day Number": 2289895,
    "Myanmar Year": 919,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waning",
    "Fortnight Day": 11,
    "Day of the Week": "Sunday",
    "description": "Bayinnaung dedicates a bell at the Shwezigon Pagoda."
  },
  {
    "Julian Day Number": 2290052,
    "Myanmar Year": 919,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 6,
    "Day of the Week": "Wednesday",
    "description": "Bayinnaung begins campaign to Mong Nai (Mone)."
  },
  {
    "Julian Day Number": 2290209,
    "Myanmar Year": 920,
    "Myanmar Month": "Tagu",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Saturday",
    "description": "Bayinnaung takes Chiang Mai."
  },
  {
    "Julian Day Number": 2290437,
    "Myanmar Year": 920,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Wednesday",
    "description": "Thado Minsaw’s Army leaves for Chiang Mai."
  },
  {
    "Julian Day Number": 2290641,
    "Myanmar Year": 921,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Thursday",
    "description": "Groundbreaking ceremony for the Mahazedi Pagoda."
  },
  {
    "Julian Day Number": 2290798,
    "Myanmar Year": 921,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waxing",
    "Fortnight Day": 14,
    "Day of the Week": "Sunday",
    "description": "Yaza Datu Kalaya born."
  },
  {
    "Julian Day Number": 2290801,
    "Myanmar Year": 921,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Wednesday",
    "description": "Dedicates the relic chamber of the Mahazedi."
  },
  {
    "Julian Day Number": 2290818,
    "Myanmar Year": 921,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Saturday",
    "description": "Binnya Dala begins Manipur campaign."
  },
  {
    "Julian Day Number": 2290995,
    "Myanmar Year": 922,
    "Myanmar Month": "First Waso",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Monday",
    "description":
        "Binnya Dala arrives back at Pegu (after a successful Manipur campaign)."
  },
  {
    "Julian Day Number": 2291215,
    "Myanmar Year": 922,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Thursday",
    "description": "Umbrella (hti) raising ceremony at the Mahazedi."
  },
  {
    "Julian Day Number": 2291311,
    "Myanmar Year": 923,
    "Myanmar Month": "Tagu",
    "Moon Phase": "Waning",
    "Fortnight Day": 9,
    "Day of the Week": "Tuesday",
    "description": "Birth of son Thingadatta."
  },
  {
    "Julian Day Number": 2291744,
    "Myanmar Year": 924,
    "Myanmar Month": "Waso",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Wednesday",
    "description":
        "Fortifies Tavoy (Dawei) – for the upcoming invasion of Siam."
  },
  {
    "Julian Day Number": 2291898,
    "Myanmar Year": 924,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waning",
    "Fortnight Day": 6,
    "Day of the Week": "Monday",
    "description": "Keng Tung submits."
  },
  {
    "Julian Day Number": 2291979,
    "Myanmar Year": 924,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Friday",
    "description": "Campaign to Chinese Shan States begins."
  },
  {
    "Julian Day Number": 2291985,
    "Myanmar Year": 924,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Wednesday",
    "description": "Yaza Dewi raised to senior queen."
  },
  {
    "Julian Day Number": 2292140,
    "Myanmar Year": 925,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waning",
    "Fortnight Day": 12,
    "Day of the Week": "Friday",
    "description": "Sends an embassy to Siam, demanding tribute."
  },
  {
    "Julian Day Number": 2292248,
    "Myanmar Year": 925,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waning",
    "Fortnight Day": 12,
    "Day of the Week": "Monday",
    "description": "Siam Campaign begins."
  },
  {
    "Julian Day Number": 2292346,
    "Myanmar Year": 925,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waning",
    "Fortnight Day": 11,
    "Day of the Week": "Monday",
    "description": "Overruns Portuguese defenses at the Ayutthaya harbor."
  },
  {
    "Julian Day Number": 2292357,
    "Myanmar Year": 925,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 8,
    "Day of the Week": "Friday",
    "description": "Siam surrenders."
  },
  {
    "Julian Day Number": 2292604,
    "Myanmar Year": 926,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waning",
    "Fortnight Day": 4,
    "Day of the Week": "Sunday",
    "description": "Lan Na campaign begins."
  },
  {
    "Julian Day Number": 2292774,
    "Myanmar Year": 927,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Tuesday",
    "description": "Leaves Chiang Mai for Pegu."
  },
  {
    "Julian Day Number": 2292802,
    "Myanmar Year": 927,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Tuesday",
    "description": "Arrives back at Pegu."
  },
  {
    "Julian Day Number": 2292872,
    "Myanmar Year": 927,
    "Myanmar Month": "Second Waso",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Thursday",
    "description": "Begins work at the Shwemawdaw Pagoda."
  },
  {
    "Julian Day Number": 2292952,
    "Myanmar Year": 927,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waxing",
    "Fortnight Day": 11,
    "Day of the Week": "Friday",
    "description": "Returning troops from Lan Xang arrives back at Pegu."
  },
  {
    "Julian Day Number": 2292979,
    "Myanmar Year": 927,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Thursday",
    "description": "Reconstruction of Pegu begins."
  },
  {
    "Julian Day Number": 2293078,
    "Myanmar Year": 927,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Friday",
    "description": "Raises a new umbrella at the Shwedagon."
  },
  {
    "Julian Day Number": 2293092,
    "Myanmar Year": 927,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Friday",
    "description": "Raises a new umbrella at the Mahazedi (Pegu)."
  },
  {
    "Julian Day Number": 2293274,
    "Myanmar Year": 928,
    "Myanmar Month": "Tawthalin",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Friday",
    "description": "Dedicates 52 Buddha statues."
  },
  {
    "Julian Day Number": 2293358,
    "Myanmar Year": 928,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Friday",
    "description": "Dedicates the building housing the Pitakas at the Mahazedi."
  },
  {
    "Julian Day Number": 2293371,
    "Myanmar Year": 928,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waning",
    "Fortnight Day": 3,
    "Day of the Week": "Thursday",
    "description":
        "Leads the groundbreaking ceremony for the new gates of Pegu."
  },
  {
    "Julian Day Number": 2293546,
    "Myanmar Year": 929,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waning",
    "Fortnight Day": 1,
    "Day of the Week": "Thursday",
    "description": " Umbrella raising ceremony at the Shwemawdaw."
  },
  {
    "Julian Day Number": 2293603,
    "Myanmar Year": 929,
    "Myanmar Month": "Wagung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 14,
    "Day of the Week": "Friday",
    "description": "Work on the king’s house inside the new Palace begins."
  },
  {
    "Julian Day Number": 2293844,
    "Myanmar Year": 929,
    "Myanmar Month": "Late Tagu",
    "Moon Phase": "Waning",
    "Fortnight Day": 4,
    "Day of the Week": "Monday",
    "description": "Enters the new palace."
  },
  {
    "Julian Day Number": 2293904,
    "Myanmar Year": 930,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Friday",
    "description": "Learns of Ayutthaya’s rebellion."
  },
  {
    "Julian Day Number": 2293936,
    "Myanmar Year": 930,
    "Myanmar Month": "First Waso",
    "Moon Phase": "Waning",
    "Fortnight Day": 7,
    "Day of the Week": "Tuesday",
    "description": "Queen Atula Thiri dies."
  },
  {
    "Julian Day Number": 2294039,
    "Myanmar Year": 930,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waxing",
    "Fortnight Day": 6,
    "Day of the Week": "Sunday",
    "description": "Campaign to Ayutthaya begins."
  },
  {
    "Julian Day Number": 2294240,
    "Myanmar Year": 931,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 1,
    "Day of the Week": "Friday",
    "description": "Campaign to Ayutthaya begins."
  },
  {
    "Julian Day Number": 2294247,
    "Myanmar Year": 931,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 8,
    "Day of the Week": "Friday",
    "description": "Armies leave to meet Lan Xang forces."
  },
  {
    "Julian Day Number": 2294261,
    "Myanmar Year": 931,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waning",
    "Fortnight Day": 7,
    "Day of the Week": "Friday",
    "description": "Defeats Lan Xang forces."
  },
  {
    "Julian Day Number": 2294349,
    "Myanmar Year": 931,
    "Myanmar Month": "Wagung",
    "Moon Phase": "Waning",
    "Fortnight Day": 6,
    "Day of the Week": "Tuesday",
    "description": "Takes Ayutthaya."
  },
  {
    "Julian Day Number": 2294392,
    "Myanmar Year": 931,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Wednesday",
    "description": "Appoints Maha Thammarachathirat as king of Siam."
  },
  {
    "Julian Day Number": 2294422,
    "Myanmar Year": 931,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 6,
    "Day of the Week": "Friday",
    "description": "Lan Xang campaign begins."
  },
  {
    "Julian Day Number": 2294686,
    "Myanmar Year": 932,
    "Myanmar Month": "Wagung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Wednesday",
    "description": "King of Manipur presents his daughter."
  },
  {
    "Julian Day Number": 2294984,
    "Myanmar Year": 933,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Saturday",
    "description": "Marriage of Minye Thihathu II and Min Khin Saw."
  },
  {
    "Julian Day Number": 2295225,
    "Myanmar Year": 933,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Wednesday",
    "description": "Donates to the treasure chamber of Kyaikko Pagoda."
  },
  {
    "Julian Day Number": 2295441,
    "Myanmar Year": 934,
    "Myanmar Month": "Wagung",
    "Moon Phase": "Waning",
    "Fortnight Day": 6,
    "Day of the Week": "Tuesday",
    "description": "Donates to the treasure chamber of Kyaikko Pagoda."
  },
  {
    "Julian Day Number": 2295496,
    "Myanmar Year": 934,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Monday",
    "description": "Raises new umbrella at the Shwe Dagon."
  },
  {
    "Julian Day Number": 2295601,
    "Myanmar Year": 934,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Monday",
    "description": "Thinga Dathat’s hair shaving ceremony."
  },
  {
    "Julian Day Number": 2295725,
    "Myanmar Year": 935,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Saturday",
    "description": "Donates a new Buddha statue."
  },
  {
    "Julian Day Number": 2295909,
    "Myanmar Year": 935,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Monday",
    "description": "Donates a new pyathat."
  },
  {
    "Julian Day Number": 2295969,
    "Myanmar Year": 935,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Friday",
    "description": "Donates a hall at the Mahazedi."
  },
  {
    "Julian Day Number": 2295988,
    "Myanmar Year": 935,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Wednesday",
    "description": "Nawrahta Minsaw weds Hsinbyshin Medaw."
  },
  {
    "Julian Day Number": 2296006,
    "Myanmar Year": 935,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waning",
    "Fortnight Day": 11,
    "Day of the Week": "Sunday",
    "description": "Wedding day of several sons and daughters of the king."
  },
  {
    "Julian Day Number": 2296234,
    "Myanmar Year": 936,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waning",
    "Fortnight Day": 1,
    "Day of the Week": "Thursday",
    "description": "Mohnyin campaign begins."
  },
  {
    "Julian Day Number": 2296240,
    "Myanmar Year": 936,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waning",
    "Fortnight Day": 7,
    "Day of the Week": "Wednesday",
    "description": "Lan Xang campaign begins."
  },
  {
    "Julian Day Number": 2296510,
    "Myanmar Year": 937,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waning",
    "Fortnight Day": 12,
    "Day of the Week": "Sunday",
    "description": "Arrives back to Pegu (from Vientiane)."
  },
  {
    "Julian Day Number": 2296594,
    "Myanmar Year": 937,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waning",
    "Fortnight Day": 7,
    "Day of the Week": "Saturday",
    "description": "Campaign to Mohnyin begins."
  },
  {
    "Julian Day Number": 2296878,
    "Myanmar Year": 938,
    "Myanmar Month": "Second Waso",
    "Moon Phase": "Waxing",
    "Fortnight Day": 11,
    "Day of the Week": "Thursday",
    "description": "A female white elephant arrives from Tavoy."
  },
  {
    "Julian Day Number": 2296998,
    "Myanmar Year": 938,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 13,
    "Day of the Week": "Friday",
    "description": "Makes donations to the Mahazedi Pagoda."
  },
  {
    "Julian Day Number": 2297050,
    "Myanmar Year": 938,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waxing",
    "Fortnight Day": 6,
    "Day of the Week": "Monday",
    "description": "Stays at the royal tent west of the Mahazedi."
  },
  {
    "Julian Day Number": 2297112,
    "Myanmar Year": 938,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 9,
    "Day of the Week": "Sunday",
    "description": "Shin Thissa marries Min Hpone Myat."
  },
  {
    "Julian Day Number": 2297328,
    "Myanmar Year": 939,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waning",
    "Fortnight Day": 3,
    "Day of the Week": "Tuesday",
    "description": "Fugitive Mogaung Sawbwa brought before the king."
  },
  {
    "Julian Day Number": 2297348,
    "Myanmar Year": 939,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 9,
    "Day of the Week": "Friday",
    "description": "Thinga Dathta’s hair knotting ceremony."
  },
  {
    "Julian Day Number": 2297364,
    "Myanmar Year": 939,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waning",
    "Fortnight Day": 10,
    "Day of the Week": "Sunday",
    "description": "Donates a new zayat (hall)."
  },
  {
    "Julian Day Number": 2297625,
    "Myanmar Year": 940,
    "Myanmar Month": "Wagung",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Wednesday",
    "description": "New pyathat built at Pegu."
  },
  {
    "Julian Day Number": 2297775,
    "Myanmar Year": 940,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waning",
    "Fortnight Day": 8,
    "Day of the Week": "Friday",
    "description": "New umbrella raising ceremony at the Sandawshin at Toungoo."
  },
  {
    "Julian Day Number": 2297787,
    "Myanmar Year": 940,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Wednesday",
    "description": "Receives news of death of Maha Dewi of Lan Na."
  },
  {
    "Julian Day Number": 2297816,
    "Myanmar Year": 940,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Wednesday",
    "description": "Nawrahta Minsaw appointed viceroy of Lan Na."
  },
  {
    "Julian Day Number": 2297891,
    "Myanmar Year": 941,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waning",
    "Fortnight Day": 6,
    "Day of the Week": "Monday",
    "description": "Donation ceremony at Mahazedi."
  },
  {
    "Julian Day Number": 2297970,
    "Myanmar Year": 941,
    "Myanmar Month": "Second Waso",
    "Moon Phase": "Waxing",
    "Fortnight Day": 10,
    "Day of the Week": "Thursday",
    "description": "Nawrahta Minsaw’s coronation ceremony at Chiang Mai."
  },
  {
    "Julian Day Number": 2298260,
    "Myanmar Year": 942,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Sunday",
    "description":
        "Bayinnaung dedicates the treasure chamber of Kaung-mhu-daw Mahamuni Pagoda."
  },
  {
    "Julian Day Number": 2298543,
    "Myanmar Year": 942,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waning",
    "Fortnight Day": 7,
    "Day of the Week": "Wednesday",
    "description": "Umbrella (hti) raising ceremony at a pagoda."
  },
  {
    "Julian Day Number": 2298548,
    "Myanmar Year": 942,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waning",
    "Fortnight Day": 12,
    "Day of the Week": "Wednesday",
    "description": "City of Kale fortified."
  },
  {
    "Julian Day Number": 2298557,
    "Myanmar Year": 942,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Wednesday",
    "description": "Shin Thissa appointed governor of Nyaungyan."
  },
  {
    "Julian Day Number": 2298642,
    "Myanmar Year": 943,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 3,
    "Day of the Week": "Thursday",
    "description": "Receives Mohnyin Sawbwa."
  },
  {
    "Julian Day Number": 2298645,
    "Myanmar Year": 943,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 6,
    "Day of the Week": "Sunday",
    "description": "Receives Chaing Rai Sawbwa."
  },
  {
    "Julian Day Number": 2298664,
    "Myanmar Year": 943,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Waning",
    "Fortnight Day": 10,
    "Day of the Week": "Friday",
    "description": "Appoints Thinga Dathta viceroy of Martaban."
  },
  {
    "Julian Day Number": 2298801,
    "Myanmar Year": 943,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Tuesday",
    "description": "Bayinnaung dies."
  },
  {
    "Julian Day Number": 2299305,
    "Myanmar Year": 944,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waning",
    "Fortnight Day": 1,
    "Day of the Week": "Tuesday",
    "description": "A comet going across the Sun observed."
  },
  {
    "Julian Day Number": 2299718,
    "Myanmar Year": 946,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waning",
    "Fortnight Day": 1,
    "Day of the Week": "Tuesday",
    "description": "Nanda marches to Ava."
  },
  {
    "Julian Day Number": 2300003,
    "Myanmar Year": 946,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 5,
    "Day of the Week": "Sunday",
    "description": "Nanda dedicates a Bronze Buddha statue."
  },
  {
    "Julian Day Number": 2300030,
    "Myanmar Year": 946,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 3,
    "Day of the Week": "Saturday",
    "description":
        "Nanda dedicates five Buddha statues (hence known as Nga-Zu-Dayaka Min)."
  },
  {
    "Julian Day Number": 2300626,
    "Myanmar Year": 948,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 9,
    "Day of the Week": "Sunday",
    "description": "Siam campaign begins."
  },
  {
    "Julian Day Number": 2301198,
    "Myanmar Year": 950,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Friday",
    "description": "Marriage between Minye Kyawhtin and Princess Thakin Gyi."
  },
  {
    "Julian Day Number": 2301477,
    "Myanmar Year": 950,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Thursday",
    "description": "Appoints Thado Dhamma Yaza III viceroy of Prome."
  },
  {
    "Julian Day Number": 2302834,
    "Myanmar Year": 954,
    "Myanmar Month": "Nadaw",
    "Moon Phase": "Waxing",
    "Fortnight Day": 2,
    "Day of the Week": "Wednesday",
    "description": "5th invasion of Siam begins."
  },
  {
    "Julian Day Number": 2302899,
    "Myanmar Year": 954,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 8,
    "Day of the Week": "Friday",
    "description": "Mingyi Swa dies in action."
  },
  {
    "Julian Day Number": 2303254,
    "Myanmar Year": 955,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waxing",
    "Fortnight Day": 8,
    "Day of the Week": "Wednesday",
    "description": "Appoints Minye Kyawswa II of Ava heir-apparent."
  },
  {
    "Julian Day Number": 2303254,
    "Myanmar Year": 956,
    "Myanmar Month": "Waso",
    "Moon Phase": "Waning",
    "Fortnight Day": 13,
    "Day of the Week": "Friday",
    "description": "Palace struck by lightning."
  },
  {
    "Julian Day Number": 2304111,
    "Myanmar Year": 958,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waxing",
    "Fortnight Day": 9,
    "Day of the Week": "Sunday",
    "description": "Queen Min Phyu dies."
  },
  {
    "Julian Day Number": 2304545,
    "Myanmar Year": 959,
    "Myanmar Month": "Waso",
    "Moon Phase": "New moon",
    "Fortnight Day": 15,
    "Day of the Week": "Saturday",
    "description": "Nyaungyan takes Yamethin."
  },
  {
    "Julian Day Number": 2304565,
    "Myanmar Year": 959,
    "Myanmar Month": "Wagaung",
    "Moon Phase": "Waning",
    "Fortnight Day": 5,
    "Day of the Week": "Friday",
    "description": "Nyaungyan takes Pagan."
  },
  {
    "Julian Day Number": 2304591,
    "Myanmar Year": 959,
    "Myanmar Month": "Tawthalin",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Wednesday",
    "description": "Nyaungyan moves into Ava Palace."
  },
  {
    "Julian Day Number": 2304610,
    "Myanmar Year": 959,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waxing",
    "Fortnight Day": 6,
    "Day of the Week": "Monday",
    "description": "Thado Dhamma Yaza III assassinated."
  },
  {
    "Julian Day Number": 2304893,
    "Myanmar Year": 960,
    "Myanmar Month": "First Waso",
    "Moon Phase": "Waning",
    "Fortnight Day": 9,
    "Day of the Week": "Thursday",
    "description":
        "Nyaungyan orders new construction works at Ava. (Small leap year in Ava)"
  },
  {
    "Julian Day Number": 2305435,
    "Myanmar Year": 961,
    "Myanmar Month": "Pyatho",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Sunday",
    "description": "Nanda surrenders to Toungoo and Arakan."
  },
  {
    "Julian Day Number": 2305492,
    "Myanmar Year": 961,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 2,
    "Day of the Week": "Monday",
    "description": "Minye Thihathu returns to Toungoo."
  },
  {
    "Julian Day Number": 2305574,
    "Myanmar Year": 962,
    "Myanmar Month": "Kason",
    "Moon Phase": "Waning",
    "Fortnight Day": 10,
    "Day of the Week": "Saturday",
    "description": "Siamese forces retreat from Toungoo."
  },
  {
    "Julian Day Number": 2305819,
    "Myanmar Year": 962,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Saturday",
    "description": "Nyaungyan begins campaign to Nyaungshwe."
  },
  {
    "Julian Day Number": 2306211,
    "Myanmar Year": 963,
    "Myanmar Month": "Tabodwe",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Saturday",
    "description": "Nyaungyan visits Shwethalyaung Pagoda."
  },
  {
    "Julian Day Number": 2306232,
    "Myanmar Year": 963,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Sunday",
    "description": "Campaign to Bhamo begins."
  },
  {
    "Julian Day Number": 2306629,
    "Myanmar Year": 964,
    "Myanmar Month": "Late Tagu",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Friday",
    "description": "Donates labor at the Sandamuni Pagoda, Ava."
  },
  {
    "Julian Day Number": 2306861,
    "Myanmar Year": 965,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 12,
    "Day of the Week": "Saturday",
    "description": "Donates to the relic chamber of the Sandamuni."
  },
  {
    "Julian Day Number": 2307344,
    "Myanmar Year": 966,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waning",
    "Fortnight Day": 8,
    "Day of the Week": "Friday",
    "description": "Donates to the relic chamber of the Sandamuni."
  },
  {
    "Julian Day Number": 2307349,
    "Myanmar Year": 966,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waning",
    "Fortnight Day": 13,
    "Day of the Week": "Wednesday",
    "description": "Dedicates a steele at the pagoda."
  },
  {
    "Julian Day Number": 2307476,
    "Myanmar Year": 967,
    "Myanmar Month": "Wagaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 7,
    "Day of the Week": "Thursday",
    "description": "Holds court about invasion of Hsenwi, Hsipaw and Mong Mit."
  },
  {
    "Julian Day Number": 2307779,
    "Myanmar Year": 968,
    "Myanmar Month": "Nayon",
    "Moon Phase": "Full moon",
    "Fortnight Day": 15,
    "Day of the Week": "Saturday",
    "description":
        "Anaukpetlun holds new umbrella raising ceremony at the Sandamuni ."
  },
  {
    "Julian Day Number": 2308080,
    "Myanmar Year": 968,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waning",
    "Fortnight Day": 6,
    "Day of the Week": "Saturday",
    "description": "Builds monastery for the Bame Sayadaw."
  },
  {
    "Julian Day Number": 2308299,
    "Myanmar Year": 969,
    "Myanmar Month": "Tazaungmon",
    "Moon Phase": "Waxing",
    "Fortnight Day": 4,
    "Day of the Week": "Monday",
    "description": "Prome campaign begins."
  },
  {
    "Julian Day Number": 2308572,
    "Myanmar Year": 970,
    "Myanmar Month": "Wagaung",
    "Moon Phase": "Waxing",
    "Fortnight Day": 11,
    "Day of the Week": "Monday",
    "description": "Anaukpetlun takes Prome."
  },
  {
    "Julian Day Number": 2308637,
    "Myanmar Year": 970,
    "Myanmar Month": "Thadingyut",
    "Moon Phase": "Waning",
    "Fortnight Day": 2,
    "Day of the Week": "Wednesday",
    "description": "Returns to Ava."
  },
  {
    "Julian Day Number": 2308783,
    "Myanmar Year": 970,
    "Myanmar Month": "Tabaung",
    "Moon Phase": "Waning",
    "Fortnight Day": 1,
    "Day of the Week": "Tuesday",
    "description": "Atula Sanda Dewi becomes chief queen."
  }
];

const myanmarYearNames = {
  "Hpusha": "ပုဿနှစ်",
  "Magha": "မာခနှစ်",
  "Phalguni": "ဖ္လကိုန်နှစ်",
  "Chitra": "စယ်နှစ်",
  "Visakha": "ပိသျက်နှစ်",
  "Jyeshtha": "စိဿနှစ်",
  "Ashadha": "အာသတ်နှစ်",
  "Sravana": "သရဝန်နှစ်",
  "Bhadrapaha": "ဘဒြနှစ်",
  "Asvini": "အာသိန်နှစ်",
  "Krittika": "ကြတိုက်နှစ်",
  "Mrigasiras": "မြိက္ကသိုဝ်နှစ်"
};
