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

            <h1>Risultati Ricerca</h1>

            <%
               List<Utente> utentiTrovati = (List<Utente>) request.getAttribute(Constants.PROFILES_FOUND);
                if(utentiTrovati != null && !utentiTrovati.isEmpty()) {
                    for(Utente utente : utentiTrovati) {
            %>  
                <p><%= utente.getUsername() %></p>
                <form action="<%= request.getContextPath() %>/profiloCercato" method="post">
                    <input type="hidden" name="<%=Constants.PROFILES_FOUND%>" value="utente.getUsername()"/>
                    <button type="submit">Visualizza Profilo</button>
                </form>

            <%
                    }
                } else {
            %>
                <p>Nessun risultato trovato.</p>
            <%
                }
            %>

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
                      <li>
                        <a class="justify-between">
                            <form action="<%= request.getContextPath() %>/privateProfile" method="post">
                                <button type="submit">profilo privato</button>
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