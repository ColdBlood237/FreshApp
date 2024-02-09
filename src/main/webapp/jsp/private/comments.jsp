<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.fresh.FreshApp.utils.Constants" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
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
        <style>
            textarea {
                resize: none;
            }
        </style>
    </head>

    <body class="min-h-screen">

        <% 
          Post post = (Post) request.getAttribute(Constants.POST_DATA_KEY); 
          Utente userLogged = (Utente) request.getSession().getAttribute(Constants.USER_DATA_KEY);
          Boolean isLiked = post.getLikes().contains(userLogged);
          Boolean isDisliked = post.getDislikes().contains(userLogged); 
          Boolean isOrderedByLikes = false;
        Boolean isOrderedByComments = false; 
        %>

        <div class="navbar bg-base-100 justify-between border-b border-neutral">
            <a class="btn btn-ghost text-xl" href="<%= request.getContextPath() + "/readAllPosts" %>">
                <svg class="inline-block w-5 h-5 stroke-current" viewBox="0 0 20 20">
                    <path
                        d="M3.24,7.51c-0.146,0.142-0.146,0.381,0,0.523l5.199,5.193c0.234,0.238,0.633,0.064,0.633-0.262v-2.634c0.105-0.007,0.212-0.011,0.321-0.011c2.373,0,4.302,1.91,4.302,4.258c0,0.957-0.33,1.809-1.008,2.602c-0.259,0.307,0.084,0.762,0.451,0.572c2.336-1.195,3.73-3.408,3.73-5.924c0-3.741-3.103-6.783-6.916-6.783c-0.307,0-0.615,0.028-0.881,0.063V2.575c0-0.327-0.398-0.5-0.633-0.261L3.24,7.51 M4.027,7.771l4.301-4.3v2.073c0,0.232,0.21,0.409,0.441,0.366c0.298-0.056,0.746-0.123,1.184-0.123c3.402,0,6.172,2.709,6.172,6.041c0,1.695-0.718,3.24-1.979,4.352c0.193-0.51,0.293-1.045,0.293-1.602c0-2.76-2.266-5-5.046-5c-0.256,0-0.528,0.018-0.747,0.05C8.465,9.653,8.328,9.81,8.328,9.995v2.074L4.027,7.771z">
                    </path>
                </svg>
            </a>
            <div class="mx-auto">
                <a class="btn btn-ghost text-xl" href="<%= request.getContextPath() %>/readAllPosts"><img src="<%= request.getContextPath() + "/resources/logo2.png" %>" class="max-h-8" /> Fresh</a>
            </div>
        </div>

        <div class="bg-base-200">
            <%@include file="../components/post.jsp" %>
        </div>

        <div class="flex gap-2 my-3 px-4 w-full lg:w-1/2 mx-auto items-start">
            <div class="avatar">
                <div class="w-12 rounded-full">
                  <% if (userLogged.getImmagineProfilo() != null && !userLogged.getImmagineProfilo().trim().isEmpty()) { %>  
                    <img src="<%= "http://localhost:8080/" + "FreshAppImages/" + userLogged.getImmagineProfilo() %>" alt="<%= userLogged.getUsername() %>" />
                  <%  } else { %>
                    <img src="https://ui-avatars.com/api/?name=<%= userLogged.getUsername() %>" alt="<%= userLogged.getUsername() %>" />
                  <% } %> 
                </div>
            </div>
            <form class="w-full flex items-end" id="create-post" action="<%= request.getContextPath() + "/createComment" %>"
                method="post">
                <textarea name="<%= Constants.COMMENT_TEXT_KEY %>"
                    class="textarea textarea-lg textarea-ghost w-full mr-2 resize-none"
                    placeholder="Posta la tua risposta"></textarea>
                <input type="hidden" name="<%= Constants.POST_ID_KEY  %>" value="<%= post.getId() %>"/>
                <button class="btn btn-primary btn-sm ">Posta</button>
            </form>
        </div>

        <% if (post.getCommenti() != null && post.getCommenti().size() > 0) { %>
        <%     for(Commento commento : post.getCommenti()) { %>
       
        <div
            class="card w-full lg:w-1/2 mx-auto flex flex-row gap-4 bg-base-200 text-base-content p-4 rounded-none border-t border-neutral">
            <div class="avatar self-start">
                <div class="w-12 rounded-full">
                  <% if (commento.getAutore().getImmagineProfilo() != null && !commento.getAutore().getImmagineProfilo().trim().isEmpty()) { %>  
                    <img src="<%= "http://localhost:8080/" + "FreshAppImages/" + commento.getAutore().getImmagineProfilo() %>" alt="<%= commento.getAutore().getUsername() %>" />
                  <%  } else { %>
                    <img src="https://ui-avatars.com/api/?name=<%= commento.getAutore().getUsername() %>" alt="<%= commento.getAutore().getUsername() %>" />
                  <% } %> 
                </div>
            </div>
            <div class="w-full">
                <div class="card-title flex justify-between">
                    <p class="text-sm">
                        <%= commento.getAutore().getUsername() %>
                    </p>

                    <% if (commento.getAutore().equals(userLogged)) { %>

                      <div class="dropdown dropdown-end">
                          <button tabindex="0">
                              <svg class="inline-block w-6 h-6 stroke-current hover:stroke-primary" viewBox="0 0 20 20">
                                  <path fill="none" d="M3.936,7.979c-1.116,0-2.021,0.905-2.021,2.021s0.905,2.021,2.021,2.021S5.957,11.116,5.957,10
                          S5.052,7.979,3.936,7.979z M3.936,11.011c-0.558,0-1.011-0.452-1.011-1.011s0.453-1.011,1.011-1.011S4.946,9.441,4.946,10
                          S4.494,11.011,3.936,11.011z M16.064,7.979c-1.116,0-2.021,0.905-2.021,2.021s0.905,2.021,2.021,2.021s2.021-0.905,2.021-2.021
                          S17.181,7.979,16.064,7.979z M16.064,11.011c-0.559,0-1.011-0.452-1.011-1.011s0.452-1.011,1.011-1.011S17.075,9.441,17.075,10
                          S16.623,11.011,16.064,11.011z M10,7.979c-1.116,0-2.021,0.905-2.021,2.021S8.884,12.021,10,12.021s2.021-0.905,2.021-2.021
                          S11.116,7.979,10,7.979z M10,11.011c-0.558,0-1.011-0.452-1.011-1.011S9.442,8.989,10,8.989S11.011,9.441,11.011,10
                          S10.558,11.011,10,11.011z"></path>
                              </svg>
                          </button>
                          <ul tabindex="0" class="dropdown-content z-[1] menu p-2 shadow bg-base-200 rounded-box w-52">
                              <li id="<%= commento.getId() %>" class="modify-comment">
                                  <a onclick="">
                                      <svg class="inline-block w-5 h-5 stroke-current hover:stroke-primary"
                                          viewBox="0 0 20 20">
                                          <path fill="none"
                                              d="M19.404,6.65l-5.998-5.996c-0.292-0.292-0.765-0.292-1.056,0l-2.22,2.22l-8.311,8.313l-0.003,0.001v0.003l-0.161,0.161c-0.114,0.112-0.187,0.258-0.21,0.417l-1.059,7.051c-0.035,0.233,0.044,0.47,0.21,0.639c0.143,0.14,0.333,0.219,0.528,0.219c0.038,0,0.073-0.003,0.111-0.009l7.054-1.055c0.158-0.025,0.306-0.098,0.417-0.211l8.478-8.476l2.22-2.22C19.695,7.414,19.695,6.941,19.404,6.65z M8.341,16.656l-0.989-0.99l7.258-7.258l0.989,0.99L8.341,16.656z M2.332,15.919l0.411-2.748l4.143,4.143l-2.748,0.41L2.332,15.919z M13.554,7.351L6.296,14.61l-0.849-0.848l7.259-7.258l0.423,0.424L13.554,7.351zM10.658,4.457l0.992,0.99l-7.259,7.258L3.4,11.715L10.658,4.457z M16.656,8.342l-1.517-1.517V6.823h-0.003l-0.951-0.951l-2.471-2.471l1.164-1.164l4.942,4.94L16.656,8.342z">
                                          </path>
                                      </svg>
                                      <span>Modifica</span>
                                  </a>
                              </li>
                              <li>
                                  <a href="<%= request.getContextPath() + "/deleteComment?" + Constants.COMMENT_ID_KEY + "=" + commento.getId() %>">
                                      <svg class="inline-block w-5 h-5 stroke-current hover:stroke-primary"
                                          viewBox="0 0 20 20">
                                          <path fill="none" d="M18.693,3.338h-1.35l0.323-1.834c0.046-0.262-0.027-0.536-0.198-0.739c-0.173-0.206-0.428-0.325-0.695-0.325
                            H3.434c-0.262,0-0.513,0.114-0.685,0.312c-0.173,0.197-0.25,0.46-0.215,0.721L2.79,3.338H1.307c-0.502,0-0.908,0.406-0.908,0.908
                            c0,0.502,0.406,0.908,0.908,0.908h1.683l1.721,13.613c0.057,0.454,0.444,0.795,0.901,0.795h8.722c0.458,0,0.845-0.34,0.902-0.795
                            l1.72-13.613h1.737c0.502,0,0.908-0.406,0.908-0.908C19.601,3.744,19.195,3.338,18.693,3.338z M15.69,2.255L15.5,3.334H4.623
                            L4.476,2.255H15.69z M13.535,17.745H6.413L4.826,5.193H15.12L13.535,17.745z"></path>
                                      </svg>
                                      <span>Cancella</span>
                                  </a>
                              </li>
                          </ul>
                      </div>

                    <% } %>
                    
                </div>
                <p class="mb-4 text-xs">
                    <%= commento.getDataPubblicazione().format(DateTimeFormatter.ofPattern("dd MMMM yyyy HH:mm:ss"))  %>
                </p>
                <p class="comment-text" id="comment-<%= commento.getId() %>">
                    <%= commento.getTesto() %>
                </p>
                <form id="modify-comment-form-<%= commento.getId() %>" action="<%= request.getContextPath() %>/modifyComment" method="post" class="flex justify-between items-end w-full hidden">
                    <textarea name="<%= Constants.COMMENT_TEXT_KEY %>"
                        class="textarea textarea-bordered textarea-lg textarea-ghost w-full mr-2 resize-none"
                        placeholder="Posta la tua risposta"><%= commento.getTesto().trim() %></textarea>
                    <input type="hidden" name="<%= Constants.COMMENT_ID_KEY %>" value="<%= commento.getId() %>" />
                    <div class="w-min">
                        <button type="button" class="btn btn-active btn-error btn-sm mb-2 w-16 cancel-modification" id="cancel-modification-<%= commento.getId() %>">Annulla</button>
                        <button class="btn btn-secondary btn-sm w-16">Salva</button>
                    </div>
                </form>
            </div>
        </div>
        
        <%      
                }
            } 
        %>
        

        <script src="https://cdn.jsdelivr.net/npm/theme-change@2.0.2/index.js"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
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
       </script>
    </body>

</html>