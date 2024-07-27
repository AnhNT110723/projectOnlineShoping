<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Profile</title>
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
        <style>
            body {
                margin-top: 20px;
                background: #f5f5f5;
                font-family: Arial, sans-serif;
            }

            .container {
                max-width: 600px;
                margin: 0 auto;
                background: #fff;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }

            .panel-body {
                padding: 20px 0;
            }

            .profile-avatar {
                width: 150px;
                height: 150px;
                margin: 0 auto;
                border: 4px solid #f3f3f3;
                border-radius: 50%;
                display: block;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                font-weight: bold;
            }

            input[type="text"],
            input[type="password"],
            input[type="email"],
            input[type="tel"],
            textarea,
            select {
                width: calc(100% - 20px); /* ?? r?ng c?a input b?ng ?? r?ng c?a kh?i div tr? ?i l? trái và l? ph?i c?a input */
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                margin-left: 00px; /* Thêm l? trái 10px ?? t?o kho?ng cách v?i vi?n c?a kh?i div */
            }

            button[type="submit"],
            button[type="reset"] {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn-primary {
                background-color: #007bff;
                color: #fff;
            }

            .btn-default {
                background-color: #ccc;
                color: #fff;
            }

            /* Custom styles for user information panel */
            .user-info-panel {
                background-color: #F5F5F5; /* Màu xanh nh?t */
                border-radius: 5px;
                padding: 15px;
                margin-bottom: 20px;
            }

            /* Custom styles for security panel */
            .security-panel {
                background-color: #F5F5F5; /* Màu h?ng nh?t */
                border-radius: 5px;
                padding: 15px;
                margin-bottom: 20px;
            }
            .btn btn-primary{
                background-color: red;
            }
            .menuu:hover {
                color: red;
            }
        </style>
    </head>
    <body>
        <div class="container"> 
            <form class="form-horizontal"  action="editProfile" method="post">
            <div class="row">
                <div class="col-xs-12 col-sm-9">
                   
                        <div style="display: flex; align-items: center;justify-content: inherit; background-color: #1E1F29">
                            <a href="home" style="font-size: 25px; color: #fff; margin-right: 2px"><span class="menuu"><--Home</span></a>
                            <h1 class="panel-title" style="color: #fff; opacity: 0.8">/Edit Profile</h1>
                        </div>

                        <div class="panel panel-default user-info-panel">
                            <div class="panel-heading">
                                <h4 class="panel-title">User information</h4>
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label">User name</label>
                                    <div class="col-sm-8">
                                        <input type="text" name="user" class="form-control" value="${user}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label">Email</label>
                                    <div class="col-sm-8">
                                        <input type="email" name="email" class="form-control" value="${email}">
                                    </div>
                                </div>
                            </div>
                        </div>
                  
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-9">
                   
                        <div class="panel panel-default security-panel">
                            <div class="panel-heading">
                                <h4 class="panel-title">Security</h4>
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label">Current password</label>
                                    <div class="col-sm-8">
                                        <input type="password" name="pass" class="form-control" value="${pass}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label">New password</label>
                                    <div class="col-sm-8">
                                        <input type="password" name="newpass" class="form-control" value="${newpass}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-8 col-sm-offset-4">
                                        <span colspan="2" style="color: red">${msg}</span>
                                        <button type="submit" class="btn btn-primary" style="background-color: red;">Submit</button>
                                        <button type="reset" class="btn btn-default">Cancel</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                  
                </div>
            </div> 
            </form>
        </div> 
                                      
    </body>
</html>
