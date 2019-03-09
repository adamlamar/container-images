#!/bin/sh

# Allows to write core file
ulimit -c unlimited

ZIM=/srv/upload/zim/
SCRIPT=`readlink -f $0/../`
SCRIPT_DIR=`dirname "$SCRIPT"`
ARGS="--withZimFullTextIndex --adminEmail=contact@kiwix.org --deflateTmpHtml --verbose --skipHtmlCache --skipCacheCleaning"
MWOFFLINER="mwoffliner --format= --format=novid --format=nopic $ARGS"
MWOFFLINER_MOBILE="$MWOFFLINER --mobileLayout"
MWMATRIXOFFLINER="mwmatrixoffliner --mwUrl=https://meta.wikimedia.org/ $ARGS"

# Gentoo
# MIGRATED $MWOFFLINER --mwUrl=https://wiki.installgentoo.com --localParsoid --mwApiPath=api.php --mwWikiPath=index.php --outputDirectory=$ZIM/other/ &&

# RationalWiki
# MIGRATED $MWOFFLINER --mwUrl=https://rationalwiki.org/ --localParsoid --outputDirectory=$ZIM/other/ --speed=0.5 &&

# Vikidia
VIKIDIA_ARGS="--outputDirectory=$ZIM/vikidia/ --addNamespaces=102"
# MIGRATED $MWOFFLINER --mwUrl=https://fr.vikidia.org/ $VIKIDIA_ARGS &&
# MIGRATED $MWOFFLINER --mwUrl=https://es.vikidia.org/ $VIKIDIA_ARGS &&
# MIGRATED $MWOFFLINER --mwUrl=https://eu.vikidia.org/ $VIKIDIA_ARGS &&
# MIGRATED $MWOFFLINER --mwUrl=https://it.vikidia.org/ $VIKIDIA_ARGS &&
# MIGRATED $MWOFFLINER --mwUrl=https://en.vikidia.org/ $VIKIDIA_ARGS &&
# MIGRATED $MWOFFLINER --mwUrl=https://ca.vikidia.org/ $VIKIDIA_ARGS &&
# MIGRATED $MWOFFLINER --mwUrl=https://ru.vikidia.org/ $VIKIDIA_ARGS &&
# MIGRATED $MWOFFLINER --mwUrl=https://scn.vikidia.org/ $VIKIDIA_ARGS &&

# Wikipedia FR Tunisie
/srv/kiwix-tools/tools/scripts/listCategoryEntries.pl --host=fr.wikipedia.org --path=w --exploration=5 --namespace=1 --category="Évaluation_des_articles_sur_la_Tunisie" | sed 's/Discussion://' | sort -u > "$SCRIPT_DIR/tunisie" &&
echo "Portail:Tunisie/Index thématique" >> "$SCRIPT_DIR/tunisie" &&
wget "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Flag_of_Tunisia.svg/320px-Flag_of_Tunisia.svg.png" -O "$SCRIPT_DIR/tunisie.png" &&
$MWOFFLINER_MOBILE --mwUrl="https://fr.wikipedia.org/" --parsoidUrl="https://fr.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="Encyclopédie de la Tunisie" --customZimDescription="Le meilleur de Wikipédia sur la Tunisie" --customMainPage="Portail:Tunisie/Index_thématique" --customZimFavicon="$SCRIPT_DIR/tunisie.png" --articleList="$SCRIPT_DIR/tunisie" --outputDirectory=$ZIM/wikipedia/ &&

# Wikipedia ES Venezuela
wget "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Flag_of_Venezuela.svg/320px-Flag_of_Venezuela.svg.png" -O "$SCRIPT_DIR/venezuela.png" &&
$MWOFFLINER_MOBILE --mwUrl="https://es.wikipedia.org/" --parsoidUrl="https://es.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="Enciclopedia de Venezuela" --customZimDescription="Selección de artículos de Wikipedia para Venezuela" --customMainPage="Wikipedia:Wikipedia_en_CD/Selección_de_artículos_para_Venezuela/Main" --customZimFavicon="$SCRIPT_DIR/venezuela.png" --articleList="$SCRIPT_DIR/selections/venezuela.lst" --outputDirectory=$ZIM/wikipedia/ &&

# Wikem
# MIGRATED $MWOFFLINER --mwUrl=https://wikem.org/ --localParsoid --outputDirectory=$ZIM/other/ --speed=0.1

