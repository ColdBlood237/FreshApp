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
        <title>New Post</title>
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.6.0/dist/full.min.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://kit.fontawesome.com/7dff5f4879.js" crossorigin="anonymous"></script>
        <link rel="icon" type="image/x-icon" href="../../resources/logo2.png">
    </head>

    <body>

        <% 
            String emptyPostError = (String) request.getAttribute(Constants.EMPTY_POST_ERROR); 
            String imageNullError = (String) request.getAttribute(Constants.IMG_NULL_ERROR); 
        %>

        <% Utente userLogged = (Utente) request.getSession().getAttribute(Constants.USER_DATA_KEY); %>

        <div class="navbar bg-base-100 justify-between border-b border-neutral">
            <a class="btn btn-ghost text-xl" href="<%= request.getContextPath() %>/readAllPosts">
                <svg class="inline-block w-5 h-5 stroke-current" viewBox="0 0 20 20">
                    <path
                        d="M3.24,7.51c-0.146,0.142-0.146,0.381,0,0.523l5.199,5.193c0.234,0.238,0.633,0.064,0.633-0.262v-2.634c0.105-0.007,0.212-0.011,0.321-0.011c2.373,0,4.302,1.91,4.302,4.258c0,0.957-0.33,1.809-1.008,2.602c-0.259,0.307,0.084,0.762,0.451,0.572c2.336-1.195,3.73-3.408,3.73-5.924c0-3.741-3.103-6.783-6.916-6.783c-0.307,0-0.615,0.028-0.881,0.063V2.575c0-0.327-0.398-0.5-0.633-0.261L3.24,7.51 M4.027,7.771l4.301-4.3v2.073c0,0.232,0.21,0.409,0.441,0.366c0.298-0.056,0.746-0.123,1.184-0.123c3.402,0,6.172,2.709,6.172,6.041c0,1.695-0.718,3.24-1.979,4.352c0.193-0.51,0.293-1.045,0.293-1.602c0-2.76-2.266-5-5.046-5c-0.256,0-0.528,0.018-0.747,0.05C8.465,9.653,8.328,9.81,8.328,9.995v2.074L4.027,7.771z">
                    </path>
                </svg>
            </a>
            <div class="mx-auto">
                <a class="btn btn-ghost text-xl"><img src="../../resources/logo2.png" class="max-h-8" /> Fresh</a>
            </div>
            <button form="create-post" class="btn btn-primary md:hidden">
                Posta <!-- posta o modifica-->
            </button>
        </div>

        <div class="flex gap-2 items-start mt-2 px-4 w-full md:w-8/12 mx-auto">
            <div class="avatar">
                <div class="w-14 rounded-full">
                    <% if (userLogged.getImmagineProfilo() != null && !userLogged.getImmagineProfilo().trim().isEmpty()) { %>  
                        <img src="<%= "http://localhost:8080/" + "FreshAppImages/" + userLogged.getImmagineProfilo() %>" alt="<%= userLogged.getUsername() %>" />
                      <%  } else { %>
                        <img src="https://ui-avatars.com/api/?name=<%= userLogged.getUsername() %>" alt="<%= userLogged.getUsername() %>" />
                      <% } %> 
                </div>
            </div>

            <% if (request.getAttribute(Constants.POST_ID_KEY) != null) { %>

                <form class="w-full" id="create-post" action="<%= request.getContextPath() %>/modifyPost" method="post" enctype="multipart/form-data">

            <% } else { %>
                
                <form class="w-full" id="create-post" action="<%= request.getContextPath() %>/createImgPost" method="post" enctype="multipart/form-data">
            
            <% } %>
            
            <% if (request.getAttribute(Constants.POST_ID_KEY) != null) { %>
                <textarea class="textarea textarea-ghost w-full textarea-lg " name="<%= Constants.CREATE_POST_KEY %>" placeholder="Che c'è di nuovo?"><%= (String) request.getAttribute(Constants.POST_TEXT_KEY) %></textarea>
                <input type="hidden" name="<%= Constants.POST_ID_KEY %>" value="<%= request.getAttribute(Constants.POST_ID_KEY) %>" />
            <% } else { %>
                <textarea class="textarea textarea-ghost w-full textarea-lg " name="<%= Constants.CREATE_POST_KEY %>" placeholder="Che c'è di nuovo?"></textarea>
            <% } %>
                <div class="flex items-center justify-between">
                    <div class="flex items-center gap-2">
                        <label for="img-upload" class="mr-1 hover:cursor-pointer">
                            <svg class="inline-block w-5 h-5 stroke-current" viewBox="0 0 20 20">
                                <path
                                    d="M18.555,15.354V4.592c0-0.248-0.202-0.451-0.45-0.451H1.888c-0.248,0-0.451,0.203-0.451,0.451v10.808c0,0.559,0.751,0.451,0.451,0.451h16.217h0.005C18.793,15.851,18.478,14.814,18.555,15.354 M2.8,14.949l4.944-6.464l4.144,5.419c0.003,0.003,0.003,0.003,0.003,0.005l0.797,1.04H2.8z M13.822,14.949l-1.006-1.317l1.689-2.218l2.688,3.535H13.822z M17.654,14.064l-2.791-3.666c-0.181-0.237-0.535-0.237-0.716,0l-1.899,2.493l-4.146-5.42c-0.18-0.237-0.536-0.237-0.716,0l-5.047,6.598V5.042h15.316V14.064z M12.474,6.393c-0.869,0-1.577,0.707-1.577,1.576s0.708,1.576,1.577,1.576s1.577-0.707,1.577-1.576S13.343,6.393,12.474,6.393 M12.474,8.645c-0.371,0-0.676-0.304-0.676-0.676s0.305-0.676,0.676-0.676c0.372,0,0.676,0.304,0.676,0.676S12.846,8.645,12.474,8.645">
                                </path>
                            </svg>
                        </label>
                        <input id="img-upload" type="file" name="<%= Constants.ADD_IMG_KEY %>" class="file-input file-input-ghost w-full max-w-xs" accept="image/*" />
                    </div>

                    <% if (request.getAttribute(Constants.POST_ID_KEY) != null) { %>

                        <button class="btn btn-primary justify-self-start hidden md:inline">Modifica</button>
        
                    <% } else { %>
                        
                        <button class="btn btn-primary justify-self-start hidden md:inline">Posta</button>
                    
                    <% } %>

                </div>
            </form>

            <% if (emptyPostError != null) { %>
                <div role="alert" class="alert alert-error my-4">
                    <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                    <span><%= emptyPostError %></span>
                </div>
            <% } %>
            <% if (imageNullError != null) { %>
                <div role="alert" class="alert alert-error">
                    <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                    <span><%= imageNullError %></span>
                </div>
            <% } %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/theme-change@2.0.2/index.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
    </body>

</html>