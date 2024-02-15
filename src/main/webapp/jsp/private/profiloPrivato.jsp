<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.fresh.FreshApp.utils.Constants" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.fresh.FreshApp.model.Post" %>
<%@ page import="com.fresh.FreshApp.model.Commento" %>
<%@ page import="com.fresh.FreshApp.model.Utente" %>

<!DOCTYPE html>
    <html>
        <head>
            <meta charset="ISO-8859-1">
            <title>Profilo Privato</title>         
            <link href="https://cdn.jsdelivr.net/npm/daisyui@4.6.0/dist/full.min.css" rel="stylesheet" type="text/css" />
            <script src="https://cdn.tailwindcss.com"></script>
            <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        </head>
        
        
        <body>

            <% 
                Utente utenteCorrente = (Utente) request.getSession().getAttribute(Constants.USER_DATA_KEY); 
                List<Post> postUtenteCorrente = utenteCorrente.getPosts(); 
            %>



            <!--Rimozione utente dal sito-->
            <form action="<%= request.getContextPath()%>/signout" method="post">
                <p>Rimuovi il tuo account cliccando qui sotto.</p>
                <br>
                <input type="hidden" name="<%= Constants.USER_ID_KEY %>" value="<%= session.getAttribute(Constants.USER_ID_KEY) %>" />
                <button type="submit">Rimuovi account</button>
            </form> 
            <br>

       
            <!--Creazione post con testo-->
            <form action="<%= request.getContextPath() %>/createImgPost" method="post" enctype="multipart/form-data">
                <p>Crea post:</p>
                <input type="text" placeholder="post" name="<%= Constants.CREATE_POST_KEY %>" />
                <input type="file" name ="<%=Constants.ADD_IMG_KEY%>"/>
                <button type="submit">Pubblica</button>
            </form> <br>

            <!--Pubblicazione post con testo e altri dettagli-->
            <div>
                <% 
                    if (postUtenteCorrente != null && postUtenteCorrente.size() > 0) {
                        for(Post post : postUtenteCorrente) {
                %>
                <div>
                    
                    <p>DataPubblicazione:<%= post.getDataPubblicazione()%></p>
                    <p><%= post.getTesto() %></p>
                    <%
                        if((!(post.getImmagine().trim().equals("")) && post.getImmagine() !=null )){
                            
                        }
                    %>
                    <img src="<%= request.getContextPath() %>/images/<%=post.getImmagine()%>" alt="aia, problemino" style="width: 20px; height: 20px;">
                    <br>
                    
                    <div>
                        <!--Modifica post--> 
                        <% if(utenteCorrente != null && post.getAutore() != null && utenteCorrente.getId().equals(post.getAutore().getId())) { %>
                        <input type="button" class="btn" value="Modifica" onclick="mostraTextarea('<%=post.getId()%>')"/> 
                        <form id="modifyForm_<%=post.getId()%>" action="<%=request.getContextPath()%>/modifyPost" method="post" style="display: none;">
                            <div>
                                <input type="hidden" name="<%= Constants.POST_ID_KEY %>" value="<%= post.getId() %>"/>
                                <textarea name="<%= Constants.MODIFY_POST_KEY %>">
                                    <%= post.getTesto() %>
                                </textarea>
                                <input type="submit" value="Salva"/>
                            </div>
                        </form>
                         <!--Elimina post-->
                        
                         <form action="<%=request.getContextPath()%>/deletePost" method="post">
                            <div>
                                <input type="hidden" name="<%=Constants.POST_ID_KEY%>" value="<%=post.getId()%>"/>
                                <input type="submit" class="btn" value="Elimina post"/>
                            </div>
                        </form>
                        <% } %>
                        <script>
                            function mostraTextarea(postId){
                                var modificaStile = document.getElementById('modifyForm_' + postId);
                                if(modificaStile){
                                    modificaStile.style.display = 'block';
                                }

                            }

                        </script>
                        

                    <!--Pubblica commento sotto al post-->
                    <form action="<%= request.getContextPath() %>/createComment" method="post">
                        <textarea name="<%=Constants.COMMENT_TEXT_KEY%>" placeholder="Aggiungi un commento"></textarea>
                        <input type="hidden" name="<%= Constants.POST_ID_KEY %>" value=<%= post.getId() %> />       
                        <input type="submit" value="invia" />
                    </form>

                    <!--Leggere tutti i commenti sotto al post-->
                    <div>
                       <%
                            if (post.getCommenti() != null && post.getCommenti().size() > 0) {
                                for (Commento commento : post.getCommenti()) {
                       %>
                            <div>
                                <p>Autore:<%= commento.getAutore().getUsername() %></p>
                                <p>DataPubblicazione:<%= post.getDataPubblicazione() %></p>
                                <p><%= commento.getTesto() %></p>
                            </div>
                        <% } } else { %>
                            <p>Non ci sono commenti</p>
                        <% } %>
                    </div>
                </div>
                <% } } else { %>
                    <p>Nessun post pubblicato</p>
                <% } %>
            </div>

            <!--Barra di ricerca-->
            <div class="navbar bg-base-100">
                <div class="flex-1">
                  <a class="btn btn-ghost text-xl">daisyUI</a>
                </div>
                <div class="flex-none gap-2">
                  <div class="form-control">
                    <input type="text" placeholder="Search" class="input input-bordered w-24 md:w-auto" />
                  </div>
                  <div class="dropdown dropdown-end">
                    <div tabindex="0" role="button" class="btn btn-ghost btn-circle avatar">
                      <div class="w-10 rounded-full">
                        <img alt="Tailwind CSS Navbar component" src="https://daisyui.com/images/stock/photo-1534528741775-53994a69daeb.jpg" />
                      </div>
                    </div>
                    <ul tabindex="0" class="mt-3 z-[1] p-2 shadow menu menu-sm dropdown-content bg-base-100 rounded-box w-52">
                      <li>
                        <a class="justify-between">
                            <form action="<%= request.getContextPath() %>/readAllPosts" method="post">
                                <button type="submit">home</button>
                            </form>
                        </a>
                      </li>
                      <li><a>Settings</a></li>
                      <li><form action="<%= request.getContextPath() %>/logout" method="post">
                        <button type="submit">logout</button>
                    </form></li>
                    </ul>
                  </div>
                </div>
              </div>
            
            

        
        
        </body>

</html>