# Psiram
# MIGRATED for LANG in de fr en it ru ; do $MWOFFLINER --mwUrl=https://www.psiram.com/$LANG --mwWikiPath=index.php --mwApiPath=api.php --localParsoid --speed=0.5 --outputDirectory=$ZIM/psiram/ ; done

# WikiMed
/srv/kiwix-tools/tools/scripts/listCategoryEntries.pl --host=en.wikipedia.org --path=w --exploration=5 --namespace=1 --category="WikiProject_Women's_health_articles" --category="WikiProject_Microbiology_articles" --category="WikiProject_Physiology_articles" --category="WikiProject_Medicine_articles" --category="WikiProject_Dentistry_articles" --category="WikiProject_Anatomy_articles" --category="WikiProject_Pharmacology_articles" --category="WikiProject_Sanitation_articles" | sed 's/Talk://' | sort -u > "$SCRIPT_DIR/medicine_unfiltered" &&
/srv/kiwix-tools/tools/scripts/listCategoryEntries.pl --host=en.wikipedia.org --path=w --exploration=5 --namespace=1 --category="WikiProject_Hospitals_articles" --category="WikiProject_History_of_Science_articles" --category="WikiProject_Academic_Journal_articles" --category="WikiProject_Visual_arts_articles" --category="WikiProject_Biography_articles" --category="WikiProject_Companies_articles" | sed 's/Talk://' | sort -u > "$SCRIPT_DIR/medicine_filter" &&
grep -Fxv -f "$SCRIPT_DIR/medicine_filter" "$SCRIPT_DIR/medicine_unfiltered" | sort -u > "$SCRIPT_DIR/medicine" &&
echo "Wikipedia:WikiProject_Medicine/Open_Textbook_of_Medicine" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Cardiology" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Children's health" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Dermatology" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Ears_nose_throat" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Endocrinology" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Eye_diseases" >>  "$SCRIPT_DIR/medicine" &&
echo "Book:Gastroenterology" >> "$SCRIPT_DIR/medicine" &&
echo "Book:General_surgery" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Infectious_disease" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Medications" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Mental health" >>  "$SCRIPT_DIR/medicine" &&
echo "Book:Neurology" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Ortho" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Orthopedics" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Cancer" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Ophthalmology" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Pediatrics" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Psychiatry" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Rheumatology" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Skin diseases" >> "$SCRIPT_DIR/medicine" &&
echo "Book:Women's_health" >> "$SCRIPT_DIR/medicine" &&
wget "https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Wiki_Project_Med_Foundation_logo.svg/335px-Wiki_Project_Med_Foundation_logo.svg.png" -O "$SCRIPT_DIR/medicine.png" &&

# nodet should not be refreshed
# $MWOFFLINER_MOBILE --format=nodet --mwUrl="https://en.wikipedia.org/" --parsoidUrl="https://en.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="50.000 healthcare articles from Wikipedia" --customMainPage="Wikipedia:WikiProject_Medicine/Open_Textbook_of_Medicine2" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --format="nopic,nodet" --outputDirectory=$ZIM/wikipedia/ &&
mwoffliner --format=novid --format=nopic --mobileLayout $ARGS --format=nodet --mwUrl="https://en.wikipedia.org/" --parsoidUrl="https://en.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="50.000 healthcare articles from Wikipedia" --customMainPage="Wikipedia:WikiProject_Medicine/Open_Textbook_of_Medicine2" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --format="nopic,nodet" --outputDirectory=$ZIM/wikipedia/ &&

# Wikipedia EN medicine langlinks
cat "$SCRIPT_DIR/medicine" | /srv/kiwix-tools/tools/scripts/listLangLinks.pl --host=en.wikipedia.org --path=w --readFromStdin --language=ja --language=as --language=bn --language=gu --language=hi --language=kn --language=ml --language=de --language=bpy --language=mr --language=lo --language=or --language=pa --language=ta --language=te --language=ur --language=fa --language=fr --language=zh --language=pt --language=ar --language=es --language=it > "$SCRIPT_DIR/medicine.langlinks"

