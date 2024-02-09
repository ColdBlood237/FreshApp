<%@page import="com.fresh.FreshApp.utils.Constants" %> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<!DOCTYPE html>
<html data-theme="night" lang="it">

  <head>
    <meta charset="ISO-8859-1" />
    <title>Log In</title>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.6.0/dist/full.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() + "/resources/logo2.png" %>">
  </head>

  <body class="min-h-screen flex flex-col items-center justify-center">

     <% if((String) request.getAttribute(Constants.USER_NON_EXISTANT_KEY) != null) { %> 
      <div role="alert" class="alert alert-error w-11/12 md:max-w-screen-sm">
        <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
        <span><%= request.getAttribute(Constants.USER_NON_EXISTANT_KEY)%></span>
      </div> 
    <% } %> 
    <% if((String) request.getAttribute(Constants.INCORRECT_PWD_KEY) != null) { %> 
      <div role="alert" class="alert alert-error w-11/12 md:max-w-screen-sm ">
        <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
        <span><%= request.getAttribute(Constants.INCORRECT_PWD_KEY) %></span>
      </div>
    <% } %> 

    <div class="card w-96 glass mt-3">

      <img src="<%= request.getContextPath() + "/resources/logo2.png" %>" class="w-auto h-auto max-h-32 max-w-32 mx-auto mt-8" />
      <div class="card-body">
        <h2 class="card-title">Log In</h2>
        <form class="w-96" action="<%= request.getContextPath() %>/login" method="post">

          <label class="form-control w-full max-w-xs">
            <div class="label">
              <span class="label-text">Email:</span>
            </div>
            <input type="email" name="<%=Constants.MAIL_KEY%>" placeholder="email"
              class="input input-bordered w-full max-w-xs" required/>
          </label>

          <label class="form-control w-full max-w-xs">
            <div class="label">
              <span class="label-text">Password:</span>
            </div>
            <input type="password" name="<%=Constants.PSW_KEY%>" placeholder="password"
              class="input input-bordered w-full max-w-xs" required/>
          </label>

          <button class="btn btn-primary my-2">Log In</button>

        </form>
        <div class="card-actions justify-end">
          <p>Non sei registrato ? <a class="underline"
              href="<%= request.getContextPath() %>/jsp/public/signup.jsp">Registrati qui</a></p>
        </div>
      </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/theme-change@2.0.2/index.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
      integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="script.js"></script>
  </body>

</html>

