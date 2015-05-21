<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="ExampleOUT"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <!-- Optional theme -->
    <!--link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css"-->

    <link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/themes/smoothness/jquery-ui.css" />

    <!-- Custom Fonts -->
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="//fonts.googleapis.com/css?family=Righteous:400,700" rel="stylesheet" type="text/css">

    <link href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/css/bootstrapvalidator.min.css" rel="stylesheet" type="text/css">

  <asset:stylesheet src="devoops.css"/>
  <asset:stylesheet src="dashboard_styles.css"/>
  <style type='text/css' media='screen'>

  </style>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="//oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="//oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
  <g:javascript>
    window.appContext = '${request.contextPath}';
    window.text_privacy_org_none = '<g:message code="dashboard.folder.privacy.org.none" />';
    window.text_privacy_org_new  = '<g:message code="dashboard.folder.privacy.org" args="['neworg-name']" />';
    window.text_privacy_org_edit = '<g:message code="dashboard.folder.privacy.org" args="['editorg-name']" />';
  </g:javascript>
  <asset:javascript src="random_image.js"/>

  <g:layoutHead/>
</head>
<body>
  <!--Start Header-->
  <g:render template="/layouts/dashboard_header" model="['org': org, 'folder': folder, 'org_path': org_path, 'folder_path': folder_path]" />
  <!--End Header-->
  <!--Start Container-->
  <g:layoutBody/>
  <!--End Container-->
  <g:render template="/layouts/modal_add_orgfolder" model="[]" />

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
  <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
  <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js"></script>

  <!-- Latest compiled and minified JavaScript -->
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/js/bootstrapvalidator.min.js"></script>

  <!-- Plugin JavaScript -->
  <script src="//cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>

<asset:javascript src="dashboard.js"/>
<asset:javascript src="form_validator.js"/>
<asset:javascript src="modal_add_folder.js"/>
<!--script type="text/javascript" charset="utf-8"></script-->
<g:pageProperty name="page.javascript"/>
</body>
</html>
