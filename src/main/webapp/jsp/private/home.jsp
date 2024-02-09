<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.fresh.FreshApp.utils.Constants" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.fresh.FreshApp.model.Post" %>
<%@ page import="com.fresh.FreshApp.model.Commento" %>
<%@ page import="com.fresh.FreshApp.model.Utente" %>

<!DOCTYPE html>
<html data-theme="night" lang="it">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.6.0/dist/full.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://kit.fontawesome.com/7dff5f4879.js" crossorigin="anonymous"></script>
    <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() + "/resources/logo2.png" %>">
  </head>

  <body class="min-h-screen">

    <% 
      Utente userLogged = (Utente) request.getSession().getAttribute(Constants.USER_DATA_KEY);
      Boolean isOrderedByLikes = (Boolean) request.getAttribute(Constants.ORDER_BY_LIKES_KEY);
      Boolean isOrderedByComments = (Boolean) request.getAttribute(Constants.ORDER_BY_COMMENTS_KEY);
    %>

    <div class="drawer lg:drawer-open ">
      <input id="my-drawer" type="checkbox" class="drawer-toggle" />
      <div class="drawer-content">
        <!-- Page content here -->

        <div class="navbar bg-base-200 sticky top-0 z-10 border-b border-neutral">
          <div class="navbar-start">
            <label for="my-drawer" class="drawer-button lg:hidden">
              <div tabindex="0" class="avatar w-10 " role="button" class="btn btn-ghost">
                <div class="w-24 rounded-full">
                  <% if (userLogged.getImmagineProfilo() != null && !userLogged.getImmagineProfilo().trim().isEmpty()) { %>  
                    <img src="<%= "http://localhost:8080/" + "FreshAppImages/" + userLogged.getImmagineProfilo() %>" alt="<%= userLogged.getUsername() %>" />
                  <%  } else { %>
                    <img src="https://ui-avatars.com/api/?name=<%= userLogged.getUsername() %>" alt="<%= userLogged.getUsername() %>" />
                  <% } %>    
                </div>
              </div>
            </label>
          </div>
          <div class="navbar-center">
            <a class="btn btn-ghost text-xl"><img src="<%= request.getContextPath() + "/resources/logo2.png" %>" class="max-h-8" /> Fresh</a>
          </div>
          <div class="navbar-end">
          </div>
        </div>

        <div class="flex items-center justify-between p-2 mx-auto lg:justify-center lg:gap-8 border-b border-neutral">
          <p>ordina: </p>
          <% if (isOrderedByLikes) { %>
            <a href="<%= request.getContextPath() %>/readAllPosts">
              <button class="btn btn-sm"><i class="fa-solid fa-arrow-down-wide-short"></i> data</button>
            </a>
            <a href="<%= request.getContextPath() %>/readAllPosts?<%= Constants.ORDER_BY_LIKES_KEY %>=true">
              <button class="btn btn-sm btn-active"><i class="fa-solid fa-arrow-down-wide-short"></i> likes</button>
            </a>
            <a href="<%= request.getContextPath() %>/readAllPosts?<%= Constants.ORDER_BY_COMMENTS_KEY %>=true">
              <button class="btn btn-sm"><i class="fa-solid fa-arrow-down-wide-short"></i> commenti</button>
            </a>
          <% } else if (isOrderedByComments) { %>
            <a href="<%= request.getContextPath() %>/readAllPosts">
              <button class="btn btn-sm"><i class="fa-solid fa-arrow-down-wide-short"></i> data</button>
            </a>
            <a href="<%= request.getContextPath() %>/readAllPosts?<%= Constants.ORDER_BY_LIKES_KEY %>=true">
              <button class="btn btn-sm"><i class="fa-solid fa-arrow-down-wide-short"></i> likes</button>
            </a>
            <a href="<%= request.getContextPath() %>/readAllPosts?<%= Constants.ORDER_BY_COMMENTS_KEY %>=true">
              <button class="btn btn-sm btn-active"><i class="fa-solid fa-arrow-down-wide-short"></i> commenti</button>
            </a>
          <% } else { %>
            <a href="<%= request.getContextPath() %>/readAllPosts">
              <button class="btn btn-sm btn-active"><i class="fa-solid fa-arrow-down-wide-short"></i> data</button>
            </a>
            <a href="<%= request.getContextPath() %>/readAllPosts?<%= Constants.ORDER_BY_LIKES_KEY %>=true">
              <button class="btn btn-sm"><i class="fa-solid fa-arrow-down-wide-short"></i> likes</button>
            </a>
            <a href="<%= request.getContextPath() %>/readAllPosts?<%= Constants.ORDER_BY_COMMENTS_KEY %>=true">
              <button class="btn btn-sm"><i class="fa-solid fa-arrow-down-wide-short"></i> commenti</button>
            </a>
          <% } %>
        </div>

        <div class=" posts break-all min-h-screen">

        <% 
        List<Post> posts = (ArrayList<Post>) request.getAttribute(Constants.ALL_POSTS_KEY);  
        if (posts != null && posts.size() > 0) {
            for(Post post : posts) {
              Boolean isLiked = post.getLikes().contains(userLogged);
              Boolean isDisliked = post.getDislikes().contains(userLogged);       
        %>

        <%@include file="../components/post.jsp" %>
        
        <% 
            } 
        } 
        %>
          <p class="text-center my-2">Non c'e' nient'altro bro</p> 

        </div>



        <a href="<%= request.getContextPath() %>/jsp/private/postForm.jsp">
          <button class="btn btn-primary w-12 fixed bottom-20 right-8">
            <i class="fa-regular fa-snowflake text-2xl"></i>
          </button>
        </a>

        <footer class="footer flex justify-around p-4 bg-base-200 text-base-content sticky bottom-0">
          <a href="<%= request.getContextPath() %>/readAllPosts">
            <button>
              <svg class="inline-block w-6 h-6 stroke-current hover:stroke-primary" viewBox="0 0 20 20">
                <path
                  d="M18.121,9.88l-7.832-7.836c-0.155-0.158-0.428-0.155-0.584,0L1.842,9.913c-0.262,0.263-0.073,0.705,0.292,0.705h2.069v7.042c0,0.227,0.187,0.414,0.414,0.414h3.725c0.228,0,0.414-0.188,0.414-0.414v-3.313h2.483v3.313c0,0.227,0.187,0.414,0.413,0.414h3.726c0.229,0,0.414-0.188,0.414-0.414v-7.042h2.068h0.004C18.331,10.617,18.389,10.146,18.121,9.88 M14.963,17.245h-2.896v-3.313c0-0.229-0.186-0.415-0.414-0.415H8.342c-0.228,0-0.414,0.187-0.414,0.415v3.313H5.032v-6.628h9.931V17.245z M3.133,9.79l6.864-6.868l6.867,6.868H3.133z">
                </path>
              </svg>
            </button>
          </a>
          <a href="<%= request.getContextPath() + "/jsp/private/search.jsp" %>">
            <button>
              <svg class="inline-block w-6 h-6 stroke-current hover:stroke-primary" viewBox="0 0 20 20">
                <path
                  d="M18.125,15.804l-4.038-4.037c0.675-1.079,1.012-2.308,1.01-3.534C15.089,4.62,12.199,1.75,8.584,1.75C4.815,1.75,1.982,4.726,2,8.286c0.021,3.577,2.908,6.549,6.578,6.549c1.241,0,2.417-0.347,3.44-0.985l4.032,4.026c0.167,0.166,0.43,0.166,0.596,0l1.479-1.478C18.292,16.234,18.292,15.968,18.125,15.804 M8.578,13.99c-3.198,0-5.716-2.593-5.733-5.71c-0.017-3.084,2.438-5.686,5.74-5.686c3.197,0,5.625,2.493,5.64,5.624C14.242,11.548,11.621,13.99,8.578,13.99 M16.349,16.981l-3.637-3.635c0.131-0.11,0.721-0.695,0.876-0.884l3.642,3.639L16.349,16.981z">
                </path>
              </svg>
            </button>
          </a>
        </footer>


      </div>
      <div class="drawer-side md:z-20">
        <label for="my-drawer" aria-label="close sidebar" class="drawer-overlay"></label>
        <ul class="menu p-4 pt-24 md:pt-8 w-80 min-h-full bg-base-200 text-base-content border-r border-neutral">
          <!-- Sidebar content here -->
          <li>
            <a href="<%= request.getContextPath() + "/getUserProfile?" + Constants.MAIL_KEY + "=" + userLogged.getEmail() %>">
              <svg class="inline-block w-5 h-5 stroke-current" viewBox="0 0 20 20">
                <path
                  d="M12.075,10.812c1.358-0.853,2.242-2.507,2.242-4.037c0-2.181-1.795-4.618-4.198-4.618S5.921,4.594,5.921,6.775c0,1.53,0.884,3.185,2.242,4.037c-3.222,0.865-5.6,3.807-5.6,7.298c0,0.23,0.189,0.42,0.42,0.42h14.273c0.23,0,0.42-0.189,0.42-0.42C17.676,14.619,15.297,11.677,12.075,10.812 M6.761,6.775c0-2.162,1.773-3.778,3.358-3.778s3.359,1.616,3.359,3.778c0,2.162-1.774,3.778-3.359,3.778S6.761,8.937,6.761,6.775 M3.415,17.69c0.218-3.51,3.142-6.297,6.704-6.297c3.562,0,6.486,2.787,6.705,6.297H3.415z">
                </path>
              </svg>
              Profilo
            </a>
          </li>
          <li>
            <details class="dropdown">
              <summary>
                <svg class="inline-block w-5 h-5 stroke-current" viewBox="0 0 20 20">
                  <path
                    d="M17.498,11.697c-0.453-0.453-0.704-1.055-0.704-1.697c0-0.642,0.251-1.244,0.704-1.697c0.069-0.071,0.15-0.141,0.257-0.22c0.127-0.097,0.181-0.262,0.137-0.417c-0.164-0.558-0.388-1.093-0.662-1.597c-0.075-0.141-0.231-0.22-0.391-0.199c-0.13,0.02-0.238,0.027-0.336,0.027c-1.325,0-2.401-1.076-2.401-2.4c0-0.099,0.008-0.207,0.027-0.336c0.021-0.158-0.059-0.316-0.199-0.391c-0.503-0.274-1.039-0.498-1.597-0.662c-0.154-0.044-0.32,0.01-0.416,0.137c-0.079,0.106-0.148,0.188-0.22,0.257C11.244,2.956,10.643,3.207,10,3.207c-0.642,0-1.244-0.25-1.697-0.704c-0.071-0.069-0.141-0.15-0.22-0.257C7.987,2.119,7.821,2.065,7.667,2.109C7.109,2.275,6.571,2.497,6.07,2.771C5.929,2.846,5.85,3.004,5.871,3.162c0.02,0.129,0.027,0.237,0.027,0.336c0,1.325-1.076,2.4-2.401,2.4c-0.098,0-0.206-0.007-0.335-0.027C3.001,5.851,2.845,5.929,2.77,6.07C2.496,6.572,2.274,7.109,2.108,7.667c-0.044,0.154,0.01,0.32,0.137,0.417c0.106,0.079,0.187,0.148,0.256,0.22c0.938,0.936,0.938,2.458,0,3.394c-0.069,0.072-0.15,0.141-0.256,0.221c-0.127,0.096-0.181,0.262-0.137,0.416c0.166,0.557,0.388,1.096,0.662,1.596c0.075,0.143,0.231,0.221,0.392,0.199c0.129-0.02,0.237-0.027,0.335-0.027c1.325,0,2.401,1.076,2.401,2.402c0,0.098-0.007,0.205-0.027,0.334C5.85,16.996,5.929,17.154,6.07,17.23c0.501,0.273,1.04,0.496,1.597,0.66c0.154,0.047,0.32-0.008,0.417-0.137c0.079-0.105,0.148-0.186,0.22-0.256c0.454-0.453,1.055-0.703,1.697-0.703c0.643,0,1.244,0.25,1.697,0.703c0.071,0.07,0.141,0.15,0.22,0.256c0.073,0.098,0.188,0.152,0.307,0.152c0.036,0,0.073-0.004,0.109-0.016c0.558-0.164,1.096-0.387,1.597-0.66c0.141-0.076,0.22-0.234,0.199-0.393c-0.02-0.129-0.027-0.236-0.027-0.334c0-1.326,1.076-2.402,2.401-2.402c0.098,0,0.206,0.008,0.336,0.027c0.159,0.021,0.315-0.057,0.391-0.199c0.274-0.5,0.496-1.039,0.662-1.596c0.044-0.154-0.01-0.32-0.137-0.416C17.648,11.838,17.567,11.77,17.498,11.697 M16.671,13.334c-0.059-0.002-0.114-0.002-0.168-0.002c-1.749,0-3.173,1.422-3.173,3.172c0,0.053,0.002,0.109,0.004,0.166c-0.312,0.158-0.64,0.295-0.976,0.406c-0.039-0.045-0.077-0.086-0.115-0.123c-0.601-0.6-1.396-0.93-2.243-0.93s-1.643,0.33-2.243,0.93c-0.039,0.037-0.077,0.078-0.116,0.123c-0.336-0.111-0.664-0.248-0.976-0.406c0.002-0.057,0.004-0.113,0.004-0.166c0-1.75-1.423-3.172-3.172-3.172c-0.054,0-0.11,0-0.168,0.002c-0.158-0.312-0.293-0.639-0.405-0.975c0.044-0.039,0.085-0.078,0.124-0.115c1.236-1.236,1.236-3.25,0-4.486C3.009,7.719,2.969,7.68,2.924,7.642c0.112-0.336,0.247-0.664,0.405-0.976C3.387,6.668,3.443,6.67,3.497,6.67c1.75,0,3.172-1.423,3.172-3.172c0-0.054-0.002-0.11-0.004-0.168c0.312-0.158,0.64-0.293,0.976-0.405C7.68,2.969,7.719,3.01,7.757,3.048c0.6,0.6,1.396,0.93,2.243,0.93s1.643-0.33,2.243-0.93c0.038-0.039,0.076-0.079,0.115-0.123c0.336,0.112,0.663,0.247,0.976,0.405c-0.002,0.058-0.004,0.114-0.004,0.168c0,1.749,1.424,3.172,3.173,3.172c0.054,0,0.109-0.002,0.168-0.004c0.158,0.312,0.293,0.64,0.405,0.976c-0.045,0.038-0.086,0.077-0.124,0.116c-0.6,0.6-0.93,1.396-0.93,2.242c0,0.847,0.33,1.645,0.93,2.244c0.038,0.037,0.079,0.076,0.124,0.115C16.964,12.695,16.829,13.021,16.671,13.334 M10,5.417c-2.528,0-4.584,2.056-4.584,4.583c0,2.529,2.056,4.584,4.584,4.584s4.584-2.055,4.584-4.584C14.584,7.472,12.528,5.417,10,5.417 M10,13.812c-2.102,0-3.812-1.709-3.812-3.812c0-2.102,1.71-3.812,3.812-3.812c2.102,0,3.812,1.71,3.812,3.812C13.812,12.104,12.102,13.812,10,13.812">
                  </path>
                </svg>
                Temi
              </summary>
              <ul id="theme-list"
                class="p-2 shadow menu dropdown-content z-[1] bg-base-100 rounded w-full m-0 gap-2 flex-nowrap h-96 overflow-y-auto">
                <li data-set-theme="dark" data-theme="dark"
                  class="rounded hover:cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">dark</span>
                  <span class="hover:bg-base-100 active:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="cyberpunk" data-theme="cyberpunk"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">cyberpunk</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="light" data-theme="light"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">light</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="dim" data-theme="dim"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">dim</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="bumblebee" data-theme="bumblebee"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">bumblebee</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="night" data-theme="night"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">night</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="cupcake" data-theme="cupcake"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">cupcake</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="retro" data-theme="retro"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">retro</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="synthwave" data-theme="synthwave"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">synthwave</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="forest" data-theme="forest"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">forest</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="aqua" data-theme="aqua"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">aqua</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="black" data-theme="black"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">black</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="dracula" data-theme="dracula"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">dracula</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="autumn" data-theme="autumn"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">autumn</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="acid" data-theme="acid"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">acid</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="lemonade" data-theme="lemonade"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">lemonade</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="cofee" data-theme="cofee"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">cofee</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="luxury" data-theme="luxury"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">luxury</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="sunset" data-theme="sunset"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">sunset</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="winter" data-theme="winter"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">winter</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="nord" data-theme="nord"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">nord</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
                <li data-set-theme="lofi" data-theme="lofi"
                  class="rounded cursor-pointer flex-row items-center justify-between">
                  <span class="text-md hover:bg-base-100">lofi</span>
                  <span class="hover:bg-base-100">
                    <span class="bg-primary rounded-badge w-2 h-6"></span>
                    <span class="bg-secondary rounded-badge w-2 h-6"></span>
                    <span class="bg-accent rounded-badge w-2 h-6"></span>
                    <span class="bg-neutral rounded-badge w-2 h-6"></span>
                  </span>
                </li>
              </ul>
            </details>
          </li>
          <li>
            <a onclick="credits_modal.showModal()">
              <svg class="inline-block w-5 h-5 stroke-current" viewBox="0 0 20 20">
                <path
                  d="M15.94,10.179l-2.437-0.325l1.62-7.379c0.047-0.235-0.132-0.458-0.372-0.458H5.25c-0.241,0-0.42,0.223-0.373,0.458l1.634,7.376L4.06,10.179c-0.312,0.041-0.446,0.425-0.214,0.649l2.864,2.759l-0.724,3.947c-0.058,0.315,0.277,0.554,0.559,0.401l3.457-1.916l3.456,1.916c-0.419-0.238,0.56,0.439,0.56-0.401l-0.725-3.947l2.863-2.759C16.388,10.604,16.254,10.22,15.94,10.179M10.381,2.778h3.902l-1.536,6.977L12.036,9.66l-1.655-3.546V2.778z M5.717,2.778h3.903v3.335L7.965,9.66L7.268,9.753L5.717,2.778zM12.618,13.182c-0.092,0.088-0.134,0.217-0.11,0.343l0.615,3.356l-2.938-1.629c-0.057-0.03-0.122-0.048-0.184-0.048c-0.063,0-0.128,0.018-0.185,0.048l-2.938,1.629l0.616-3.356c0.022-0.126-0.019-0.255-0.11-0.343l-2.441-2.354l3.329-0.441c0.128-0.017,0.24-0.099,0.295-0.215l1.435-3.073l1.435,3.073c0.055,0.116,0.167,0.198,0.294,0.215l3.329,0.441L12.618,13.182z">
                </path>
              </svg>
              Noi
            </a>
          </li>
          <li>
            <a href="<%= request.getContextPath() + "/logout" %>">
              <svg class="inline-block w-5 h-5 stroke-current" aria-hidden="true" xmlns="http://www.w3.org/2000/svg"
                fill="none" viewBox="0 0 24 24">
                <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M20 12H8m12 0-4 4m4-4-4-4M9 4H7a3 3 0 0 0-3 3v10a3 3 0 0 0 3 3h2" />
              </svg>
              Esci
            </a>
          </li>
          <li>
            <a class="flex items-center gap-3" onclick="signout_modal.showModal()">
              <i class="fa-solid fa-ban"></i>
              Cancellati
            </a>   
          </li>
        </ul>
      </div>
    </div>

    <dialog id="credits_modal" class="modal">
      <div class="modal-box">
        <h3 class="font-bold text-lg">Grazie!</h3>
        <ul class="p-2">
          <li>Alessia</li>
          <li>Daniele</li>
          <li>Giorgio</li>
          <li>Fabrizio</li>
          <li>Simone</li>
          <li>Ryan</li>
        </ul>
      </div>
      <form method="dialog" class="modal-backdrop">
        <button>close</button>
      </form>
    </dialog>

    <dialog id="signout_modal" class="modal">
      <div class="modal-box flex flex-col">
        <form method="dialog">
          <button class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
        </form>
        <h3 class="font-bold text-lg">Conferma la cancellazione</h3>
        <p class="py-4 text-error"><strong>Attenzione quest'azione è irreversibile!</strong></p> 
        <form action="<%= request.getContextPath() + "/signout" %>" method="post" class="flex flex-col gap-2">
          <label>Scrivi "confermo la cancellazione" per cancellarti:</label>
          <input class="input input-bordered" type="text" pattern="confermo la cancellazione" required>
          <button class="btn btn-error btn-sm self-end">Cancellati</button>
        </form>  
      </div>
    </dialog>

    <script src="https://cdn.jsdelivr.net/npm/theme-change@2.0.2/index.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
      integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <script src="<%= request.getContextPath() %>/js/script.js"></script>
    <script>
         function toggleLike(postId, isOrderedByLikes, isOrderedByComments) {
            
              let toggleLikeButton = $("#toggle-like-btn-" + postId);
              let loadingLikeButtonSpinner = $("#loading-like-btn-" + postId);
              toggleLikeButton.addClass("hidden");
              loadingLikeButtonSpinner.removeClass("hidden")

              $.post("<%= request.getContextPath() %>/toggleLike", {
                "<%= Constants.POST_ID_KEY %>": postId,
                "<%= Constants.ORDER_BY_LIKES_KEY %>": isOrderedByLikes,
                "<%= Constants.ORDER_BY_COMMENTS_KEY %>": isOrderedByComments,
              }).done(function() {
                console.log("like toggled successfully");

                toggleLikeButton.removeClass("hidden");
                loadingLikeButtonSpinner.addClass("hidden");
                let heartIcon = $("#heart-icon-" + postId);
                let likesCounter = $("#likes-counter-" + postId).text();
                let dislikesCounter = $("#dislikes-counter-" + postId).text();
                let addDislikeButton = $("#add-dislike-btn-" + postId);
                let removeDislikeButton = $("#remove-dislike-btn-" + postId);
    
                if (heartIcon.hasClass("fa-solid")) {
                    // Rimuovi il like se è già attivo
                    heartIcon.removeClass("fa-solid");
                    heartIcon.addClass("fa-regular");
                    likesCounter--;
                } else {
                    // Rimuovi il dislike se è attivo e aggiungi il like
                    if (addDislikeButton.hasClass("hidden")) {
                        addDislikeButton.removeClass("hidden");
                        removeDislikeButton.addClass("hidden");
                        dislikesCounter--;
                    }
                    heartIcon.addClass("fa-solid");
                    heartIcon.removeClass("fa-regular")
                    likesCounter++;
                }
    
                $("#likes-counter-" + postId).text(likesCounter);
                $("#dislikes-counter-" + postId).text(dislikesCounter);
                window.location.reload();
              }).fail(function () {
                console.error("error during like toggling");
                toggleLikeButton.removeClass("hidden");
                loadingLikeButtonSpinner.addClass("hidden");
              })

        }

        function toggleDislike(postId, isOrderedByLikes, isOrderedByComments) {

              let visibleDislikeButton = $("[id*=dislike-btn]:not(.hidden)");
              let loadingDislikeBtnSpinner = $("#loading-dislike-btn-" + postId);
              visibleDislikeButton.addClass("hidden");
              loadingDislikeBtnSpinner.removeClass("hidden");

              
              $.post("<%= request.getContextPath() %>/toggleDislike", {
                "<%= Constants.POST_ID_KEY %>": postId,
                "<%= Constants.ORDER_BY_LIKES_KEY %>": isOrderedByLikes,
                "<%= Constants.ORDER_BY_COMMENTS_KEY %>": isOrderedByComments,
              }).done(function() {
                console.log("like toggled successfully");

                visibleDislikeButton.removeClass("hidden");
                loadingDislikeBtnSpinner.addClass("hidden");
                let heartIcon = $("#heart-icon-" + postId);
                let likesCounter = $("#likes-counter-" + postId).text();
                let dislikesCounter = $("#dislikes-counter-" + postId).text();
                let addDislikeButton = $("#add-dislike-btn-" + postId);
                let removeDislikeButton = $("#remove-dislike-btn-" + postId);
                var likeButton = document.getElementById("likeButton");
                var dislikeButton = document.getElementById("dislikeButton");
                var likeCountElement = document.getElementById("likeCount");
                var dislikeCountElement = document.getElementById("dislikeCount");

                if (addDislikeButton.hasClass("hidden")) {
                    // Rimuovi il dislike se è già attivo
                    addDislikeButton.removeClass("hidden");
                    removeDislikeButton.addClass("hidden");  
                    dislikesCounter--;
                } else {
                    // Rimuovi il like se è attivo e aggiungi il dislike
                    if (heartIcon.hasClass("fa-solid")) {
                      heartIcon.removeClass("fa-solid");
                      heartIcon.addClass("fa-regular");
                      likesCounter--;
                  } 
                    addDislikeButton.addClass("hidden");
                    removeDislikeButton.removeClass("hidden");
                    dislikesCounter++;
                    
                }

                $("#likes-counter-" + postId).text(likesCounter);
                $("#dislikes-counter-" + postId).text(dislikesCounter);
                window.location.reload();
              }).fail(function () {
                console.error("error during like toggling");
                visibleDislikeButton.removeClass("hidden");
                loadingDislikeBtnSpinner.addClass("hidden");
              });
        }
    </script>
  </body>

</html>