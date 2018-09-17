<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <title>getIP Server</title>
</head>
<body>
    <div class="jumbotron">
        <h1 class="display-4"><label for="">@IP SERVER!</label></h1>
        <p class="lead"><label for="">Here is the @IP of this Server !</label></p>
        <hr class="my-4">
    </div>
    <div class="container">
        <div class="row">
            <div class="col"></div>
            <div class="col-6">
                <div class="alert alert-primary" role="alert" style="text-align:center">
                    <label for="">@IP SERVER</label> : <a href="javascript:void(0)" class="alert-link"><?php echo $_SERVER["SERVER_ADDR"] ?></a>
                </div>
            </div>
            <div class="col"></div>
        </div>
    </div>
</body>
</html>