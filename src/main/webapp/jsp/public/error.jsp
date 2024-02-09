<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fresh.FreshApp.utils.Constants" %>
    <!DOCTYPE html>
    <html>
        <head>
            <meta charset="UTF-8">
            <title>404</title>
            <link href="https://cdn.jsdelivr.net/npm/daisyui@4.6.0/dist/full.min.css" rel="stylesheet"
                type="text/css" />
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="https://kit.fontawesome.com/7dff5f4879.js" crossorigin="anonymous"></script>
            <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() + " /resources/logo2.png" %>">
        </head>

        <body>
            <div role="alert" class="alert max-w-11/12 alert-error mx-auto mt-8">
                <svg xmlns="http://www.w3.org/2000/svg" class="stroke-current shrink-0 h-6 w-6" fill="none"
                    viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <% if(request.getAttribute(Constants.UNEXPECTED_ERROR_KEY) != null) { %>
                    <span><%= (String) request.getAttribute(Constants.UNEXPECTED_ERROR_KEY) %></span>
                <% } else { %>
                    <span>Errore imprevisto!</span>
                <% } %>
            </div>
        </body>

    </html>