wget "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Wiki_Project_Med_Foundation_logo_DACH.svg/1024px-Wiki_Project_Med_Foundation_logo_DACH.svg.png" -O "$SCRIPT_DIR/medicinede.png" &&
cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tde\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine" &&
$MWOFFLINER_MOBILE --mwUrl="https://de.wikipedia.org/" --parsoidUrl="https://de.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medizin Enzyklopädie" --customZimDescription="Wikipedia-Artikeln zu den Themen Gesundheit, Hygiene, Anatomie und Arzneimitte" --customMainPage="Wikipedia:Redaktion_Medizin/Open_Textbook_of_Medicine" --customZimFavicon="$SCRIPT_DIR/medicinede.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tlo\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://lo.wikipedia.org/" --parsoidUrl="https://lo.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tas\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://as.wikipedia.org/" --parsoidUrl="https://as.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tbn\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://bn.wikipedia.org/" --parsoidUrl="https://bn.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tgu\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://gu.wikipedia.org/" --parsoidUrl="https://gu.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\thi\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://hi.wikipedia.org/" --parsoidUrl="https://hi.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tkn\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://kn.wikipedia.org/" --parsoidUrl="https://kn.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tml\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://ml.wikipedia.org/" --parsoidUrl="https://ml.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tbpy\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://bpy.wikipedia.org/" --parsoidUrl="https://bpy.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tmr\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://mr.wikipedia.org/" --parsoidUrl="https://mr.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

wget "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/OdiaOfflineMed.png/447px-OdiaOfflineMed.png" -O "$SCRIPT_DIR/medicineor.png" &&
cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tor\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://or.wikipedia.org/" --parsoidUrl="https://or.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="ମେଡିକାଲ ଉଇକିପିଡିଆ" --customZimDescription="ନିଃଶୁଳ୍କ ସ୍ୱାସ୍ଥ୍ୟସେବା ସମ୍ବନ୍ଧୀୟ ବିଷୟମାନ ପ୍ରତ୍ୟେକ ସ୍ଥାନରେ ଅଫଲାଇନରେ ଉପଲବ୍ଧ ।" --customMainPage="ବ୍ୟବହାରକାରୀ:Doc_James/Open_Textbook_of_Medicine" --customZimFavicon="$SCRIPT_DIR/medicineor.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

