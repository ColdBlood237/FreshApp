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
        <title>Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.6.0/dist/full.min.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://kit.fontawesome.com/7dff5f4879.js" crossorigin="anonymous"></script>
        <link rel="icon" type="image/x-icon" href="<%= request.getContextPath() + "/resources/logo2.png" %>">
    </head>

    <body>

        <%  
            Utente user = (Utente) request.getAttribute(Constants.USER_DATA_KEY); 
            Utente userLogged = (Utente) request.getSession().getAttribute(Constants.USER_DATA_KEY);
            Boolean isOrderedByLikes = false;
            Boolean isOrderedByComments = false;
        %>

        <div class="navbar bg-base-100 justify-between border-b border-neutral">
            <a class="btn btn-ghost text-xl" href="<%= request.getContextPath() %>/readAllPosts">
                <svg class="inline-block w-5 h-5 stroke-current" viewBox="0 0 20 20">
                    <path
                        d="M3.24,7.51c-0.146,0.142-0.146,0.381,0,0.523l5.199,5.193c0.234,0.238,0.633,0.064,0.633-0.262v-2.634c0.105-0.007,0.212-0.011,0.321-0.011c2.373,0,4.302,1.91,4.302,4.258c0,0.957-0.33,1.809-1.008,2.602c-0.259,0.307,0.084,0.762,0.451,0.572c2.336-1.195,3.73-3.408,3.73-5.924c0-3.741-3.103-6.783-6.916-6.783c-0.307,0-0.615,0.028-0.881,0.063V2.575c0-0.327-0.398-0.5-0.633-0.261L3.24,7.51 M4.027,7.771l4.301-4.3v2.073c0,0.232,0.21,0.409,0.441,0.366c0.298-0.056,0.746-0.123,1.184-0.123c3.402,0,6.172,2.709,6.172,6.041c0,1.695-0.718,3.24-1.979,4.352c0.193-0.51,0.293-1.045,0.293-1.602c0-2.76-2.266-5-5.046-5c-0.256,0-0.528,0.018-0.747,0.05C8.465,9.653,8.328,9.81,8.328,9.995v2.074L4.027,7.771z">
                    </path>
                </svg>
            </a>
            <div class="mx-auto">
                <a href="<%= request.getContextPath() %>/readAllPosts" class="btn btn-ghost text-xl"><img src="<%= request.getContextPath() + "/resources/logo2.png" %>" class="max-h-8" /> Fresh</a>
            </div>
        </div>
 
        <div class="border-b border-neutral p-4 bg-base-200 mx-auto w-full sm:w-3/4 lg:w-1/2 lg:border-x">
            <div class="flex items-start justify-between">
                <div>
                    <div class="avatar hover:cursor-pointer" onclick="profile_pic_modal.showModal()">
                        <div class="w-20 rounded-full">
                            <% if (user.getImmagineProfilo() != null && !user.getImmagineProfilo().trim().isEmpty()) { %>  
                                <img src="<%= "http://localhost:8080/" + "FreshAppImages/" + user.getImmagineProfilo() %>" alt="<%= user.getUsername() %>" />
                            <% } else { %>
                                <img src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>" alt="<%= user.getUsername() %>" />
                            <% } %>  
                        </div>
                    </div>
                    <dialog id="profile_pic_modal" class="modal">
                        <div class="modal-box p-4 pt-12">
                            <form method="dialog">
                                <button class="btn btn-sm btn-ghost absolute right-2 top-2">✕</button>
                            </form>
                            <% if (user.getImmagineProfilo() != null && !user.getImmagineProfilo().trim().isEmpty()) { %>  
                                <img src="<%= "http://localhost:8080/" + "FreshAppImages/" + user.getImmagineProfilo() %>" alt="<%= user.getUsername() %>" />
                            <% } else { %>
                                <img src="https://ui-avatars.com/api/?name=<%= user.getUsername() %>" alt="<%= user.getUsername() %>" />
                            <% } %>  
                        </div>
                    </dialog>
                    <p class="hover:cursor-pointer" onclick="followers_modal.showModal()">followers: <%= user.getFollowers().size() %></p>
                    <dialog id="followers_modal" class="modal">
                        <div class="modal-box p-4 pt-12">
                            <form method="dialog">
                                <button class="btn btn-sm btn-ghost absolute right-2 top-2">✕</button>
                            </form>
                            <ul>
                            <% for (Utente follower : user.getFollowers()) { %>
                                <li class="mb-2 border-t border-neutral hover:bg-base-200">
                                    <a class="py-2" href="<%= request.getContextPath() + "/getUserProfile?" + Constants.MAIL_KEY + "=" + follower.getEmail() %>">
                                        <div class="flex justify-between items-center">
                                            <div class="avatar">
                                                <div class="w-12 rounded-full">
                                                <% if (follower.getImmagineProfilo() != null && !follower.getImmagineProfilo().trim().isEmpty()) { %>  
                                                    <img src="<%= "http://localhost:8080/" + "FreshAppImages/" + follower.getImmagineProfilo() %>" alt="<%= follower.getUsername() %>" />
                                                <% } else { %>
                                                    <img src="https://ui-avatars.com/api/?name=<%= follower.getUsername() %>" alt="<%= follower.getUsername() %>" />
                                                <% } %>  
                                                </div>
                                            </div>
                                            <p><%= follower.getUsername() %></p>
                                        </div>
                                    </a>
                                </li>
                            <% } %>
                            </ul>
                        </div>
                    </dialog>
                    <p class="hover:cursor-pointer" onclick="seguiti_modal.showModal()">seguiti: <%=user.getSeguiti().size() %></p>
                    <dialog id="seguiti_modal" class="modal">
                        <div class="modal-box p-4 pt-12">
                            <form method="dialog">
                                <button class="btn btn-sm btn-ghost absolute right-2 top-2">✕</button>
                            </form>
                            <ul>
                            <% for (Utente seguito : user.getSeguiti()) { %>
                                <li class="mb-2 border-t border-neutral">
                                    <a class="py-2" href="<%= request.getContextPath() + "/getUserProfile?" + Constants.MAIL_KEY + "=" + seguito.getEmail() %>">
                                        <div class="flex justify-between items-center">
                                            <div class="avatar">
                                                <div class="w-12 rounded-full">
                                                <% if (seguito.getImmagineProfilo() != null && !seguito.getImmagineProfilo().trim().isEmpty()) { %>  
                                                    <img src="<%= "http://localhost:8080/" + "FreshAppImages/" + seguito.getImmagineProfilo() %>" alt="<%= seguito.getUsername() %>" />
                                                <% } else { %>
                                                    <img src="https://ui-avatars.com/api/?name=<%= seguito.getUsername() %>" alt="<%= seguito.getUsername() %>" />
                                                <% } %>  
                                                </div>
                                            </div>
                                            <p><%= seguito.getUsername() %></p>
                                        </div>
                                    </a>
                                </li>
                            <% } %>
                            </ul>
                        </div>
                    </dialog>
                    
                </div>
                <div class="flex flex-col items-end">
                    <p>
                        <%= user.getUsername() %>
                    </p>
                    <p>
                        <%= user.getDataRegistrazione().format(DateTimeFormatter.ofPattern("dd MMMM yyyy HH:mm:ss")) %>
                    </p>
                    <% if (!userLogged.equals(user)) { %>
                        <% if(user.getFollowers().contains(userLogged)) { %>
                            <button onclick="toggleFollow(event, '<%= user.getUsername() %>', '<%= user.getEmail() %>')" class="follow-btn btn btn-success mt-4">segui già</button>
                        <% } else { %>
                            <button onclick="toggleFollow(event, '<%= user.getUsername() %>', '<%= user.getEmail() %>')" class="follow-btn btn btn-success btn-outline mt-4">segui</button>
                        <% } %>
                        <span id="follow-loading" class="loading loading-dots loading-lg hidden text-success mt-4 mr-2"></span>
                    <% } %>
                </div>
            </div>

        </div>

        <div class="posts">

            <% 
                for (Post post : user.getPosts()) { 
                    Boolean isLiked = post.getLikes().contains(userLogged);
                    Boolean isDisliked = post.getDislikes().contains(userLogged);     
            %>
                <%@include file="../components/post.jsp" %>   
            
            <% } %>

        </div>


        <script src="https://cdn.jsdelivr.net/npm/theme-change@2.0.2/index.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="<%= request.getContextPath() %>/js/script.js"></script>
        <script>
            function toggleLike(postId) {
               
                 let toggleLikeButton = $("#toggle-like-btn-" + postId);
                 let loadingLikeButtonSpinner = $("#loading-like-btn-" + postId);
                 toggleLikeButton.addClass("hidden");
                 loadingLikeButtonSpinner.removeClass("hidden")
   
                 $.post("<%= request.getContextPath() %>/toggleLike", {
                   "<%= Constants.POST_ID_KEY %>": postId,
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
                 }).fail(function () {
                   console.error("error during like toggling");
                   toggleLikeButton.removeClass("hidden");
                   loadingLikeButtonSpinner.addClass("hidden");
                 })
   
           }
   
            function toggleDislike(postId) {
   
                 let visibleDislikeButton = $("[id*=dislike-btn]:not(.hidden)");
                 let loadingDislikeBtnSpinner = $("#loading-dislike-btn-" + postId);
                 visibleDislikeButton.addClass("hidden");
                 loadingDislikeBtnSpinner.removeClass("hidden");
   
                 
                 $.post("<%= request.getContextPath() %>/toggleDislike", {
                   "<%= Constants.POST_ID_KEY %>": postId,
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
                 }).fail(function () {
                   console.error("error during like toggling");
                   visibleDislikeButton.removeClass("hidden");
                   loadingDislikeBtnSpinner.addClass("hidden");
                 });
               
           }
       
            function toggleFollow(event, username, email) {
                let followBtn = $(event.currentTarget);
                let followFloading = $("#follow-loading")
                console.log(followBtn);

                followBtn.addClass("hidden");
                followFloading.removeClass("hidden");

                $.post("<%= request.getContextPath() %>/toggleSeguiti", {
                    "<%= Constants.FOLLOW_UTENTE_KEY %>" : username,
                    "<%= Constants.MAIL_KEY %>" : email,
                }).done(function() {
                    console.log("follow toggled successfully");

                    followFloading.addClass("hidden");
                    if (followBtn.hasClass("btn-outline")) {
                        followBtn.removeClass("btn-outline");
                        followBtn.text("segui già");
                    } else {
                        followBtn.addClass("btn-outline");
                        followBtn.text("segui");
                    }
                    followBtn.removeClass("hidden");
                    window.location.reload();
                }).fail(function() {
                    console.error("error during follow toggle")
                    followBtn.removeClass("hidden");
                    $("#follow-loading").addClass("hidden");
                }) 
            }
        </script>
    </body>

</html>