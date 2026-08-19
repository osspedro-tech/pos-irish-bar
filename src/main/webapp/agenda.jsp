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

        .vibration-toggle {
            display: flex;
            align-items: center;
            cursor: pointer;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            width: 50px;
            height: 50px;
            justify-content: center;
            transition: background 0.3s;
            margin-left: 10px;
        }

        .vibration-toggle:hover {
            background: rgba(255, 255, 255, 0.3);
        }

        .vibration-icon {
            font-size: 28px;
        }

        .no-photo .photo-cell {
            display: none;
        }

        .no-photo td:first-child {
            display: none;
        }

        .no-photo td {
            padding: 4px !important;
            vertical-align: middle !important;
        }

        .no-photo .big-button {
            padding: 8px 12px !important;
            font-size: 14px !important;
        }

        .product-card.no-photo img {
            display: none;
        }

        .product-card.no-photo {
            padding: 5px;
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 10px;
        }

        .product-card.no-photo h3 {
            margin: 0;
            flex: 1;
            font-size: 16px;
        }

        .product-card.no-photo .time-counter {
            margin: 0;
            padding: 3px 8px !important;
            font-size: 14px !important;
        }

        .product-card.no-photo .buttons {
            margin: 0;
        }

        .product-card.no-photo .big-button {
            padding: 8px 12px !important;
            font-size: 14px !important;
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
            font-size: 22px;
            vertical-align: middle;
        }

        #tabela img {
            max-width: 120px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            cursor: pointer;
            transition: transform 0.2s;
        }

        #tabela img:hover {
            transform: scale(1.1);
        }

        .fullscreen-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.9);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            cursor: pointer;
        }

        .fullscreen-overlay img {
            max-width: 90%;
            max-height: 90%;
            object-fit: contain;
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
                flex-direction: row;
                align-items: center;
                gap: 15px;
                justify-content: space-between;
            }

            .product-card img {
                max-width: 60px;
                height: 45px;
                object-fit: cover;
                border-radius: 8px;
                margin: 0;
            }

            .product-card h3 {
                margin: 0;
                font-size: 24px;
                color: #667eea;
                flex: 2;
            }

            .product-card p {
                margin: 0;
                font-size: 12px;
            }

            .product-card .status {
                font-weight: bold;
                padding: 3px 8px;
                border-radius: 6px;
                font-size: 12px;
            }

            .product-card .time-counter {
                font-size: 14px !important;
                padding: 4px 10px !important;
                margin: 0 !important;
            }

            .product-card .buttons {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            .product-card .buttons a {
                padding: 8px 15px !important;
                font-size: 14px !important;
            }

            .photo-indicator {
                font-size: 20px;
                cursor: pointer;
                padding: 5px;
                background: rgba(102, 126, 234, 0.1);
                border-radius: 50%;
                transition: background 0.2s;
            }

            .photo-indicator:hover {
                background: rgba(102, 126, 234, 0.3);
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
            <div class="vibration-toggle" id="vibrationToggle">
                <span class="vibration-icon" id="vibrationIcon">📳</span>
            </div>
        </h1>
        
        <!-- Settings Modal -->
        <div id="settingsModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); z-index:10000; justify-content:center; align-items:center;">
            <div style="background:white; padding:30px; border-radius:15px; max-width:400px; width:90%;">
                <h2 style="margin:0 0 20px 0; color:#006B3F;">Configurações</h2>
                
                <div style="margin-bottom:20px;">
                    <h3 style="margin:0 0 10px 0; color:#667eea;">Tipo de Som</h3>
                    <select id="soundType" style="width:100%; padding:10px; font-size:16px; border-radius:8px; border:1px solid #ddd;">
                        <option value="880">Agudo (880Hz)</option>
                        <option value="440">Médio (440Hz)</option>
                        <option value="220">Grave (220Hz)</option>
                        <option value="1000">Muito Agudo (1000Hz)</option>
                    </select>
                </div>
                
                <div style="margin-bottom:20px;">
                    <h3 style="margin:0 0 10px 0; color:#667eea;">Tempo de Vibração (ms)</h3>
                    <input type="range" id="vibrationDuration" min="100" max="1000" value="200" style="width:100%;">
                    <div style="text-align:center; margin-top:5px; color:#666;"><span id="vibrationValue">200</span>ms</div>
                </div>
                
                <div style="margin-bottom:20px;">
                    <h3 style="margin:0 0 10px 0; color:#667eea;">Vibração Periódica</h3>
                    <label style="display:flex; align-items:center; gap:10px; margin-bottom:10px;">
                        <input type="checkbox" id="periodicVibration" style="width:20px; height:20px;">
                        <span style="font-size:16px;">Ativar vibração periódica</span>
                    </label>
                    <div id="periodicIntervalContainer" style="display:none;">
                        <label style="font-size:14px; color:#666;">Intervalo (segundos):</label>
                        <input type="range" id="periodicInterval" min="5" max="60" value="10" style="width:100%;">
                        <div style="text-align:center; margin-top:5px; color:#666;"><span id="periodicIntervalValue">10</span>s</div>
                    </div>
                </div>
                
                <button onclick="closeSettingsModal()" style="width:100%; padding:15px; background:#006B3F; color:white; border:none; border-radius:10px; font-size:18px; cursor:pointer;">Fechar</button>
            </div>
        </div>
        
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
                    <tr id="row-<%=lista.get(i).getId()%>" class="<%= (lista.get(i).getFoto() != null && !lista.get(i).getFoto().isEmpty()) ? "" : "no-photo" %>">
                        <td class="photo-cell">
                            <% if(lista.get(i).getFoto() != null && !lista.get(i).getFoto().isEmpty()) { %>
                                <img src="<%=lista.get(i).getFoto()%>" onclick="openFullscreen('<%=lista.get(i).getFoto()%>')"/>
                            <% } %>
                        </td>
                        <td><%=lista.get(i).getNome()%></td>
                        <td class="time-counter" data-timestamp="<%=lista.get(i).getDataCriacao() != null ? lista.get(i).getDataCriacao().getTime() : ""%>">Carregando...</td>
                        <td>
                            <a href="javascript: confirmar(<%=lista.get(i).getId() %>)" class="big-button big-button-red" id="btn-eliminar-<%=lista.get(i).getId()%>" style="padding: 8px 15px; font-size: 18px;">X</a>
                            <a href="javascript: cancelarEliminar(<%=lista.get(i).getId() %>)" class="big-button" id="btn-cancelar-<%=lista.get(i).getId()%>" style="display: none; background: #666; color: white; padding: 8px 15px; font-size: 18px;">Cancelar</a>
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
                    <div class="product-card <%= (lista.get(i).getFoto() != null && !lista.get(i).getFoto().isEmpty()) ? "" : "no-photo" %>" id="card-<%=lista.get(i).getId()%>">
                        <h3><%=lista.get(i).getNome()%></h3>
                        <% if(lista.get(i).getFoto() != null && !lista.get(i).getFoto().isEmpty()) { %>
                            <img src="<%=lista.get(i).getFoto()%>" onclick="openFullscreen('<%=lista.get(i).getFoto()%>')"/>
                        <% } %>
                        <div class="time-counter" data-timestamp="<%=lista.get(i).getDataCriacao() != null ? lista.get(i).getDataCriacao().getTime() : ""%>" style="font-weight:bold; padding:5px; border-radius:8px; text-align:center; margin:5px 0; background:white; color:#006B3F;">Carregando...</div>
                        <div class="buttons">
                            <a href="javascript: confirmarMobile(<%=lista.get(i).getId() %>)" class="big-button big-button-red" id="btn-eliminar-mobile-<%=lista.get(i).getId()%>" style="padding: 8px 15px; font-size: 18px;">X</a>
                            <a href="javascript: cancelarEliminarMobile(<%=lista.get(i).getId() %>)" class="big-button" id="btn-cancelar-mobile-<%=lista.get(i).getId()%>" style="display: none; background: #666; color: white; padding: 8px 15px; font-size: 18px;">Cancelar</a>
                        </div>
                    </div>
                <%  }
                }%>
            </div>
        </div>
    </div>
    <div class="fullscreen-overlay" id="fullscreenOverlay" onclick="closeFullscreen()">
        <img id="fullscreenImage" src="">
    </div>
