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
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 20px;
        }

        .sound-toggle {
            display: flex;
            align-items: center;
            cursor: pointer;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            width: 50px;
            height: 50px;
            justify-content: center;
            transition: background 0.3s;
        }

        .sound-toggle:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .sound-icon {
            font-size: 28px;
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
            padding: 8px;
            font-size: 16px;
            vertical-align: middle;
        }

        #tabela img {
            max-width: 120px;
            height: 80px;
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
        <h1 class="title">
            FALTAS
            <div class="sound-toggle" id="soundToggle">
                <span class="sound-icon" id="soundIcon">🔊</span>
            </div>
        </h1>
        <div class="content-container">
            <div style="text-align: center; margin-bottom: 15px;">
                <a href="novo.html" class="big-button">➕ Nova Falta</a>
            </div>
            <table id="tabela">
                <thead>
                    <tr>
                        <th>Foto</th>
                        <th>Nome</th>
                        <th>Tempo</th>
                        <th>Opções</th>
                    </tr>
                </thead>
                <tbody>
                <%if (lista != null) {
                    for (int i = 0; i < lista.size(); i++){%>
                    <tr id="row-<%=lista.get(i).getId()%>">
                        <td>
                            <% if(lista.get(i).getFoto() != null && !lista.get(i).getFoto().isEmpty()) { %>
                                <img src="<%=lista.get(i).getFoto()%>"/>
                            <% } %>
                        </td>
                        <td><%=lista.get(i).getNome()%></td>
                        <td class="time-counter" data-timestamp="<%=lista.get(i).getDataCriacao() != null ? lista.get(i).getDataCriacao().getTime() : ""%>">Carregando...</td>
                        <td>
                            <a href="javascript: marcarEliminar(<%=lista.get(i).getId() %>)" class="big-button big-button-red" id="btn-eliminar-<%=lista.get(i).getId()%>">Eliminar</a>
                            <a href="javascript: cancelarEliminar(<%=lista.get(i).getId() %>)" class="big-button" id="btn-cancelar-<%=lista.get(i).getId()%>" style="display: none; background: #666; color: white;">Cancelar</a>
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
                    <div class="product-card" id="card-<%=lista.get(i).getId()%>">
                        <% if(lista.get(i).getFoto() != null && !lista.get(i).getFoto().isEmpty()) { %>
                            <img src="<%=lista.get(i).getFoto()%>"/>
                        <% } %>
                        <h3><%=lista.get(i).getNome()%></h3>
                        <div class="time-counter" data-timestamp="<%=lista.get(i).getDataCriacao() != null ? lista.get(i).getDataCriacao().getTime() : ""%>" style="font-weight:bold; padding:5px; border-radius:8px; text-align:center; margin:5px 0; background:white; color:#006B3F;">Carregando...</div>
                        <div class="buttons">
                            <a href="javascript: marcarEliminarMobile(<%=lista.get(i).getId() %>)" class="big-button big-button-red" id="btn-eliminar-mobile-<%=lista.get(i).getId()%>">Eliminar</a>
                            <a href="javascript: cancelarEliminarMobile(<%=lista.get(i).getId() %>)" class="big-button" id="btn-cancelar-mobile-<%=lista.get(i).getId()%>" style="display: none; background: #666; color: white;">Cancelar</a>
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
                var seconds = Math.floor((diff / 1000) % 60);
                var minutes = Math.floor((diff / (1000 * 60)) % 60);
                var hours = Math.floor((diff / (1000 * 60 * 60)) % 24);
                var days = Math.floor(diff / (1000 * 60 * 60 * 24));

                var timeText = '';
                if (days > 0) {
                    timeText = days + 'd ' + hours + 'h ' + minutes + 'm';
                } else if (hours > 0) {
                    timeText = hours + 'h ' + minutes + 'm ' + seconds + 's';
                } else {
                    timeText = minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
                }

                counter.textContent = timeText;
            }
        });
    }

    updateTimeCounters();
    setInterval(updateTimeCounters, 1000);

    // Auto-refresh da lista de produtos a cada 5 segundos
    function atualizarLista() {
        fetch('main')
            .then(response => response.text())
            .then(html => {
                // Parse the HTML response to extract the table rows
                var parser = new DOMParser();
                var doc = parser.parseFromString(html, 'text/html');
                var newTableBody = doc.querySelector('#tabela tbody');
                var currentTableBody = document.querySelector('#tabela tbody');

                if (newTableBody && currentTableBody) {
                    currentTableBody.innerHTML = newTableBody.innerHTML;
                    // Reattach event listeners to the new buttons
                    reattachEventListeners();
                }

                // Also update mobile cards
                var newMobileCards = doc.querySelector('.mobile-cards');
                var currentMobileCards = document.querySelector('.mobile-cards');
                if (newMobileCards && currentMobileCards) {
                    currentMobileCards.innerHTML = newMobileCards.innerHTML;
                }
            })
            .catch(error => console.error('Erro ao atualizar lista:', error));
    }

    function reattachEventListeners() {
        // Re-initialize time counters for new elements
        updateTimeCounters();
    }

    // Atualizar a cada 5 segundos
    setInterval(atualizarLista, 5000);

    // Carrega e grava a opção do som no telemóvel
    document.addEventListener("DOMContentLoaded", function() {
        var soundToggle = document.getElementById("soundToggle");
        var soundIcon = document.getElementById("soundIcon");

        if (soundToggle && soundIcon) {
            // Always start with sound OFF by default
            var semSom = true;
            soundIcon.textContent = "🔇";

            soundToggle.addEventListener("click", function() {
                semSom = !semSom;
                localStorage.setItem("agenda_sem_som", semSom);
                soundIcon.textContent = semSom ? "🔇" : "🔊";
            });
        }

        tocarSomNovoProduto();
    });

    function tocarSomNovoProduto() {
        var estadoGuardado = localStorage.getItem("agenda_sem_som");
        var semSom = estadoGuardado === "true";
        if (!semSom) {
            var audioCtx = new (window.AudioContext || window.webkitAudioContext)();
            var osc = audioCtx.createOscillator();
            osc.type = "sine";
            osc.frequency.setValueAtTime(880, audioCtx.currentTime);
            osc.connect(audioCtx.destination);
            osc.start();
            osc.stop(audioCtx.currentTime + 0.15);
        }
    }

    function marcarEliminar(id) {
        var row = document.getElementById('row-' + id);
        var btnEliminar = document.getElementById('btn-eliminar-' + id);
        var btnCancelar = document.getElementById('btn-cancelar-' + id);

        row.style.textDecoration = 'line-through';
        row.style.opacity = '0.5';
        btnEliminar.style.display = 'none';
        btnCancelar.style.display = 'inline-block';
    }

    function cancelarEliminar(id) {
        var row = document.getElementById('row-' + id);
        var btnEliminar = document.getElementById('btn-eliminar-' + id);
        var btnCancelar = document.getElementById('btn-cancelar-' + id);

        row.style.textDecoration = 'none';
        row.style.opacity = '1';
        btnEliminar.style.display = 'inline-block';
        btnCancelar.style.display = 'none';
    }

    function confirmar(id) {
        // Check if row is marked for deletion
        var row = document.getElementById('row-' + id);
        if (row.style.textDecoration === 'line-through') {
            // Proceed with actual deletion
            window.location.href = 'delete?id=' + id;
        } else {
            // First phase - mark for deletion
            marcarEliminar(id);
        }
    }

    function marcarEliminarMobile(id) {
        var card = document.getElementById('card-' + id);
        var btnEliminar = document.getElementById('btn-eliminar-mobile-' + id);
        var btnCancelar = document.getElementById('btn-cancelar-mobile-' + id);

        card.style.textDecoration = 'line-through';
        card.style.opacity = '0.5';
        btnEliminar.style.display = 'none';
        btnCancelar.style.display = 'inline-block';
    }

    function cancelarEliminarMobile(id) {
        var card = document.getElementById('card-' + id);
        var btnEliminar = document.getElementById('btn-eliminar-mobile-' + id);
        var btnCancelar = document.getElementById('btn-cancelar-mobile-' + id);

        card.style.textDecoration = 'none';
        card.style.opacity = '1';
        btnEliminar.style.display = 'inline-block';
        btnCancelar.style.display = 'none';
    }
</script>
</body>
</html>