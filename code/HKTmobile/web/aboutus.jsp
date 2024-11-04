<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>HKT Mobile - About Us</title>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

    <!-- Bootstrap -->
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>

    <!-- Slick -->
    <link type="text/css" rel="stylesheet" href="css/slick.css"/>
    <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>

    <!-- nouislider -->
    <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>

    <!-- Font Awesome Icon -->
    <link rel="stylesheet" href="css/font-awesome.min.css">

    <!-- Custom stlylesheet -->
    <link type="text/css" rel="stylesheet" href="css/style.css"/>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
        <style>
        .about-content {
            background: #f9f9f9;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            font-family: 'Montserrat', sans-serif;
        }

        .about-content h2.title {
            text-align: center;
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
        }

        .about-content h3 {
            font-size: 24px;
            font-weight: 500;
            margin-top: 20px;
            color: #333;
        }

        .about-content p {
            font-size: 16px;
            line-height: 1.6;
            color: #666;
            margin-bottom: 15px;
        }

        .about-content ul {
            list-style: disc inside;
            margin-left: 20px;
        }

        .about-content ul li {
            font-size: 16px;
            line-height: 1.6;
            color: #666;
            margin-bottom: 10px;
        }

        .about-content strong {
            color: #333;
        }

        .about-content a {
            color: #3498db;
            text-decoration: none;
        }

        .about-content a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- HEADER -->
    <jsp:include page="header.jsp"/>
    <jsp:include page="navigation.jsp"/>

<!-- SECTION -->
    <div class="section">
        <!-- container -->
        <div class="container">
            <!-- row -->
            <div class="row">
                <div class="col-md-12">
                    <div class="section-title">
                        <h2 class="title">About Us</h2>
                    </div>
                    <div class="about-content">
                        <p>Welcome to <strong>HKT Mobile</strong>!</p>

                        <p>At HKT Mobile, we are dedicated to bringing you the latest and greatest in mobile technology. Established with a vision to provide top-quality smartphones and accessories at competitive prices, we have quickly become a trusted name in the mobile retail industry.</p>

                        <h3>Our Mission</h3>
                        <p>Our mission is to offer a diverse selection of mobile devices that cater to all your needs. Whether you are a tech enthusiast looking for the newest flagship model or a casual user seeking a reliable and affordable phone, we have something for everyone.</p>

                        <h3>Why Choose Us?</h3>
                        <ul>
                            <li><strong>Wide Selection:</strong> We offer a vast array of smartphones from leading brands such as Apple, Samsung, Xiaomi, and more.</li>
                            <li><strong>Competitive Prices:</strong> We strive to provide the best prices on the market, ensuring you get the most value for your money.</li>
                            <li><strong>Quality Assurance:</strong> Each product undergoes rigorous quality checks to guarantee you receive a device that meets your expectations.</li>
                            <li><strong>Exceptional Customer Service:</strong> Our dedicated customer support team is here to assist you with any queries or concerns you may have.</li>
                            <li><strong>Secure Shopping:</strong> Your privacy and security are our top priorities. Shop with confidence knowing your information is safe with us.</li>
                        </ul>

                        <h3>Our Values</h3>
                        <ul>
                            <li><strong>Innovation:</strong> We are committed to staying ahead of the curve by offering the latest advancements in mobile technology.</li>
                            <li><strong>Integrity:</strong> We believe in transparency and honesty in all our dealings, ensuring a trustworthy shopping experience.</li>
                            <li><strong>Customer Satisfaction:</strong> Your satisfaction is our success. We go above and beyond to meet and exceed your expectations.</li>
                        </ul>

                        <h3>Contact Us</h3>
                        <p>Have any questions or need assistance? Feel free to reach out to us:</p>
                        <p>
                            <strong>Email:</strong> email@email.com<br>
                            <strong>Phone:</strong>  +012-34-56-78<br>
                            <strong>Address:</strong> FPT University
                        </p>
                        <p>Thank you for choosing HKT Mobile. We look forward to serving you!</p>
                    </div>
                </div>
            </div>
            <!-- /row -->
        </div>
        <!-- /container -->
    </div>
    <!-- /SECTION -->

    <jsp:include page="footer.jsp"/>

    <!-- jQuery Plugins -->
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/slick.min.js"></script>
    <script src="js/nouislider.min.js"></script>
    <script src="js/jquery.zoom.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>