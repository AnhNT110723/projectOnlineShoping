<%-- 
    Document   : Login
    Created on : Feb 5, 2024, 2:15:27 PM
    Author     : Anh hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <link rel="stylesheet" href="/style.css">
        <title>Login/Register Form</title>
        <style>

            /* sign in FORM */
            #logreg-forms{
                width:412px;
                margin:10vh auto;
                background-color:#f3f3f3;
                box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
                transition: all 0.3s cubic-bezier(.25,.8,.25,1);
            }
            #logreg-forms form {
                width: 100%;
                max-width: 410px;
                padding: 15px;
                margin: auto;
            }
            #logreg-forms .form-control {
                position: relative;
                box-sizing: border-box;
                height: auto;
                padding: 10px;
                font-size: 16px;
            }
            #logreg-forms .form-control:focus {
                z-index: 2;
            }
            #logreg-forms .form-signin input[type="email"] {
                margin-bottom: -1px;
                border-bottom-right-radius: 0;
                border-bottom-left-radius: 0;
            }
            #logreg-forms .form-signin input[type="password"] {
                border-top-left-radius: 0;
                border-top-right-radius: 0;
            }

            #logreg-forms .social-login{
                width:390px;
                margin:0 auto;
                margin-bottom: 14px;
            }
            #logreg-forms .social-btn{
                font-weight: 100;
                color:white;
                width:190px;
                font-size: 0.9rem;
            }

            #logreg-forms a{
                display: block;
                padding-top:10px;
                color:lightseagreen;
            }

            #logreg-form .lines{
                width:200px;
                border:1px solid red;
            }


            #logreg-forms button[type="submit"]{
                margin-top:10px;
            }

            #logreg-forms .facebook-btn{
                background-color:#3C589C;
            }

            #logreg-forms .google-btn{
                background-color: #DF4B3B;
            }

            #logreg-forms .form-reset, #logreg-forms .form-signup{
                display: none;
            }

            #logreg-forms .form-signup .social-btn{
                width:210px;
            }

            #logreg-forms .form-signup input {
                margin-bottom: 2px;
            }

            .form-signup .social-login{
                width:210px !important;
                margin: 0 auto;
            }

            /* Mobile */

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
            <form class="form-signin" action="login" method="post" >
                <h1 class="h3 mb-3 font-weight-normal" style="text-align: center"> Login</h1>
                <div class="social-login">
                    <button class="btn facebook-btn social-btn" type="button"><span><i class="fab fa-facebook-f"></i> Sign in with Facebook</span>
                        
                        <a href="https://www.facebook.com/v20.0/dialog/oauth?fields=id,name,email&client_id=1015118540182274&redirect_uri=http://localhost:9999/personalProject/LoginFaceBookServlet&scope=email,public_profile"></a>
                    </button>
                    <button class="btn google-btn social-btn" type="button">
                        <span><i class="fab fa-google-plus-g"></i> Sign in with Google+</span>
                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile&redirect_uri=http://localhost:9999/personalProject/LoginGoogleServlet&response_type=code&client_id=604117726399-9631r3nt2io8n50qb5140gub08mhfaor.apps.googleusercontent.com&approval_prompt=force"></a>
                    </button>

                </div>
                <p style="text-align:center"> OR  </p>
                <input name="email" value="${emailInput}" type="email" id="inputEmail" class="form-control" placeholder="Email address" required="" autofocus="">
                <input name="pass" value="${passInput}" type="password" id="inputPassword" class="form-control" placeholder="Password" required="">
                <div id="error-message" class="alert alert-danger" role="alert">
                    ${massage}
                </div>
                <div style="display: flex; align-items: center;padding: 5px;">
                    <input type="checkbox" name="rem" value="1" style="margin-right: 5px;">
                    <label style="margin: 0;">Remember me</label>
                </div>


                <button class="btn btn-success btn-block" type="submit"><i class="fas fa-sign-in-alt"></i> Sign in</button>
                <a href="forgotpassword" id="forgot_pswd">Forgot password?</a>
                <hr>
                <!-- <p>Don't have an account!</p>  -->
                <a href="signup" class="btn btn-primary btn-block text-white" id="btn-signup"><i class="fas fa-user-plus"></i> Sign up New Account</a>


            </form>

            <script>
                // Kiểm tra xem massage có tồn tại hay không
                var massage = "${massage}";
                if (!massage) {
                    // Nếu không có massage, ẩn đi khối div
                    document.getElementById("error-message").style.display = "none";
                }
            </script>
    </body>
</html>