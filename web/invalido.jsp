<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="login.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="js/materialize.min.js"></script>
        <script>
            Materialize.toast('Falha no login!', 5000);
        </script>
    </body>
</html>