wget "https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Wiki_Project_Med_Foundation_logo.svg/400px-Wiki_Project_Med_Foundation_logo.svg.png" -O "$SCRIPT_DIR/medicineja.png" &&
cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tja\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine" &&
$MWOFFLINER_MOBILE --mwUrl="https://ja.wikipedia.org/" --parsoidUrl="https://ja.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="医療ウィキペディア" --customZimDescription="どこでも利用可能な無料オフラインのヘルスケア記事!" --customMainPage="プロジェクト:医学/Open_Textbook_of_Medicine" --customZimFavicon="$SCRIPT_DIR/medicineja.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tpa\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://pa.wikipedia.org/" --parsoidUrl="https://pa.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tta\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://ta.wikipedia.org/" --parsoidUrl="https://ta.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tte\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://te.wikipedia.org/" --parsoidUrl="https://te.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tur\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://ur.wikipedia.org/" --parsoidUrl="https://ur.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="WikiMed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tfa\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
wget "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Wiki_Project_Med_Foundation_logo_Persian.svg/1024px-Wiki_Project_Med_Foundation_logo_Persian.svg.png" -O "$SCRIPT_DIR/medicinefa.png" &&
$MWOFFLINER_MOBILE --mwUrl="https://fa.wikipedia.org/" --parsoidUrl="https://fa.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="ویکی‌پدیای پزشکی" --customMainPage="ویکی‌پدیا:ویکی‌پروژه_پزشکی/کتابچه_آزاد_پزشکی" --customZimDescription="مقالات پزشکی قابل دسترس به صورت آفلاین و در هر کجا، کاملاً رایگان" --customZimFavicon="$SCRIPT_DIR/medicinefa.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tfr\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine_fr" &&
/srv/kiwix-tools/tools/scripts/listCategoryEntries.pl --host=en.wikipedia.org --category="Évaluation_des_articles_Soins_infirmiers_et_profession_infirmière" --category="Évaluation_des_articles_de_premiers_secours_et_de_secourisme" --category="Évaluation_des_articles_de_médecine" --category="Évaluation_des_articles_Anatomie" --category="Évaluation_des_articles_pharmacie" --path=w --exploration=5 --namespace=1 | sed 's/Talk://' | sort -u >> "$SCRIPT_DIR/medicine_fr" &&
cat "$SCRIPT_DIR/medicine_fr" | sort -u > "$SCRIPT_DIR/medicine" &&
$MWOFFLINER_MOBILE --mwUrl="https://fr.wikipedia.org/" --parsoidUrl="https://fr.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="Encyclopédie médicale WikiMed" --customMainPage="Utilisateur:Doc_James/Open_Textbook_of_Medicine" --customZimDescription="L'Encyclopédie médicale de Wikipédia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tit\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
$MWOFFLINER_MOBILE --mwUrl="https://it.wikipedia.org/" --parsoidUrl="https://it.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="Wikimed Medical Encyclopedia" --customZimDescription="The Wikipedia Medical Encyclopedia" --customZimFavicon="$SCRIPT_DIR/medicine.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tzh\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
wget "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Traditional_Chinese.png/362px-Traditional_Chinese.png" -O "$SCRIPT_DIR/medicinezh.png" &&
$MWOFFLINER_MOBILE --mwUrl="https://zh.wikipedia.org/" --parsoidUrl="https://zh.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="醫學維基百科" --customMainPage="Wikipedia:医学专题/醫學開放教科書" --customZimDescription="五萬篇健康照護的文章目前支援離線閱讀，而且任何地方都可免費使用!!!" --customZimFavicon="$SCRIPT_DIR/medicinezh.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tar\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
wget "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Wikimed_Arabic_Logo.svg/876px-Wikimed_Arabic_Logo.svg.png" -O "$SCRIPT_DIR/medicinear.png" &&
$MWOFFLINER_MOBILE --mwUrl="https://ar.wikipedia.org/" --parsoidUrl="https://ar.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="وِيكيبيديا الطبية" --customMainPage="ويكيبيديا:مشروع_ويكي_طب/مرجع_بداية_التطبيق_الطبي2" --customZimDescription="مَقالات عن الرعاية الصحية متوافرة بدون اتصال بالإنترنت في كل مكان وبشكل مجاني!" --customZimFavicon="$SCRIPT_DIR/medicinear.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tes\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
wget "https://upload.wikimedia.org/wikipedia/commons/2/25/Wiki_Offline_Spanish_logo_colored_final.png" -O "$SCRIPT_DIR/medicinees.png" &&
$MWOFFLINER_MOBILE --mwUrl="https://es.wikipedia.org/" --parsoidUrl="https://es.wikipedia.org/api/rest_v1/page/html/" --customZimTitle="Wikipedia Médica" --customMainPage="Wikiproyecto:Medicina/Open_Textbook_of_Medicine" --customZimDescription="La Enciclopedia medical de Wikipedia" --customZimFavicon="$SCRIPT_DIR/medicinees.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

cat "$SCRIPT_DIR/medicine.langlinks" | grep -P '\tpt\t' | cut -f3 | grep -v -P '^$' > "$SCRIPT_DIR/medicine"
wget "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Wiki_Project_Med_Foundation_logo_pt.svg/450px-Wiki_Project_Med_Foundation_logo_pt.svg.png" -O "$SCRIPT_DIR/medicinept.png" &&
$MWOFFLINER_MOBILE --mwUrl="https://pt.wikipedia.org/" --parsoidUrl="https://pt.wikipedia.org/api/rest_v1/page/html/" --customMainPage="Wikipédia:WikiProject_Medicine/Open_Textbook_of_Medicine" --customZimTitle="Medical Wikipedia" --customZimDescription="Artigos de assistência médica, em todo lugar, de graça!" --customZimFavicon="$SCRIPT_DIR/medicinept.png" --articleList="$SCRIPT_DIR/medicine" --outputDirectory=$ZIM/wikipedia/ &&

# Wikivoyage EN
# MIGRATED $MWOFFLINER_MOBILE --mwUrl="https://en.wikivoyage.org/" --parsoidUrl="https://en.wikivoyage.org/api/rest_v1/page/html/" --customMainPage="Wikivoyage:Offline_reader_Expedition/Home_page" --outputDirectory=$ZIM/wikivoyage/ &&

# Wikivoyage EN Europe
/srv/kiwix-tools/tools/scripts/listCategoryEntries.pl --host=en.wikivoyage.org --path=w --exploration=8 --namespace=0 --category="Europe" | sort -u > europe &&
$MWOFFLINER_MOBILE --customZimTitle="Wikivoyage - Europe" --articleList=europe --mwUrl="https://en.wikivoyage.org/" --parsoidUrl="https://en.wikivoyage.org/api/rest_v1/page/html/" --customMainPage="Wikivoyage:Offline_reader_Expedition/Europe_Home_page" --outputDirectory=$ZIM/wikivoyage/ &&

