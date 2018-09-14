<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name="google-signin-client_id" content="384821628687-ve9h2s78rhd6708v353g6birprtkcgbb.apps.googleusercontent.com">

<form:form method="POST" modelAttribute="loginForm" class="form-signin" action="${contextPath}/registration?${_csrf.parameterName}=${_csrf.token}">
    <h2 class="form-signin-heading">Create your account</h2>
    <spring:bind path="username">
        <div class="form-group ${status.error ? 'has-error' : ''}">
            <form:input type="text" path="username" class="form-control" placeholder="Username"
                        autofocus="true"></form:input>
            <form:errors path="username"></form:errors>
        </div>
    </spring:bind>

    <spring:bind path="password">
        <div class="form-group ${status.error ? 'has-error' : ''}">
            <form:input type="password" path="password" class="form-control" placeholder="Password"></form:input>
            <form:errors path="password"></form:errors>
        </div>
    </spring:bind>

    <spring:bind path="passwordConfirm">
        <div class="form-group ${status.error ? 'has-error' : ''}">
            <form:input type="password" path="passwordConfirm" class="form-control"
                        placeholder="Confirm your password"></form:input>
            <form:errors path="passwordConfirm"></form:errors>
        </div>
    </spring:bind>
    <div class="form-group">
        <div class="col-sm-offset-3 col-sm-6">
            <div class="g-recaptcha" data-sitekey="<spring:eval expression="@propertyConfigurer.getProperty('recaptcha.validation.siteKey')" />"></div>
        </div>
    </div>

    <button class="btn btn-lg btn-primary btn-block" type="submit">Submit</button>
</form:form>

<div class="row">
    <div class="col-sm-6">
        <a class="btn btn-primary" role="button" href="${contextPath}/login">Back to Login</a>
    </div>
    <div class="col-sm-6">
        <a class="btn btn-danger" role="button" href="${contextPath}/forgot">Forgot Password?</a>
    </div>
</div>
<div class="row">
    <fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
    </fb:login-button>
    <div id="statusFB">
    </div>



    <div class="row">
        <div class="g-signin2" data-onsuccess="onSignIn" id="myP"></div>

        <img id="myImg"><br>
        <p id="name"></p>
        <div id="status">
        </div>
    </div>

</div>



<script type="text/javascript">
    function onSignIn(googleUser) {
        // window.location.href='success.jsp';



        var profile = googleUser.getBasicProfile();
        var imagurl=profile.getImageUrl();
        var name=profile.getName();
        var email=profile.getEmail();
        document.getElementById("myImg").src = imagurl;
        document.getElementById("name").innerHTML = name;

        document.getElementById("myP").style.visibility = "hidden";


        document.getElementById("status").innerHTML = 'Welcome '+name+'!<a href=fblogin.html?user_name='+ name.replace(" ", "_") +'&user_email='+email +'>Continue with facebook login</a>Continue with Google login</a></p>'



    }
</script>


<script>

    // This is called with the results from from FB.getLoginStatus().
    function statusChangeCallback(response) {
        console.log('statusChangeCallback');
        console.log(response);
        // The response object is returned with a status field that lets the
        // app know the current login status of the person.
        // Full docs on the response object can be found in the documentation
        // for FB.getLoginStatus().
        if (response.status === 'connected') {
            // Logged into your app and Facebook.
            testAPI();
        } else if (response.status === 'not_authorized') {
            // The person is logged into Facebook, but not your app.
            document.getElementById('status').innerHTML = 'Login with Facebook ';
        } else {
            // The person is not logged into Facebook, so we're not sure if
            // they are logged into this app or not.
            document.getElementById('status').innerHTML = 'Login with Facebook ';
        }
    }
    // This function is called when someone finishes with the Login
    // Button. See the onlogin handler attached to it in the sample
    // code below.
    function checkLoginState() {
        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });
    }
    window.fbAsyncInit = function() {
        FB.init({
            appId : '245358469484733',
            cookie : true, // enable cookies to allow the server to access
            // the session
            xfbml : true, // parse social plugins on this page
            version : 'v2.2' // use version 2.2
        });
        // Now that we've initialized the JavaScript SDK, we call
        // FB.getLoginStatus(). This function gets the state of the
        // person visiting this page and can return one of three states to
        // the callback you provide. They can be:
        //
        // 1. Logged into your app ('connected')
        // 2. Logged into Facebook, but not your app ('not_authorized')
        // 3. Not logged into Facebook and can't tell if they are logged into
        // your app or not.
        //
        // These three cases are handled in the callback function.

        FB.getLoginStatus(function(response) {
            statusChangeCallback(response);
        });
    };
    // Load the SDK asynchronously
    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

    // Here we run a very simple test of the Graph API after login is
    // successful. See statusChangeCallback() for when this call is made.
    function testAPI() {
        console.log('Welcome! Fetching your information.... ');
        FB.api('/me?fields=name,email', function(response) {
            console.log('Successful login for: ' + response.name);

            document.getElementById("statusFB").innerHTML = '<p>Welcome '+response.name+'! <a href=fblogin.html?user_name='+ response.name.replace(" ", "_") +'&user_email='+ response.email +'>Continue with facebook login</a></p>'
        });
    }
</script>
