<%@ page contentType="text/html; charset=UTF-8" %>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Biblioteka "Vuk Karadzic"</title>
  <link rel="apple-touch-icon" sizes="180x180" href="favicons/apple-touch-icon.png">
  <link rel="icon" type="image/png" sizes="32x32" href="favicons/favicon-32x32.png">
  <link rel="icon" type="image/png" sizes="16x16" href="favicons/favicon-16x16.png">
  <link rel="manifest" href="favicons/manifest.json">
  <link rel="mask-icon" href="favicons/safari-pinned-tab.svg" color="#5bbad5">
  <link rel="shortcut icon" href="favicons/favicon.ico">
  <meta name="msapplication-config" content="favicons/browserconfig.xml">
  <meta name="theme-color" content="#ffffff">
  <link href="css/bootstrap.min.css" rel="stylesheet">
  <link href="css/styles.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Lato:300,300i,400,400i,700,700i,900,900i" rel="stylesheet">
  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
</head>
<body>
<jsp:include page="pages/header.jsp"></jsp:include>
<jsp:include page="pages/help.jsp"></jsp:include>

<section id="banner">
  <div class="jumbotron">
    <div class="container">
      <div>
        <h6 id="banner-welcome">
          <span><i class="fa fa-angle-right gold"></i> Zakoračite u svet knjiga.</span><br>
          Dostupno preko 5000 naslova
        </h6>
      </div>
    </div>
  </div>
</section>
<span class="anchor" id="about"></span>
<section class="about">
  <div class="container padding-2x">
    <div class="row">
      <div class="col-sm-12">
        <h6 class="text-center">O nama</h6>
        <h3 class="text-center">Istorijat</h3>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-12">
        <p>
          Prestoni Kragujevac iznedrio je sredinom XIX veka, i to u kratkom periodu: prvu galeriju slika, apoteku, vojni orkestar, gimnaziju, štampariju u kojoj je
          štampan prvi broj Novina Srbskih, pozorište i čitalište. Čitališta su uglavnom nicala kao rezultat privatne inicijative, bila su mesto okupljanja pojedinaca
          koji su pokazali naklonost prema knjizi i pisanoj reči i zbog načina i organizacije rada smatramo ih začetnicima bibliotekarstva u Srbiji. Kragujevačko čitalište
          osnovano je 1846, odmah posle Beogradskog.
        </p>
      </div>
    </div>
  </div>
</section>
<span class="anchor" id="cat"></span>
<section class="cat">
  <div class="container-fluid padding-lg">
    <div class="row">
      <div class="col-xs-12">
        <div class="container">
          <div class="row">
            <div class="col-xs-12">
              <h3>Pronađite željeni naslov</h3>
              <a href="pages/models.jsp">Pogledajte sve knjige  <i class="fa fa-angle-right"></i></a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<span class="anchor" id="services"></span>
<section class="services">
  <div class="container-fluid padding-lg">
    <div class="row">
      <div class="col-xs-12">
        <h6 class="text-center">Usluge</h6>
        <h3 class="text-center">Naše mušterije su na prvom mestu</h3>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-12">
        <div class="container">
          <div class="row">
            <div class="col-xs-12 col-md-4">
              <ul>
                <li><i class="fa fa-address-card"></i>Članarina</li>
                <li><i class="fa fa-address-card"></i>Članarina za učenike, studente, penzionere i nezaposlene</li>
                <li><i class="fa fa-address-card"></i>Kolektivna članarina</li>
                <li><i class="fa fa-address-card"></i>Porodična članarina</li>
                <li><i class="fa fa-address-card"></i>Polugodišnja članarina</li>
                <li><i class="fa fa-folder-open"></i>Korišćenje neknjižne građe</li>
              </ul>
            </div>
            <div class="col-xs-12 col-md-4">
              <ul>
                <li><i class="fa fa-list"></i>Rezervacija knjige - po naslovu</li>
                <li><i class="fa fa-id-card"></i>Izdavanje duplikata članske karte</li>
                <li><i class="fa fa-handshake-o"></i>Izdavanje prostora</li>
                <li><i class="fa fa-sticky-note"></i>Skeniranje po stranici</li>
                <li><i class="fa fa-sticky-note"></i>Fotokopiranje</li>
                <li>I JOŠ MNOGO TOGA!</li>
              </ul>
            </div>
            <div class="col-xs-12 col-md-4">
              <h6>Narodna biblioteka Kragujevac</h6>
              <p>U skladu sa Odlukom o cenama usluga korišćenja bibliotečko-informacione građe, kao i odlukom o cenama usluga izdavanja prostora
              skeniranja i fotokopiranja u Narodnoj biblioteci "Vuk Karadžić" u Kragujevcu, formirane su cene za navedene usluge.</p>
              <a class="btn" href="https://www.nbkg.rs/services.html">Pogledaj cene</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<span class="anchor" id="reviews"></span>