# Wikivoyage DE
# MIGRATED $MWOFFLINER_MOBILE --mwUrl="https://de.wikivoyage.org/" --parsoidUrl="https://de.wikivoyage.org/api/rest_v1/page/html/" --customMainPage="Benutzer:Stephane_(Kiwix)/Hauptseite" --outputDirectory=$ZIM/wikivoyage/ &&

# Wikinews
# MIGRATED $MWMATRIXOFFLINER --project=wikinews --outputDirectory=$ZIM/wikinews/ &&

# Ekopedia
# MIGRATED $MWOFFLINER --mwUrl=https://www.ekopedia.fr/ --mwApiPath=api.php --localParsoid --outputDirectory=$ZIM/other/ &&

# Kochwiki
# MIGRATED $MWOFFLINER --mwUrl=http://www.kochwiki.org/ --localParsoid --outputDirectory=$ZIM/other/ &&

# Archlinux wiki
wget https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Archlinux-icon-crystal-64.svg/65px-Archlinux-icon-crystal-64.svg.png &&
# MIGRATED $MWOFFLINER --mwUrl=https://wiki.archlinux.org/ --mwWikiPath="index.php" --mwApiPath="api.php" --localParsoid --addNamespaces="4,12" --customZimFavicon=65px-Archlinux-icon-crystal-64.svg.png --outputDirectory=$ZIM/other/ &&

# Wikiwel.org
# MIGRATED $MWOFFLINER --mwUrl="https://wikiwel.com" --mwApiPath="/wikihealing/api.php" --mwWikiPath="/wikihealing/" --localParsoid --speed=0.1 --outputDirectory=$ZIM/other/ &&

# Ray Charles
/srv/kiwix-tools/tools/scripts/listCategoryEntries.pl --path=w --host=en.wikipedia.org --category="Ray_Charles" --namespace=0 --explorationDepth=3 > ray_charles &&
$MWOFFLINER_MOBILE --mwUrl="https://en.wikipedia.org/" --articleList="ray_charles" --customZimTitle="Ray Charles" --customZimDescription="Wikipedia articles about Ray Charles" --customZimFavicon="ray_charles.png" --format= --format=novid --format=nopic --format=nodet --outputDirectory=$ZIM/wikipedia/ &&

# Art of problem solving
# no idea where favicon is from  
# MIGRATED $MWOFFLINER --mwUrl="https://artofproblemsolving.com/" --mwApiPath="/wiki/api.php" --localParsoid --customZimFavicon=artofproblemsolving.png --outputDirectory=$ZIM/other/ &&

# Granbluefantasy
# MIGRATED $MWOFFLINER --mwUrl="https://gbf.wiki/" --mwApiPath="/api.php" --localParsoid --speed=0.1 --filenamePrefix="granbluefantasy_en_all" --outputDirectory=$ZIM/other/ &&

# Klexikon
# no idea where favicon is from  
# MIGRATED $MWOFFLINER --mwApiPath="api.php" --mwUrl="https://klexikon.zum.de/" --localParsoid --customZimFavicon="klexikon.png" --outputDirectory=$ZIM/other/ &&

# Westeros
# MIGRATED $MWOFFLINER --mwUrl="https://awoiaf.westeros.org/" --localParsoid --mwApiPath="api.php" --mwWikiPath="index.php" --outputDirectory=$ZIM/other/ &&

# Cyclowiki
wget https://upload.wikimedia.org/wikipedia/commons/d/d2/Cyclowiki.png &&
# MIGRATED $MWOFFLINER --mwUrl="http://cyclowiki.org" --localParsoid --customZimFavicon=Cyclowiki.png &&

# Test ZIM file
echo "Sven-Åke_Johansson" > test.articles &&
echo "Orbite_héliosynchrone" >> test.articles &&
echo "Warrington" >> test.articles &&
wget https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Test_art.png/320px-Test_art.png &&
mwoffliner --withZimFullTextIndex --adminEmail=kelson@kiwix.org --mwUrl=https://fr.wikipedia.org/ --mobileLayout --format= --articleList=test.articles --verbose --customZimTitle=Test --customZimDescription="ZIM file for testing purpose" --customZimFavicon=320px-Test_art.png --outputDirectory=$ZIM/wikipedia/
