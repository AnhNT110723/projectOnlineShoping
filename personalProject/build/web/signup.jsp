<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Register Form</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" rel="stylesheet">
        <style>
            /* sign in FORM */
            #logreg-forms{
                width: 412px;
                margin: 10vh auto;
                background-color: #f3f3f3;
                box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
                transition: all 0.3s cubic-bezier(.25,.8,.25,1);
                padding: 20px;
                border-radius: 10px;
            }
            #logreg-forms .social-login{
                margin: 20px 0;
                display: flex; /* Sử dụng flexbox */
                justify-content: center; /* Căn giữa các phần tử con */
            }
            #logreg-forms .social-btn{
                font-weight: 100;
                width: 190px;
                font-size: 0.9rem;
            }
            #logreg-forms .facebook-btn span {
                color: white; /* Màu chữ trắng */
            }

            #logreg-forms .google-btn span {
                color: white; /* Màu chữ trắng */
            }
            #logreg-forms .facebook-btn {
                background-color: #3b5998; /* Màu của Facebook */
            }

            #logreg-forms .google-btn {
                background-color: #dd4b39; /* Màu của Google+ */
            }

            #logreg-forms a{
                color: lightseagreen;
            }
            #logreg-forms button[type="submit"] {
                margin-top: 14px;
                margin-left: 5px;
                margin-bottom: 16px;
            }
            .form-control {
                margin: 5px;
            }

            @media screen and (max-width:500px){
                #logreg-forms{
                    width:300px;
                }

                #logreg-forms  .social-login{
                    width:200px;
                    margin:0 auto;
                    margin-bottom: 10px;
                }
                #logreg-forms  .social-btn{
                    font-size: 1.3rem;
                    font-weight: 100;
                    color:white;
                    width:200px;
                    height: 56px;

                }
                #logreg-forms .social-btn:nth-child(1){
                    margin-bottom: 5px;
                }
                #logreg-forms .social-btn span{
                    display: none;
                }
                #logreg-forms  .facebook-btn:after{
                    content:'Facebook';
                }

                #logreg-forms  .google-btn:after{
                    content:'Google+';
                }

            }
        </style>
    </head>
    <body>
        <div id="logreg-forms">
            <form action="signup" method="post" class="form-signup">
                <div class="social-login">
                    <button class="btn facebook-btn social-btn" type="button"><span><i class="fab fa-facebook-f"></i> Sign up with Facebook</span> </button>
                </div>
                <div class="social-login">
                    <button class="btn google-btn social-btn" type="button"><span><i class="fab fa-google-plus-g"></i> Sign up with Google+</span> </button>
                </div>

                <p style="text-align:center">OR</p>

                <input name="name" value="${name}" type="text" id="user-name" class="form-control" placeholder="User name" required="" autofocus="">
                <input name="email" value="${email}" type="email" id="user-email" class="form-control" placeholder="Email address" required autofocus="">
                <input name="pass" value="${pass}" type="password" id="user-pass" class="form-control" placeholder="Password" required autofocus="">
                <input name="repass" value="${repass}" type="password" id="user-repeatpass" class="form-control" placeholder="Repeat Password" required autofocus="">

                <button class="btn btn-primary btn-block" type="submit"><i class="fas fa-user-plus"></i> Sign Up</button>

                <div id="error-messages" class="alert alert-danger" role="alert">
                    ${massages}
                </div>
                <div id="error-message" class="alert alert-danger" role="alert">
                    ${massage}
                </div>

                <a href="login" id="cancel_signup"><i class="fas fa-angle-left"></i> Back</a>
            </form>
        </div>
        <script>
            
            
            
            // Kiểm tra xem massage có tồn tại hay không
            var massage = "${massage}";
            if (!massage) {
                // Nếu không có massage, ẩn đi khối div
                document.getElementById("error-message").style.display = "none";
            }

            var massages = "${massages}";
            if (!massages) {
                // Nếu không có massage, ẩn đi khối div
                document.getElementById("error-messages").style.display = "none";
            }
        </script>
    </body>
</html>
