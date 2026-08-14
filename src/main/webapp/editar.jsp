<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-pt">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alterar Status da Falta</title>
    <link rel="icon" href="images/favicon.jpg">
    <link rel="stylesheet" href="style.css">
    <style>
        .fullscreen-container {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #006B3F 0%, #009B4D 100%);
            padding: 20px;
        }

        .title {
            color: white;
            font-size: 48px;
            font-weight: bold;
            margin-bottom: 30px;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .form-container {
            width: 100%;
            max-width: 500px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .big-button {
            display: block;
            text-decoration: none;
            background: white;
            color: #009B4D;
            padding: 25px 30px;
            font-size: 24px;
            font-weight: bold;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            transition: transform 0.3s, box-shadow 0.3s;
            border: none;
            cursor: pointer;
            width: 100%;
        }

        .big-button:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.3);
        }

        .big-input {
            width: 100%;
            padding: 20px;
            font-size: 24px;
            border: 2px solid white;
            border-radius: 15px;
            background: white;
            box-sizing: border-box;
        }

        .big-select {
            width: 100%;
            padding: 20px;
            font-size: 24px;
            border: 2px solid white;
            border-radius: 15px;
            background: white;
            box-sizing: border-box;
        }

        .big-textarea {
            width: 100%;
            padding: 20px;
            font-size: 24px;
            border: 2px solid white;
            border-radius: 15px;
            background: white;
            box-sizing: border-box;
            min-height: 120px;
            resize: vertical;
        }

        @media (max-width: 768px) {
            .title {
                font-size: 36px;
                margin-bottom: 25px;
            }

            .big-button {
                padding: 30px 25px;
                font-size: 28px;
            }

            .big-input, .big-select, .big-textarea {
                padding: 25px;
                font-size: 28px;
            }

            .form-container {
                gap: 25px;
            }
        }
    </style>
</head>
<body>
    <div class="fullscreen-container">
        <h1 class="title">Alterar Status da Falta</h1>
        <div class="form-container">
            <form name="frmProduto" action="update">
                <input type="text" name="id" class="big-input" readonly value="<%out.print(request.getAttribute("id"));%>">
                <input type="text" name="nome" class="big-input" readonly value="<%out.print(request.getAttribute("nome"));%>">
                <textarea name="descricao" class="big-textarea" readonly rows="3"><%out.print(request.getAttribute("descricao"));%></textarea>
                <select name="status" class="big-select">
                    <option value="pendente" <% if("pendente".equals(request.getAttribute("status"))) out.print("selected"); %>>Pendente</option>
                    <option value="concluido" <% if("concluido".equals(request.getAttribute("status"))) out.print("selected"); %>>Concluído</option>
                </select>
                <button type="submit" class="big-button">💾 Salvar</button>
            </form>
        </div>
    </div>
</body>
</html>