<section class="reviews">
  <div id="carousel-reviews" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <li data-target="#carousel-reviews" data-slide-to="0" class="active"></li>
      <li data-target="#carousel-reviews" data-slide-to="1"></li>
    </ol>
    <div class="container padding-lg">
      <!-- Wrapper for slides -->
      <div class="row">
        <div class="col-xs-12">
          <h6 class="text-center">Utisci korisnika</h6>
          <h3 class="text-center">Šta kažu naši korisnici</h3>
        </div>
      </div>
      <div class="row">
        <div class="col-xs-12">
          <div class="carousel-inner">
            <div class="item active">
              <div class="carousel-content">
                <div class="col-sm-6">
                  <div class="box">
                    <img src="images/Review1.png" />
                    <h6>Ivana Banović</h6>
                    <h6>Kraljevo, Srbija</h6>
                    <p>Administracija je odlična, veoma brzo odgovaraju na poruke. Sve preporuke!</p>
                  </div>
                </div>
                <div class="col-sm-6">
                  <div class="box">
                    <img src="images/Review2.png" />
                    <h6>Milica Samardžić</h6>
                    <h6>Vojvodina, Srbija</h6>
                    <p>Dobar izbor knjiga. Uz red čekanja lako dobijete informaciju kada je dostupna knjiga koju želite.</p>
                  </div>
                </div>
              </div>
            </div>
            <div class="item">
              <div class="carousel-content">
                <div class="col-sm-6">
                  <div class="box">
                    <img src="images/review3.png" />
                    <h6>Marina Janjić</h6>
                    <h6>Kraljevo, Srbija</h6>
                    <p>Sve je prosto i jednostavno, u par klikova do željene knjige!</p>
                  </div>
                </div>
                <div class="col-sm-6">
                  <div class="box">
                    <img src="images/review4.png" />
                    <h6>Ivan Marković</h6>
                    <h6>Kragujevac, Srbija</h6>
                    <p>Veoma jednostavan način da pronađete građu!</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<span class="anchor" id="contact"></span>
<section class="contact">
  <div class="container-fluid padding-lg">
    <div class="row">
      <div class="col-sm-12">
        <div class="container">
          <div class="row">
            <div class="col-xs-12">
              <h6 class="text-center">Kontaktirajte nas</h6>
              <h3 class="text-center"><span>Imate pitanje?</span> Rado ćemo Vam pomoći</h3>
            </div>
          </div>
          <div class="row">
            <div class="col-xs-12 col-md-12">
              <div class="box">
                <h6><span class="gold">NBKG</span> Vuk Karadžić</h6>
                <p>Vaša direktna veza sa nama.</p>
                <ul style="padding-left:0;">
                  <li><i class="fa fa-home"></i>Milovana Glišića, 44</li>
                  <li><a href="tel:1-999-999-9999"><i class="fa fa-phone"></i>Phone: (+381) 333 - 5555</a></li>
                  <li><a href="#"><i class="fa fa-envelope"></i>Email: nbkg@gmail.com</a></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<jsp:include page="pages/footer.jsp"></jsp:include>

<%--TODO add different views for users which are librarians --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/functions.js"></script>
<script src="js/custom.js"></script>
</body>
</html>