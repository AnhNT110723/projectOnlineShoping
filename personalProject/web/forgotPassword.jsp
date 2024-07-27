<%-- 
    Document   : forgotPassword
    Created on : Feb 13, 2024, 4:21:05 PM
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
        <title>Bootstrap 4 Login/Register Form</title>
        <style>
            /* CSS for reset password form */
            #logreg-forms {
                width: 500px;
                margin: 10vh auto;
                background-color: #f3f3f3;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12), 0 1px 2px rgba(0, 0, 0, 0.24);
                transition: all 0.3s cubic-bezier(.25, .8, .25, 1);
                padding: 20px;
                border-radius: 10px;
            }

            #logreg-forms .form-reset {
                width: 100%;
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

            #logreg-forms button[type="submit"] {
                margin-top: 10px;
                margin-bottom: 16px;
            }

            #cancel_reset {

                color: lightseagreen; /* Màu chữ */

            }

            /*            #cancel_reset:hover {
                            color: #17a2b8;  Màu chữ khi hover 
                        }*/

            @media screen and (max-width: 500px) {
                #logreg-forms {
                    width: 300px;
                }
            }
        </style>
    </head>
    <body>
        <div id="logreg-forms">

            <form action="forgotpassword" method="post" class="form-reset">
                <input name="email" type="email"  class="form-control" placeholder="Email address" required="" autofocus="">
                <button class="btn btn-primary btn-block" type="submit">Reset Password</button>
                <a href="login" id="cancel_reset"><i class="fas fa-angle-left"></i> Back</a>
            </form>

        </div>


    </body>
</html>