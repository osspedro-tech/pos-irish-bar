<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Outro.model.JavaBeans"%>
<%@ page import="java.util.ArrayList"%>
<% ArrayList<JavaBeans> lista = (ArrayList<JavaBeans>) request.getAttribute("produtos"); %>
<% System.out.println("Lista no JSP: " + (lista != null ? lista.size() : "null")); %>

<!DOCTYPE html>
<html lang="pt-pt">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FALTAS</title>
    <link rel="icon" href="images/favicon.jpg">
    <link rel="stylesheet" href="style.css">
    <style>
        .fullscreen-container {
            min-height: 100vh;
            background: linear-gradient(135deg, #006B3F 0%, #009B4D 100%);
            padding: 20px;
        }

        .title {
            color: white;
            font-size: 48px;
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .content-container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .big-button {
            display: inline-block;
            text-decoration: none;
            background: white;
            color: #009B4D;
            padding: 12px 20px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            transition: transform 0.3s, box-shadow 0.3s;
            border: none;
            cursor: pointer;
            margin: 5px;
        }

        .big-button:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.3);
        }

        .big-button-red {
            background: #d51213;
            color: white;
            padding: 8px 15px;
            font-size: 14px;
        }

        #tabela {
            margin-top: 30px;
            border-collapse: collapse;
            width: 100%;
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }

        #tabela th {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
            background-color: #667eea;
            color: white;
            font-size: 16px;
        }

        #tabela td {
            border: 1px solid #ddd;
            padding: 10px;
            font-size: 16px;
            vertical-align: middle;
        }

        #tabela img {
            max-width: 150px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
        }

        @media (max-width: 768px) {
            .title {
                font-size: 36px;
                margin-bottom: 25px;
            }

            .big-button {
                padding: 25px 20px;
                font-size: 24px;
                width: 100%;
                margin: 10px 0;
                box-sizing: border-box;
            }

            #tabela {
                display: none;
            }

            .mobile-cards {
                display: flex !important;
                flex-direction: column;
                gap: 20px;
            }

            .product-card {
                background: white;
                border-radius: 15px;
                padding: 15px;
                box-shadow: 0 8px 16px rgba(0,0,0,0.2);
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .product-card img {
                max-width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 10px;
                margin-bottom: 10px;
            }

            .product-card h3 {
                margin: 0 0 5px 0;
                font-size: 20px;
                color: #667eea;
                text-align: center;
            }

            .product-card p {
                margin: 2px 0;
                font-size: 14px;
                text-align: center;
            }

            .product-card .status {
                font-weight: bold;
                padding: 5px;
                border-radius: 8px;
                text-align: center;
                margin: 10px 0;
                font-size: 14px;
            }

            .product-card .status.pendente {
                background: #ff6b6b;
                color: white;
            }

            .product-card .status.concluido {
                background: #4ecdc4;
                color: white;
            }

            .product-card .buttons {
                display: flex;
                flex-direction: column;
                gap: 10px;
                margin-top: 15px;
            }

            .product-card .buttons a {
                width: 100%;
                box-sizing: border-box;
            }
        }
    </style>
</head>
<body>
    <div class="fullscreen-container">
        <h1 class="title">FALTAS</h1>
        <div class="content-container">
            <div style="text-align: center; margin-bottom: 15px;">
                <a href="novo.html" class="big-button">➕ Nova Falta</a>
                <label style="margin-left: 15px; color: white; font-weight: bold; font-size: 18px; cursor: pointer;">
                    <input type="checkbox" id="chkSemSom" checked style="width: 20px; height: 20px; vertical-align: middle;"> Sem som
                </label>
            </div>
            <table id="tabela">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Descrição</th>
                        <th>Foto</th>
                        <th>Tempo</th>
                        <th>Opções</th>
                    </tr>
                </thead>
                <tbody>
                <%if (lista != null) {
                    for (int i = 0; i < lista.size(); i++){%>
                    <tr>
                        <td><%=lista.get(i).getNome()%></td>
                        <td><%=lista.get(i).getDescricao()%></td>
                        <td>
                            <% if(lista.get(i).getFoto() != null && !lista.get(i).getFoto().isEmpty()) { %>
                                <img src="<%=lista.get(i).getFoto()%>"/>
                            <% } %>
                        </td>
                        <td class="time-counter" data-timestamp="<%=lista.get(i).getDataCriacao() != null ? lista.get(i).getDataCriacao().getTime() : ""%>">Carregando...</td>
                        <td>
                            <a href="javascript: confirmar(<%=lista.get(i).getId() %>)" class="big-button big-button-red">Eliminar</a>
                        </td>
                    </tr>
                <%  }
                }%>
                </tbody>
            </table>

            <!-- Mobile Cards -->
            <div class="mobile-cards" style="display:none;">
                <%if (lista != null) {
                    for (int i = 0; i < lista.size(); i++){%>
                    <div class="product-card">
                        <% if(lista.get(i).getFoto() != null && !lista.get(i).getFoto().isEmpty()) { %>
                            <img src="<%=lista.get(i).getFoto()%>"/>
                        <% } %>
                        <h3><%=lista.get(i).getNome()%></h3>
                        <p><%=lista.get(i).getDescricao()%></p>
                        <div class="time-counter" data-timestamp="<%=lista.get(i).getDataCriacao() != null ? lista.get(i).getDataCriacao().getTime() : ""%>" style="font-weight:bold; padding:10px; border-radius:8px; text-align:center; margin:15px 0; background:white; color:#006B3F;">Carregando...</div>
                        <div class="buttons">
                            <a href="javascript: confirmar(<%=lista.get(i).getId() %>)" class="big-button big-button-red">Eliminar</a>
                        </div>
                    </div>
                <%  }
                }%>
            </div>
        </div>
    </div>
<script src="scripts/confirmador.js"></script>
<script>
    function updateTimeCounters() {
        var counters = document.querySelectorAll('.time-counter');
        var now = new Date().getTime();

        counters.forEach(function(counter) {
            var timestamp = counter.getAttribute('data-timestamp');
            if (timestamp) {
                var diff = now - timestamp;
                var minutes = Math.floor(diff / (1000 * 60));
                var seconds = Math.floor((diff % (1000 * 60)) / 1000);

                counter.textContent = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
            }
        });
    }

    updateTimeCounters();
    setInterval(updateTimeCounters, 1000);

    // Carrega e grava a opção do som no telemóvel
    document.addEventListener("DOMContentLoaded", function() {
        var chkSemSom = document.getElementById("chkSemSom");
        if (chkSemSom) {
            var estadoGuardado = localStorage.getItem("agenda_sem_som");

            if (estadoGuardado !== null) {
                chkSemSom.checked = (estadoGuardado === "true");
            }

            chkSemSom.addEventListener("change", function() {
                localStorage.setItem("agenda_sem_som", this.checked);
            });
        }

        tocarSomNovoProduto();
    });

    function tocarSomNovoProduto() {
        var semSom = document.getElementById("chkSemSom");
        if (semSom && !semSom.checked) {
            var audioCtx = new (window.AudioContext || window.webkitAudioContext)();
            var osc = audioCtx.createOscillator();
            osc.type = "sine";
            osc.frequency.setValueAtTime(880, audioCtx.currentTime);
            osc.connect(audioCtx.destination);
            osc.start();
            osc.stop(audioCtx.currentTime + 0.15);
        }
    }
</script>
</body>
</html>