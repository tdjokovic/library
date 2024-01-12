-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 12, 2024 at 06:06 PM
-- Server version: 8.0.31
-- PHP Version: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library`
--

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
CREATE TABLE IF NOT EXISTS `author` (
  `authorID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) COLLATE utf32_unicode_ci NOT NULL,
  `lastName` varchar(255) COLLATE utf32_unicode_ci NOT NULL,
  PRIMARY KEY (`authorID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`authorID`, `firstName`, `lastName`) VALUES
(1, 'Stiven', 'King'),
(2, 'Donato', 'Karizi'),
(3, 'Miodrag', 'Majic'),
(4, 'Džon Ronald Rejel', 'Tolkin');

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
CREATE TABLE IF NOT EXISTS `book` (
  `bookID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf32_unicode_ci NOT NULL,
  `authorID` int NOT NULL,
  `description` longtext CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `availability` tinyint(1) NOT NULL,
  PRIMARY KEY (`bookID`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`bookID`, `name`, `authorID`, `description`, `availability`) VALUES
(1, 'Zelena milja', 1, 'U Državnom zatvoru Hladna planina, duž jednog usamljenog niza ćelija zvanog Zelena milja, osuđenici čekaju smrt u naručju Vesele varnice. Ovde čuvari, kao što su čestiti Pol Edžkomb i sadista Persi Vetmur, paze na njih. Ali bili oni dobri ili zli, nevini ili krivi, svi će preneraženo dočekati novog zatvorenika, Džona Kofija, osuđenog na smrt zbog strašnog zločina. Da li je Kofi đavo u ljudskom obličju? Ili je, možda, nešto sasvim, sasvim drugo?', 0),
(2, 'Kudžo', 1, 'U Kasl Roku, mirnom gradiću u Mejnu, život ide svojim mirnim tokom. Omiljeni pas u kraju, dobroćudni bernardinac Kudžo, veselo trčkara kroz šume i poljane... sve dok jedne noći ne izroni iz tame, užarenog pogleda u očima koje obećavaju stravičnu smrt.\r\n\r\nLeto 1980. bilo je vrelo. A bilo je i krvavo. Sve je počelo tog toplog junskog dana, kada je Kudžo potrčao za zecom. Ili je možda počelo još one majske noći, kada je Ted Trenton video čudovište u ormaru... Naravno, roditelji su ga uverili da je to bila noćna mora, i da čudovišta ne postoje, zar ne? Ali prevarili su se: čak i u spokojnim, tihim gradićima, čudovišta vrebaju, skrivena u senci.', 1),
(3, 'Zmajeve oči', 1, 'Nekada davno u kraljevstvu po imenu Delajn živeo je jedan kralj koji je imao dva sina. Roland Dobri nije bio ni najbolji ni najgori kralj koji je vladao tom zemljom. Svi koji su ga poznavali i koji su videli njegovo sivo lice i drhtave ruke dok je primao zvanice na dvoru slagali su se u proceni da će novi kralj biti krunisan za najviše pet godina. Razgovarali su o budućem kralju, Rolandovom najstarijem sinu, Piteru.\r\n\r\nAli jedan čovek je smišljao, planirao i pripremao nešto drugo: kako da omogući da Rolandov mlađi sin, Tomas, bude krunisan. Taj čovek bio je Fleg, kraljev čarobnjak.', 1),
(4, 'Groblje kućnih ljubimaca', 1, 'Porodica Krid započinje novi život u prelepoj kući u Mejnu, malom, ruralnom mestu. U novom okruženju sve je bajkovito, previše dobro da bi bilo istinito. Zlokobna tajna koja vreba nadomak kuće vrlo brzo će se poigrati sa porodičnom idilom.\r\n\r\nKada nesrećna sudbina zadesi porodičnog mačka Čurča, na nagovor suseda, Kridovi odlučuju da ga zakopaju na starom indijanskom groblju iza kuće. Međutim, narednog dana, mačak se vraća kući, ali nije isti kao pre. A onda nastaje pravi užas ̵ sledeći tragično strada njihov mlađi sin.', 0),
(5, 'To', 1, 'Grupa odvažne dece, koja je leta 1958. sišla u kanalizacijsku mrežu ispod ukletog gradića Derija kako bi uništila čudovišno stvorenje, ponovno je na okupu, dvadeset osam godina kasnije. Ove sada odrasle ljude posvećene poslu i rasute širom Amerike, obećanje iz prošlosti pozvaće natrag u Deri: To se opet pokrenulo i započelo novu seriju jezivih zločina.\r\n\r\nIstorija se ponavlja: skoro svi učesnici epske borbe sada su ponovo na broju, spremni da se opet uhvate u koštac s neverovatnim. To, međutim, zna da magija dečjeg verovanja u nemoguće slabi s godinama i da članovi Kluba gubitnika kao odrasli nemaju šanse u ovoj borbi na život i smrt, osim, možda, pomoću čarobnog praha detinjstva…', 1),
(6, 'Šaptač', 2, 'Otkiven je stravičan zločin: šest odsečenih ruku poređano je u misteriozan krug i zakopano na proplanku u šumi. Pet pripada devojkama koje se vode kao nestale. Šesta ruka tek treba da bude identifikovana. Najstrašnije od svega jeste to što tela devojaka, bilo da su žive ili mrtve, nigde nisu pronađena.\r\n\r\nIskusna istražiteljka Mila Vaskez i Goran Gavila, uznemirujuće intuitivni kriminolog, pokušavaju da proniknu u zagonetku: veruju da su uspeli da pronađu pravog osumnjičenog, sve dok se ne pokaže da zapravo ne postoji održiva veza između njega i svih nestalih devojaka, osim prve. Drugi slučaj kidnapovanja upućuje u potpuno drugačijem smeru, stvarajući više pitanja nego odgovora.', 1),
(7, 'Kuća svetlosti', 2, 'Zove se Eva, ima deset godina, a sa njom su samo guvernanta i au pair devojka, Finkinja Maja Salo. Od roditelja nema ni traga. Maja je zabrinuta za devojčicu i zato traži pomoć Pjetra Gerbera, najboljeg firentinskog hipnotizera, uspavljivača dece. Već neko vreme, Eva nije zaista sama. Sa njom je imaginarni prijatelj, dete bez imena i bez lika. I upravo zbog njegovog prisustva, Eva je možda u opasnosti.\r\n\r\nAli reputacija Pjetra Gerbera je uništena, a na neki način, i on sam. Iako je zbunjen i nesiguran u svoju sudbinu, i uprkos tome što ga muče sumnje, Pjetro prihvata da se suoči sa Evom. Ili, tačnije, sa njenim imaginarnim prijateljem. Tada se pred njim širom otvaraju nevidljiva vrata. Glas izgubljenog deteta koje priča preko Eve kad je ona pod hipnozom nije mu nepoznat.', 1),
(8, 'Kuća glasova', 2, 'Pjetro Gerber nije običan psiholog. Specijalizovan je za hipnozu, a svi njegovi pacijenti imaju nešto zajedničko: oni su deca. Često poseduju važne informacije, zakopane duboko u njihovom krhkom sećanju, detalje koji policiji mogu da posluže u istragama.\r\n\r\nMeđutim, kada mu stigne poziv sa drugog kraja sveta, od koleginice iz Australije koja mu preporučuje jednog pacijenta, Gerber je zbunjen i nepoverljiv. Jer Hana Hol nije dete, već odrasla žena. Muči je sećanje iz detinjstva, koje možda nije stvarno. Da bi saznala da li je u pitanju istina ili iluzija, Gerber mora da joj pomogne da ponovo pronađe devojčicu koju čuva u sebi. Devojčicu sa mnogo imena, koja je sa svojom porodicom živela na čarobnom mestu, u kući glasova. Devojčicu od deset godina, koja je prisustvovala ubistvu. Ili ga možda nije samo posmatrala. Možda je ubica upravo ona.', 1),
(9, 'Kuća bez sećanja', 2, 'Nestali dečak pronađen je u šumi kada su svi već izgubili svaku nadu. Niko ima dvanaest godina i deluje da je dobro: neko ga je hranio, oblačio, brinuo se o njemu. Ali nije moguće otkriti ko, jer Nikolin ne govori.\r\n\r\nNjegova svest je poput kuće u potpunom mraku, u koju je naizgled nemoguće ući. Jedini koji može da dopre do njega je dečji psiholog Pjetro Gerber. Najbolji hipnotizer u Firenci pozvan je da istraži Nikov um i otkrije njegovu priču. I iako deluje nemoguće, on uspeva u tome: prepoznaje okidač – pokret, kombinaciju reči – koji pokreće nešto u dečaku. Ali kada Niko počne da priča svoju priču, Pjetro Gerber shvata da je otvorio vrata zaboravljene sobe. Sobe u kojoj se krije nešto zlokobno, zlo.', 1),
(10, 'Dečak od stakla', 2, 'On je čovek koji nema više ništa – nema identitet, nema sećanje, ni ljubav i mržnju – jedino svoj bes... I jedan skriveni talenat. Jer Markus je poslednji ispovednik: sveštenik koji je sposoban da otkrije anomalije i da nazre niti od kojih je ispleteno svako ubistvo. Ali neke niti su toliko zapletene da možda čak ni on neće uspeti ih rasplete.\r\n\r\nOna je žena koja pokušava da ponovo pronađe sebe. Dok Markus krišom obilazi mesto zločina, Sandra se tu skriva iza objektiva svog foto-aparata. Ona je forenzički fotograf: njen talenat je da fotografiše prazninu, da je učini vidljivom. Ali ovoga puta praznina je tako mračna i duboka da preti da je proguta.\r\nDok ubilačko bezumlje divlja oko njih, Markus i Sandra pokušavaju da proniknu u um zločinca i otkriju njegov plan, užasan i zastrašujuće briljantan. I baš kada pomisle da su se približili rešenju, delići slagalice otkrivaju stravičnu sliku koju nisu mogli ni da naslute...\r\nZlo je pravilo. Dobro je izuzetak.', 1),
(11, 'Deca zla', 3, 'U središtu romana Deca zla nalazi se dramatično ubistvo, a potraga za počiniocem biće samo okidač za niz drugih događaja koji će otkriti da je reč o zločinu strasti, osvete, opomene i simbolike.\r\n\r\nKako pronaći krivca u svetu u kom je istina izobličena, a prošlost junaka utkana u njihovu sadašnjost neraskidivim nitima zla? Nikola Bobić, beogradski advokat, pokušaće da pronađe odgovor na to pitanje, ni ne sluteći da će ga odgovor zauvek promeniti.\r\nOva priča tiče se svih nas, jer ćemo u njoj pronaći obrise naše društvene stvarnosti, ali, što je još važnije, pronaći ćemo izgubljeno zrno nade – čak i u društvenom sistemu duboko ogrezlom u korupciju ima mesta za heroje.', 1),
(12, 'Ostrvo pelikana', 3, 'Posle romana Deca zla, koji je za godinu i po dana pročitalo skoro trideset hiljada ljudi, Miodrag Majić se ponovo latio pera i podelio je sa nama priču koja će nas još jednom navesti da se zagledamo u stvarnost širom otvorenih očiju i zapitamo se da li je moguće sačuvati sebe u društvu u kojem je sudbina pojedinca beznačajna poput zrnca peska koje vetar raznosi prenoseći ga iz jednog godišnjeg doba u drugo.\r\n\r\nPriča o Ajši i Gabrielu može postati priča svakoga od nas, ali ta priča se već sada tiče svih nas i upravo zato ćete ovu knjigu pročitatu u dahu, a siluete njenih junaka ukotviće se duboko u vama, pa se nemojte iznenaditi kad ih budete prepoznali u masi bezimenih i nepoznatih ljudi na ulicama ovog grada, ali i bilo kog drugog grada na svetu.', 1),
(13, 'U ime naroda i Nove priče', 3, 'Pred vama se nalazi dopunjeno izdanje knjige „U ime naroda“, u koju su uvrštene i priče koje su nastajale kasnije – one su objedinjene pod naslovom „Nove priče“. Prepoznaćete u njima istu poetičku nit kao u prvom izdanju ove knjige, što svedoči o piščevoj doslednosti u načinu literarizacije, odnosno transponovanju stvarnosti u tekst, ali i o ličnoj istrajnosti u ideji da se istina izgovori glasno – u ime naroda.', 1),
(14, 'Rudnik', 3, 'U središtu ove knjige nalazi se junak koji će vas od prve do poslednje stranice voditi kroz sopstvena sećanja. Kako ovu priču priča iz sanatorijuma, sve što bude kazao biće dovedeno u pitanje i podvrgnuto dodatnom preispitivanju. Međutim, to ga neće sprečiti da se još jednom zagleda u krhotine nekadašnjeg života. Njegova potreba za pričanjem zapravo jeste poslednji pokušaj da rekonstruiše prošlost ne bi li od njenih delova sastavio celovitu sliku, i tako konačno došao do istine.\r\n\r\nPogađate – osnovni motiv na toj slici jeste rudnik. O rudniku će se ispredati raznolike priče, i stvarne i nestvarne, ali on će ostati pod velom tajne sve dok glavni junak ne odluči da krene u potragu za njim. Saznanja do kojih bude došao promeniće njegov život iz korena i navešće ga na to da preispita sva dotadašnja uverenja o stvarnosti. Zbog svega toga, pripremite se da zakoračite u romaneskni svet u kojem ćete neprestano hodati po tankoj liniji između mogućeg i nemogućeg.', 1),
(15, 'Hobit', 4, 'Isprva krajnje nesklon pustolovini, Bilbo okleva i nerado kreće na tegoban put ka Samotnoj planini, i ne sluteći šta će mu se sve desiti na tom putu, da će susresti turobno stvorenje Goluma, da će i ne hoteći doći do magičnog prstena koji će pokrenuti čitav lanac velikih događaja, i da će uspeti svojim lukavstvom da se izbavi iz naizgled pogubnih prilika...', 1),
(16, 'Silmalirion', 4, 'Priče iz Silmariliona govore o najstarijoj istoriji Srednjeg sveta, temeljima Tolkinove mitologije i događajima koji prethode onima opisanim u Gospodaru prstenova. Dž.R.R. Tolkin je čitavog života radio na ovoj knjizi, ali je nije završio. Knjigu je 1977, četiri godine nakon Tolkinove smrti, na osnovu rukopisa i skica iz ostavštine dopunio i za štampu priredio njegov sin Kristofer.\r\n\r\nNaziv Silmarilion skraćeno je od „Kventa Silmarilion”, ili „Istorija Silmarila”, tri velika dragulja koja je stvorio Feanor, najdarovitiji od Vilovnjaka, i u kojima je zarobio svetlost Dva Drveta koja je obasjavala Valinor, zemlju bogova. Kada je Morgot, prvi Mračni Gospodar, uništio Drveće, ta svetlost je živela još samo u Silmarilima; Morgot ih je ugrabio i postavio u svoju krunu, čuvanu u neprobojnoj tvrđavi Angband na severu Srednjeg sveta. Silmarilion je istorija pobune Feanora i njegovog naroda protiv bogova, njihovog progona iz Srednjeg sveta i njihovog rata, beznadežnog uprkos svem junaštvu Vilovnjaka i Ljudi u borbi protiv velikog Neprijatelja.', 1),
(17, 'Družina prstena', 4, 'Kada ekscentrični Hobit Bilbo Bagins na oproštajnoj zabavi povodom svog 111. rođendana iznenada i naočigled zaprepašćenih gostiju volšebno nestane, u idiličnom Okrugu pokrenuće se lanac događaja koji će uzdrmati čitav Srednji svet i odrediti njegovu sudbinu. Bilbo je, naime, odlučio da ostatak života provede u vilovnjačkom carstvu Rivendal, i svu svoju imovinu ostavio je mladom rođaku Frodu Baginsu, uključujući i tajanstveni prsten koji njegovog nosioca čini nevidljivim. Ali dok se oprašta sa starim prijateljem Gandalfom, moćni čarobnjak shvata da je Bilbov prsten mnogo više od rekvizita za hobitske trikove...', 1),
(18, 'Dve kule', 4, 'Družina Prstena je na svom pohodu prošla razna iskušenja i na kraju se raspala - Gandalf je u borbi s demonom Balrogom nestao u utrobi zemlje, Boromir je najpre podlegao mračnoj moći Prstena a zatim poginuo u napadu Orka, dok su Pipin i Veseli oteti. Frodo, nakon što se uverio koliko mračna moć Prstena utiče na svakoga ko dođe u dodir s njim, odlučuje da put u Mordor nastavi sâm. Ipak, verni Sem ga ne napušta.\r\n\r\nDok putuju ka Planini Usuda, teret koji Frodo nosi sve je teži... U stopu ih prati Golum - upropašćeni stvor ide za Prekrasnim, koji je nekad posedovao, a koji mu je Bilbo Bagins odneo. Ako misle da nađu put do Mordora, Frodo i Sem moraju da prihvate Golumovo nepouzdano savezništvo.', 1),
(19, 'Povratak kralja', 4, 'Iako poražene u prvoj velikoj bici Rata za Prsten, armije Mračnog Gospodara sve su moćnije i spremaju se na pohod na Minas Tirit, prestonicu Gondora, najmoćnijeg kraljevstva Ljudi. Pad Gondora značio bi i trijumf Zla i kraj Srednjeg sveta. Dok Ljudi, Patuljci i Vilovnjaci ujedinjuju snage u odbrani „belog grada” Minis Tirita, Frodo i Sem nastavljaju svoj tegoban put u Mordor.\r\n\r\nRat se rasplamsava, ali njegov konačni ishod odlučiće nemogući poduhvat dva mala Hobita da unište Jedinstveni Prsten tamo gde ga je Mračni Gospodar i napravio: u vatrenoj utrobi Planine Usuda.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

DROP TABLE IF EXISTS `chats`;
CREATE TABLE IF NOT EXISTS `chats` (
  `chatID` int NOT NULL AUTO_INCREMENT,
  `senderID` int NOT NULL,
  `receiverID` int NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`chatID`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
CREATE TABLE IF NOT EXISTS `image` (
  `bookID` int NOT NULL,
  `name` varchar(255) COLLATE utf32_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`bookID`, `name`) VALUES
(1, 'zelena_milja.jpg'),
(2, 'kudzo.jpg'),
(3, 'zmajeve_oci.jpg'),
(4, 'groblje_kucnih_ljubimaca.webp'),
(5, 'to.jpg'),
(6, 'saptac.jpg'),
(7, 'kuca_svetlosti.jpg'),
(8, 'kuca_glasova.jpg'),
(9, 'kuca_bez_secanja.jpg'),
(10, 'decak_od_stakla.jpg'),
(11, 'deca_zla.jpg'),
(12, 'ostrvo_pelikana.jpg'),
(13, 'u_ime_naroda.jpg'),
(14, 'rudnik.jpg'),
(15, 'hobit.png'),
(16, 'silmalirion.jpg'),
(17, 'druzina_prstena.jpg'),
(18, 'dve_kule.jpg'),
(19, 'povratak_kralja.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

DROP TABLE IF EXISTS `loans`;
CREATE TABLE IF NOT EXISTS `loans` (
  `loanID` int NOT NULL AUTO_INCREMENT,
  `bookID` int NOT NULL,
  `userID` int NOT NULL,
  `loanDate` date NOT NULL,
  `returnDate` date NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT 'Its 0 when the book is loaned, and when the loan is over, it changes to 1',
  PRIMARY KEY (`loanID`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
  `messageID` int NOT NULL AUTO_INCREMENT,
  `senderID` int NOT NULL,
  `receiverID` int NOT NULL,
  `messageBody` longtext COLLATE utf32_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`messageID`)
) ENGINE=MyISAM AUTO_INCREMENT=188 DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `userID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) COLLATE utf32_unicode_ci NOT NULL,
  `lastName` varchar(255) COLLATE utf32_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf32_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf32_unicode_ci NOT NULL,
  `userTypeID` int NOT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userID`, `firstName`, `lastName`, `email`, `password`, `userTypeID`) VALUES
(4, 'admin', 'admin', 'admin@gmail.com', 'admin', 1),
(3, 'Ime 3', 'Prezime 3', 'korisnik3@gmail.com', 'korisnik3', 2),
(2, 'Ime 2', 'Prezime 2', 'korisnik2@gmail.com', 'korisnik2', 2),
(1, 'Ime 1', 'Prezime 1', 'korisnik1@gmail.com', 'korisnik1', 2);

-- --------------------------------------------------------

--
-- Table structure for table `usertype`
--

DROP TABLE IF EXISTS `usertype`;
CREATE TABLE IF NOT EXISTS `usertype` (
  `typeID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf32_unicode_ci NOT NULL,
  PRIMARY KEY (`typeID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;

--
-- Dumping data for table `usertype`
--

INSERT INTO `usertype` (`typeID`, `name`) VALUES
(1, 'BIBLIOTEKAR'),
(2, 'CITALAC');

-- --------------------------------------------------------

--
-- Table structure for table `waitlist`
--

DROP TABLE IF EXISTS `waitlist`;
CREATE TABLE IF NOT EXISTS `waitlist` (
  `waitlistID` int NOT NULL AUTO_INCREMENT,
  `bookID` int NOT NULL,
  `userID` int NOT NULL,
  `position` int NOT NULL,
  PRIMARY KEY (`waitlistID`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