<script src="scripts/confirmador.js"></script>
<script>
    function updateTimeCounters() {
        var counters = document.querySelectorAll('.time-counter');
        var now = new Date().getTime();

        counters.forEach(function(counter) {
            var timestamp = counter.getAttribute('data-timestamp');
            if (timestamp && timestamp !== '') {
                var diff = now - parseInt(timestamp);
                var seconds = Math.floor((diff / 1000) % 60);
                var minutes = Math.floor((diff / (1000 * 60)) % 60);
                var hours = Math.floor((diff / (1000 * 60 * 60)) % 24);
                var days = Math.floor(diff / (1000 * 60 * 60 * 24));

                var timeText = '';
                if (days > 0) {
                    timeText = days + 'd ' + hours + 'h';
                } else if (hours > 0) {
                    timeText = hours + 'h ' + minutes + 'm';
                } else if (minutes >= 1) {
                    timeText = minutes + 'm';
                } else {
                    timeText = seconds + 's';
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
                    // Check if there are new items
                    var currentRows = currentTableBody.querySelectorAll('tr');
                    var newRows = newTableBody.querySelectorAll('tr');

                    if (newRows.length !== currentRows.length) {
                        // Only update if number of items changed
                        currentTableBody.innerHTML = newTableBody.innerHTML;
                        // Reattach event listeners to the new buttons
                        reattachEventListeners();
                        // Play sound and vibrate ONLY if new items added (not removed)
                        if (newRows.length > currentRows.length) {
                            tocarSomNovoProduto();
                            vibrarNovoProduto();
                        }
                    }
                }

                // Also update mobile cards
                var newMobileCards = doc.querySelector('.mobile-cards');
                var currentMobileCards = document.querySelector('.mobile-cards');
                if (newMobileCards && currentMobileCards) {
                    var currentCards = currentMobileCards.querySelectorAll('.product-card');
                    var newCards = newMobileCards.querySelectorAll('.product-card');

                    if (newCards.length !== currentCards.length) {
                        currentMobileCards.innerHTML = newMobileCards.innerHTML;
                        // Play sound and vibrate ONLY if new items added (not removed)
                        if (newCards.length > currentCards.length) {
                            tocarSomNovoProduto();
                            vibrarNovoProduto();
                        }
                    }
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
        var vibrationToggle = document.getElementById("vibrationToggle");
        var vibrationIcon = document.getElementById("vibrationIcon");

        // Request notification permission for background sound
        if ("Notification" in window && Notification.permission === "default") {
            Notification.requestPermission();
        }

        if (soundToggle && soundIcon) {
            // Check localStorage for saved state, default to ON (false = com som)
            var estadoGuardado = localStorage.getItem("agenda_som_on");
            var somOn = (estadoGuardado !== "false"); // Default to ON

            // Update icon based on state
            soundIcon.textContent = somOn ? "🔊" : "🔇";

            // Load saved sound type
            var soundType = localStorage.getItem("agenda_sound_type") || "880";
            document.getElementById("soundType").value = soundType;

            // Long-press detection
            var pressTimer;
            soundToggle.addEventListener("mousedown", function() {
                pressTimer = setTimeout(function() {
                    openSettingsModal();
                }, 1000);
            });
            soundToggle.addEventListener("touchstart", function() {
                pressTimer = setTimeout(function() {
                    openSettingsModal();
                }, 1000);
            });
            soundToggle.addEventListener("mouseup", function() {
                clearTimeout(pressTimer);
            });
            soundToggle.addEventListener("mouseleave", function() {
                clearTimeout(pressTimer);
            });
            soundToggle.addEventListener("touchend", function() {
                clearTimeout(pressTimer);
            });

            soundToggle.addEventListener("click", function(e) {
                if (pressTimer) {
                    clearTimeout(pressTimer);
                    pressTimer = null;
                }
                somOn = !somOn;
                localStorage.setItem("agenda_som_on", somOn);
                soundIcon.textContent = somOn ? "🔊" : "🔇";
                
                // Request notification permission when enabling sound
                if (somOn && "Notification" in window && Notification.permission === "default") {
                    Notification.requestPermission();
                }
            });
        }

        if (vibrationToggle && vibrationIcon) {
            // Check localStorage for saved state, default to OFF (true = sem vibracao)
            var estadoVibracao = localStorage.getItem("agenda_sem_vibracao");
            var semVibracao = (estadoVibracao === "true") || (estadoVibracao === null);

            // Update icon based on state
            vibrationIcon.textContent = semVibracao ? "📵" : "📳";

            // Load saved vibration duration
            var vibrationDuration = localStorage.getItem("agenda_vibration_duration") || "200";
            document.getElementById("vibrationDuration").value = vibrationDuration;
            document.getElementById("vibrationValue").textContent = vibrationDuration;

            // Load saved periodic vibration settings
            var periodicVibrationEnabled = localStorage.getItem("agenda_periodic_vibration") === "true";
            var periodicInterval = localStorage.getItem("agenda_periodic_interval") || "10";
            
            document.getElementById("periodicVibration").checked = periodicVibrationEnabled;
            document.getElementById("periodicInterval").value = periodicInterval;
            document.getElementById("periodicIntervalValue").textContent = periodicInterval;
            document.getElementById("periodicIntervalContainer").style.display = periodicVibrationEnabled ? "block" : "none";

            // Toggle periodic interval container
            document.getElementById("periodicVibration").addEventListener("change", function() {
                document.getElementById("periodicIntervalContainer").style.display = this.checked ? "block" : "none";
            });

            // Long-press detection
            var pressTimerVib;
            vibrationToggle.addEventListener("mousedown", function() {
                pressTimerVib = setTimeout(function() {
                    openSettingsModal();
                }, 1000);
            });
            vibrationToggle.addEventListener("touchstart", function() {
                pressTimerVib = setTimeout(function() {
                    openSettingsModal();
                }, 1000);
            });
            vibrationToggle.addEventListener("mouseup", function() {
                clearTimeout(pressTimerVib);
            });
            vibrationToggle.addEventListener("mouseleave", function() {
                clearTimeout(pressTimerVib);
            });
            vibrationToggle.addEventListener("touchend", function() {
                clearTimeout(pressTimerVib);
            });

            vibrationToggle.addEventListener("click", function(e) {
                if (pressTimerVib) {
                    clearTimeout(pressTimerVib);
                    pressTimerVib = null;
                }
                semVibracao = !semVibracao;
                localStorage.setItem("agenda_sem_vibracao", semVibracao);
                vibrationIcon.textContent = semVibracao ? "📵" : "📳";
            });
        }

        // Remove the initial sound on page load
        // tocarSomNovoProduto();
    });

    function tocarSomNovoProduto() {
        var estadoGuardado = localStorage.getItem("agenda_som_on");
        var somOn = estadoGuardado !== "false"; // Default to ON
        if (somOn) {
            // Try notification for background/locked screen support
            if ("Notification" in window && Notification.permission === "granted") {
                var notification = new Notification("Nova Falta", {
                    body: "Um novo item foi adicionado à lista",
                    icon: "/images/favicon.jpg",
                    silent: false
                });
                
                // Auto-close notification after 3 seconds
                setTimeout(function() {
                    notification.close();
                }, 3000);
            } else {
                // Fallback to Web Audio API for foreground
                var audioCtx = new (window.AudioContext || window.webkitAudioContext)();
                var osc = audioCtx.createOscillator();
                osc.type = "sine";
                var soundType = localStorage.getItem("agenda_sound_type") || "880";
                osc.frequency.setValueAtTime(parseInt(soundType), audioCtx.currentTime);
                osc.connect(audioCtx.destination);
                osc.start();
                osc.stop(audioCtx.currentTime + 0.15);
            }
        }
    }

    function vibrarNovoProduto() {
        var estadoVibracao = localStorage.getItem("agenda_sem_vibracao");
        var semVibracao = estadoVibracao === "true";
        if (!semVibracao && navigator.vibrate) {
            var vibrationDuration = parseInt(localStorage.getItem("agenda_vibration_duration") || "200");
            navigator.vibrate([vibrationDuration, 100, vibrationDuration]);
            
            // Start periodic vibration if enabled and page is hidden
            startPeriodicVibration();
        }
    }

    function openSettingsModal() {
        document.getElementById("settingsModal").style.display = "flex";
    }

    function closeSettingsModal() {
        // Save settings
        var soundType = document.getElementById("soundType").value;
        var vibrationDuration = document.getElementById("vibrationDuration").value;
        var periodicVibrationEnabled = document.getElementById("periodicVibration").checked;
        var periodicInterval = document.getElementById("periodicInterval").value;
        
        localStorage.setItem("agenda_sound_type", soundType);
        localStorage.setItem("agenda_vibration_duration", vibrationDuration);
        localStorage.setItem("agenda_periodic_vibration", periodicVibrationEnabled);
        localStorage.setItem("agenda_periodic_interval", periodicInterval);
        
        document.getElementById("vibrationValue").textContent = vibrationDuration;
        document.getElementById("periodicIntervalValue").textContent = periodicInterval;
        
        document.getElementById("settingsModal").style.display = "none";
    }

    // Update vibration value display when slider changes
    document.addEventListener("DOMContentLoaded", function() {
        var vibrationSlider = document.getElementById("vibrationDuration");
        if (vibrationSlider) {
            vibrationSlider.addEventListener("input", function() {
                document.getElementById("vibrationValue").textContent = this.value;
            });
        }

        var periodicIntervalSlider = document.getElementById("periodicInterval");
        if (periodicIntervalSlider) {
            periodicIntervalSlider.addEventListener("input", function() {
                document.getElementById("periodicIntervalValue").textContent = this.value;
            });
        }
    });

    // Page Visibility API for periodic vibration
    var periodicVibrationTimer = null;
    var hasNewItems = false;

    document.addEventListener("visibilitychange", function() {
        if (!document.hidden) {
            // Page became visible - stop periodic vibration
            if (periodicVibrationTimer) {
                clearInterval(periodicVibrationTimer);
                periodicVibrationTimer = null;
            }
            hasNewItems = false;
        }
    });

    function startPeriodicVibration() {
        var periodicVibrationEnabled = localStorage.getItem("agenda_periodic_vibration") === "true";
        if (!periodicVibrationEnabled || document.hidden === false) {
            return;
        }

        var periodicInterval = parseInt(localStorage.getItem("agenda_periodic_interval") || "10") * 1000;
        var vibrationDuration = parseInt(localStorage.getItem("agenda_vibration_duration") || "200");

        hasNewItems = true;
        
        if (periodicVibrationTimer) {
            clearInterval(periodicVibrationTimer);
        }

        periodicVibrationTimer = setInterval(function() {
            if (document.hidden && hasNewItems && navigator.vibrate) {
                navigator.vibrate([vibrationDuration, 100, vibrationDuration]);
            }
        }, periodicInterval);
    }

    function marcarEliminar(id) {
        var row = document.getElementById('row-' + id);
        var btnEliminar = document.getElementById('btn-eliminar-' + id);
        var btnCancelar = document.getElementById('btn-cancelar-' + id);

        row.style.textDecoration = 'line-through';
        row.style.opacity = '0.5';
        btnEliminar.textContent = '✓';
        btnCancelar.style.display = 'inline-block';
    }

    function cancelarEliminar(id) {
        var row = document.getElementById('row-' + id);
        var btnEliminar = document.getElementById('btn-eliminar-' + id);
        var btnCancelar = document.getElementById('btn-cancelar-' + id);

        row.style.textDecoration = 'none';
        row.style.opacity = '1';
        btnEliminar.textContent = 'X';
        btnCancelar.style.display = 'none';
    }

    function confirmar(id) {
        // Check if row is marked for deletion
        var row = document.getElementById('row-' + id);
        if (row.style.textDecoration === 'line-through') {
            // Move row to bottom of table before deletion
            var tbody = row.parentNode;
            tbody.appendChild(row);
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
        btnEliminar.textContent = '✓';
        btnCancelar.style.display = 'inline-block';
    }

    function cancelarEliminarMobile(id) {
        var card = document.getElementById('card-' + id);
        var btnEliminar = document.getElementById('btn-eliminar-mobile-' + id);
        var btnCancelar = document.getElementById('btn-cancelar-mobile-' + id);

        card.style.textDecoration = 'none';
        card.style.opacity = '1';
        btnEliminar.textContent = 'X';
        btnCancelar.style.display = 'none';
    }

    function confirmarMobile(id) {
        var card = document.getElementById('card-' + id);
        if (card.style.textDecoration === 'line-through') {
            // Move card to bottom of list before deletion
            var container = card.parentNode;
            container.appendChild(card);
            // Proceed with actual deletion
            window.location.href = 'delete?id=' + id;
        } else {
            marcarEliminarMobile(id);
        }
    }

    function openFullscreen(src) {
        var overlay = document.getElementById('fullscreenOverlay');
        var img = document.getElementById('fullscreenImage');
        img.src = src;
        overlay.style.display = 'flex';
    }

    function closeFullscreen() {
        document.getElementById('fullscreenOverlay').style.display = 'none';
    }
</script>
</body>
</html>