<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.io.File" %>

<div
            class="card w-full flex flex-row gap-4 bg-base-100 text-base-content p-4 rounded-none border-b border-neutral">
            <div class="mx-auto w-full sm:w-3/4 lg:w-1/2">
              <div class="flex gap-3">
                <div class="avatar self-start ">
                  <div class="w-12 rounded-full">
                    <% if (post.getAutore().getImmagineProfilo() != null && !post.getAutore().getImmagineProfilo().trim().isEmpty()) { %>
                      <img src="<%= "http://localhost:8080/" + "FreshAppImages/" + post.getAutore().getImmagineProfilo() %>" />
                    <% } else { %>
                      <img src="https://ui-avatars.com/api/?name=<%= post.getAutore().getUsername() %>" />
                    <% } %>
                  </div>
                </div>

                <div class="card-title flex justify-between w-full">
                  <div>
                    <h2>
                      <a href="<%= request.getContextPath() + "/getUserProfile?" + Constants.MAIL_KEY + "=" + post.getAutore().getEmail() %>">
                        <%= post.getAutore().getUsername() %>
                      </a>
                    </h2>
                    <p class="mb-4 text-xs">
                      <%= post.getDataPubblicazione().format(DateTimeFormatter.ofPattern("dd MMMM yyyy HH:mm:ss")) %>
                    </p>
                  </div>
                  
                  <% if (post.getAutore().equals(userLogged)) { %>

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
                    <ul tabindex="0" class="dropdown-content z-[1] menu p-2 shadow bg-base-100 rounded-box w-52">
                      <li>
                        <form action="<%= request.getContextPath() + "/modifyPost" %>" method="get">
                          <input type="hidden" name="<%= Constants.POST_TEXT_KEY %>" value="<%= post.getTesto() %>" />
                          <input type="hidden" name="<%= Constants.POST_ID_KEY %>" value="<%= post.getId() %>" />
                          <button type="submit">
                            <svg class="inline-block w-5 h-5 stroke-current hover:stroke-primary" viewBox="0 0 20 20">
                              <path fill="none"
                                d="M19.404,6.65l-5.998-5.996c-0.292-0.292-0.765-0.292-1.056,0l-2.22,2.22l-8.311,8.313l-0.003,0.001v0.003l-0.161,0.161c-0.114,0.112-0.187,0.258-0.21,0.417l-1.059,7.051c-0.035,0.233,0.044,0.47,0.21,0.639c0.143,0.14,0.333,0.219,0.528,0.219c0.038,0,0.073-0.003,0.111-0.009l7.054-1.055c0.158-0.025,0.306-0.098,0.417-0.211l8.478-8.476l2.22-2.22C19.695,7.414,19.695,6.941,19.404,6.65z M8.341,16.656l-0.989-0.99l7.258-7.258l0.989,0.99L8.341,16.656z M2.332,15.919l0.411-2.748l4.143,4.143l-2.748,0.41L2.332,15.919z M13.554,7.351L6.296,14.61l-0.849-0.848l7.259-7.258l0.423,0.424L13.554,7.351zM10.658,4.457l0.992,0.99l-7.259,7.258L3.4,11.715L10.658,4.457z M16.656,8.342l-1.517-1.517V6.823h-0.003l-0.951-0.951l-2.471-2.471l1.164-1.164l4.942,4.94L16.656,8.342z">
                              </path>
                            </svg>
                            <span>Modifica</span>
                          </button>
                        </form>
                      </li>
                      <li>
                        <a href="<%= request.getContextPath()  + "/deletePost?" + Constants.POST_ID_KEY + "=" + post.getId() %>">
                          <svg class="inline-block w-5 h-5 stroke-current hover:stroke-primary" viewBox="0 0 20 20">
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
              </div>

              <p>
                <%= post.getTesto() %>
              </p>

              <% if(post.getImmagine() != null && !post.getImmagine().trim().isEmpty()) { %>
                <% if (post.getImmagine().substring(post.getImmagine().length() - 3).equals("mp4")) { %> 
                  <video class="my-2 w-full rounded" controls>
                    <source src="<%= request.getContextPath() + "/images/" + post.getImmagine() %>" type="video/mp4" />
                  </video>
                <% } else { %> 
                  <img class="my-2 w-full rounded" src="<%= "http://localhost:8080/" + "FreshAppImages/" + post.getImmagine() %>" alt="<%= post.getImmagine() %>" />
                <% } %>
              <% } %>
              <div class="card-actions justify-around w-full items-center">
          

                <div class="flex items-center gap-1">
                    <% if (isLiked) { %>
                      <!-- <a id="remove-like"  onclick="decrementLike('<%=post.getId()%>')"><i class="fa-solid fa-heart text-info w-5 h-5"></i></a>
                      <a id="add-like" class="hidden hover:cursor-pointer" onclick="incrementLike('<%=post.getId()%>')" > <i class="fa-regular fa-heart text-info w-5 h-5"></i></a> -->
                      <a id="toggle-like-btn-<%= post.getId() %>" class="hover:cursor-pointer" onclick="toggleLike('<%= post.getId() %>', '<%= isOrderedByLikes %>', '<%= isOrderedByComments %>')">
                        <i id="heart-icon-<%= post.getId() %>" class="fa-solid fa-heart text-info w-5 h-5"></i>
                      </a>
                    <% } else { %>
                      <!-- <a id="remove-like" class="hidden hover:cursor-pointer" onclick="decrementLike('<%=post.getId()%>')"><i class="fa-solid fa-heart text-info w-5 h-5"></i></a>
                      <a id="add-like" onclick="incrementLike('<%=post.getId()%>')" > <i class="fa-regular fa-heart text-info w-5 h-5"></i></a> -->
                      <a id="toggle-like-btn-<%= post.getId() %>" class="hover:cursor-pointer" onclick="toggleLike('<%= post.getId() %>', '<%= isOrderedByLikes %>', '<%= isOrderedByComments %>')">
                        <i id="heart-icon-<%= post.getId() %>" class="fa-regular fa-heart text-info w-5 h-5"></i>
                      </a>
                    <% } %>
                  <span id="loading-like-btn-<%= post.getId() %>" class="loading loading-spinner loading-xs hidden"></span>
                  <a id="likes-counter-<%= post.getId() %>" class="text-xs hover:cursor-pointer" onclick="likes_modal_<%= post.getId() %>.showModal()">
                    <%= post.getLikes().size() %>
                  </a>
                  <dialog id="likes_modal_<%= post.getId() %>" class="modal">
                    <div class="modal-box p-4 pt-12">
                      <form method="dialog">
                        <button class="btn btn-sm btn-ghost absolute right-2 top-2">✕</button>
                      </form>
                      <ul>
                        <% 
                        if (post.getLikes() != null && post.getLikes().size() > 0) {
                            for (Utente liker: post.getLikes()) {
                        %>
                        <li class="mb-2 py-2 border-t border-neutral">
                          <div class="flex justify-between items-center">
                            <div class="avatar">
                              <div class="w-12 rounded-full">
                                <% if (liker.getImmagineProfilo() != null && !liker.getImmagineProfilo().trim().isEmpty()) { %>
                                  <img src="<%= "http://localhost:8080/" + "FreshAppImages/" + liker.getImmagineProfilo() %>" />
                                <% } else { %>
                                  <img src="https://ui-avatars.com/api/?name=<%= liker.getUsername() %>" />
                                <% } %>
                              </div>
                            </div>
                            <p>
                              <%= liker.getUsername() %>
                            </p>
                          </div>
                        </li>
                        <% 
                            }
                        }
                        %>
                      </ul>
                    </div>
                  </dialog>
                </div>
                <div class="flex items-center gap-1">

                  <% if (isDisliked) { %>

                    <a id="remove-dislike-btn-<%= post.getId() %>" class="hover:cursor-pointer" onclick="toggleDislike('<%= post.getId() %>', '<%= isOrderedByLikes %>', '<%= isOrderedByComments %>')">
                      <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-info" viewBox="0 0 24 24">
                        <path fill="currentColor"
                          d="m12 21.35l-1.45-1.32C5.4 15.36 2 12.27 2 8.5C2 5.41 4.42 3 7.5 3c.67 0 1.32.12 1.94.33L13 9.35l-4 5zM16.5 3C19.58 3 22 5.41 22 8.5c0 3.77-3.4 6.86-8.55 11.53L12 21.35l-1-7l4.5-5l-2.65-5.08C13.87 3.47 15.17 3 16.5 3" />
                      </svg>
                    </a>
                    <a id="add-dislike-btn-<%= post.getId() %>" onclick="toggleDislike('<%= post.getId() %>', '<%= isOrderedByLikes %>', '<%= isOrderedByComments %>')" class="hidden hover:cursor-pointer">
                      <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 stroke-info" viewBox="0 0 24 24"
                        stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round"
                        stroke-linejoin="round">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                        <path d="M19.5 13.572l-7.5 7.428l-7.5 -7.428a5 5 0 1 1 7.5 -6.566a5 5 0 1 1 7.5 6.572" />
                        <path d="M12 7l-2 4l4 3l-2 4v3" />
                      </svg>
                    </a>

                  <% } else { %>

                    <a id="remove-dislike-btn-<%= post.getId() %>" class="hidden hover:cursor-pointer" onclick="toggleDislike('<%= post.getId() %>', '<%= isOrderedByLikes %>', '<%= isOrderedByComments %>')">
                      <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 text-info" viewBox="0 0 24 24">
                        <path fill="currentColor"
                          d="m12 21.35l-1.45-1.32C5.4 15.36 2 12.27 2 8.5C2 5.41 4.42 3 7.5 3c.67 0 1.32.12 1.94.33L13 9.35l-4 5zM16.5 3C19.58 3 22 5.41 22 8.5c0 3.77-3.4 6.86-8.55 11.53L12 21.35l-1-7l4.5-5l-2.65-5.08C13.87 3.47 15.17 3 16.5 3" />
                      </svg>
                    </a>
                    <a id="add-dislike-btn-<%= post.getId() %>" class="hover:cursor-pointer" onclick="toggleDislike('<%= post.getId() %>', '<%= isOrderedByLikes %>', '<%= isOrderedByComments %>')">
                      <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5 stroke-info" viewBox="0 0 24 24"
                        stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round"
                        stroke-linejoin="round">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                        <path d="M19.5 13.572l-7.5 7.428l-7.5 -7.428a5 5 0 1 1 7.5 -6.566a5 5 0 1 1 7.5 6.572" />
                        <path d="M12 7l-2 4l4 3l-2 4v3" />
                      </svg>
                    </a>

                  <% } %>

                  <span id="loading-dislike-btn-<%= post.getId() %>" class="loading loading-spinner loading-xs hidden"></span>
                  <a id="dislikes-counter-<%= post.getId() %>" class="text-xs hover:cursor-pointer" onclick="dislikes_modal_<%= post.getId() %>.showModal()">
                    <%= post.getDislikes().size() %>
                  </a>
                  <dialog id="dislikes_modal_<%= post.getId() %>" class="modal">
                    <div class="modal-box p-4 pt-12">
                      <form method="dialog">
                        <button class="btn btn-sm btn-ghost absolute right-2 top-2">✕</button>
                      </form>
                      <ul>
                        <% 
                        if (post.getDislikes() != null && post.getDislikes().size() > 0) {
                            for (Utente disliker: post.getDislikes()) {
                        %>
                        <li class="mb-2 py-2 border-t border-neutral">
                          <div class="flex justify-between items-center">
                            <div class="avatar">
                              <div class="w-12 rounded-full">
                                <% if (disliker.getImmagineProfilo() != null && !disliker.getImmagineProfilo().trim().isEmpty()) { %>
                                  <img src="<%= "http://localhost:8080/" + "FreshAppImages/" + disliker.getImmagineProfilo() %>" />
                                <% } else { %>
                                  <img src="https://ui-avatars.com/api/?name=<%= disliker.getUsername() %>" />
                                <% } %>
                              </div>
                            </div>
                            <p>
                              <%= disliker.getUsername() %>
                            </p>
                          </div>
                        </li>
                        <% 
                            }
                        }
                        %>
                      </ul>
                    </div>
                  </dialog>
                </div>
                <a href="<%= request.getContextPath() + "/readPostComments?" + Constants.POST_ID_KEY + "=" + post.getId() %>" class="flex items-center gap-1">
                  <button class=""><i class="fa-regular fa-comment text-info"></i></button>
                  <span class="text-xs">
                    <%= post.getCommenti().size() %>
                  </span>
                </a>
              </div>

            </div>
          </div>