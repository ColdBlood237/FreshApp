<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.fresh.FreshApp.utils.Constants" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.fresh.FreshApp.model.Post" %>
<%@ page import="com.fresh.FreshApp.model.Commento" %>
<%@ page import="com.fresh.FreshApp.model.Utente" %>

<!DOCTYPE html>
<html lang="it">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cerca utenti</title>
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.6.0/dist/full.min.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://kit.fontawesome.com/7dff5f4879.js" crossorigin="anonymous"></script>
        <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() + "/resources/logo2.png" %>">
    </head>

    <body class="min-h-screen">

        <% List<Utente> users = (ArrayList<Utente>) request.getAttribute(Constants.PROFILES_FOUND); %>

        <h1 class="text-center text-2xl font-bold my-4">Cerca utenti</h1>

        <form action="<%= request.getContextPath() + "/searchUsers" %>" class="w-full mx-auto md:w-1/2 flex gap-2 p-2">
            <input type="text" name="<%= Constants.USERNAME_KEY %>" placeholder="username" class="input input-bordered input-primary w-full">
            <button type="">
                <svg class="inline-block w-6 h-6 stroke-current hover:stroke-primary" viewBox="0 0 20 20">
                    <path
                        d="M18.125,15.804l-4.038-4.037c0.675-1.079,1.012-2.308,1.01-3.534C15.089,4.62,12.199,1.75,8.584,1.75C4.815,1.75,1.982,4.726,2,8.286c0.021,3.577,2.908,6.549,6.578,6.549c1.241,0,2.417-0.347,3.44-0.985l4.032,4.026c0.167,0.166,0.43,0.166,0.596,0l1.479-1.478C18.292,16.234,18.292,15.968,18.125,15.804 M8.578,13.99c-3.198,0-5.716-2.593-5.733-5.71c-0.017-3.084,2.438-5.686,5.74-5.686c3.197,0,5.625,2.493,5.64,5.624C14.242,11.548,11.621,13.99,8.578,13.99 M16.349,16.981l-3.637-3.635c0.131-0.11,0.721-0.695,0.876-0.884l3.642,3.639L16.349,16.981z">
                    </path>
                </svg>
            </button>
        </form>

        <div class="users-container md:w-1/2 mx-auto">

            <% if (users != null) { %>
                <% for(Utente user : users) { %>

                    <a href="<%= request.getContextPath() + "/getUserProfile?" + Constants.MAIL_KEY + "=" + user.getEmail() %>">
                        <div class="user flex items-center gap-4 hover:bg-base-200 hover:cursor-pointer m-2 p-2">
                            <div class="avatar">
                                <div class="w-14 rounded-full">
                                    <% if (user.getImmagineProfilo() != null && !user.getImmagineProfilo().trim().isEmpty()) { %>
                                        <img src="<%= "http://localhost:8080/" + "FreshAppImages/" + user.getImmagineProfilo() %>" alt="<%= user.getUsername() %>" />
                                    <%  } else { %>
                                        <img src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>" alt="<%= user.getUsername() %>" />
                                    <% } %>
                                </div>
                            </div>
                            <span class="text-xl font-semibold"><%= user.getUsername() %></span>
                        </div>
                    </a>
 
                <% } %>
            <% } %>

            <% if (users == null || users.size() == 0) { %>

                <p class="text-primary text-center">nessun bro trovato :(</p>

            <% } %>   
        </div>

        <footer class="footer flex justify-around p-4 bg-base-300 text-base-content fixed bottom-0">
            <a href="<%= request.getContextPath() %>/readAllPosts">
                <button>
                    <svg class="inline-block w-6 h-6 stroke-current hover:stroke-primary" viewBox="0 0 20 20">
                        <path
                            d="M18.121,9.88l-7.832-7.836c-0.155-0.158-0.428-0.155-0.584,0L1.842,9.913c-0.262,0.263-0.073,0.705,0.292,0.705h2.069v7.042c0,0.227,0.187,0.414,0.414,0.414h3.725c0.228,0,0.414-0.188,0.414-0.414v-3.313h2.483v3.313c0,0.227,0.187,0.414,0.413,0.414h3.726c0.229,0,0.414-0.188,0.414-0.414v-7.042h2.068h0.004C18.331,10.617,18.389,10.146,18.121,9.88 M14.963,17.245h-2.896v-3.313c0-0.229-0.186-0.415-0.414-0.415H8.342c-0.228,0-0.414,0.187-0.414,0.415v3.313H5.032v-6.628h9.931V17.245z M3.133,9.79l6.864-6.868l6.867,6.868H3.133z">
                        </path>
                    </svg>
                </button>
            </a>
            <a href="<%= request.getContextPath() %>/jsp/private/search.jsp">
                <button>
                    <svg class="inline-block w-6 h-6 stroke-current hover:stroke-primary" viewBox="0 0 20 20">
                        <path
                            d="M18.125,15.804l-4.038-4.037c0.675-1.079,1.012-2.308,1.01-3.534C15.089,4.62,12.199,1.75,8.584,1.75C4.815,1.75,1.982,4.726,2,8.286c0.021,3.577,2.908,6.549,6.578,6.549c1.241,0,2.417-0.347,3.44-0.985l4.032,4.026c0.167,0.166,0.43,0.166,0.596,0l1.479-1.478C18.292,16.234,18.292,15.968,18.125,15.804 M8.578,13.99c-3.198,0-5.716-2.593-5.733-5.71c-0.017-3.084,2.438-5.686,5.74-5.686c3.197,0,5.625,2.493,5.64,5.624C14.242,11.548,11.621,13.99,8.578,13.99 M16.349,16.981l-3.637-3.635c0.131-0.11,0.721-0.695,0.876-0.884l3.642,3.639L16.349,16.981z">
                        </path>
                    </svg>
                </button>
            </a>
        </footer>


        <script src="https://cdn.jsdelivr.net/npm/theme-change@2.0.2/index.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>      

    </body>

</html>