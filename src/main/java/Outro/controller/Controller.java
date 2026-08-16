package Outro.controller;

import Outro.model.DAO;
import Outro.model.JavaBeans;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.UUID;

@WebServlet(urlPatterns = {"/Controller", "/main", "/insert", "/select", "/update", "/delete"})
@MultipartConfig
public class Controller extends HttpServlet {
    private static final long serialVersionUID = 1L;
    DAO dao = new DAO();
    JavaBeans produto = new JavaBeans();
    private static final String UPLOAD_DIR = "fotos";

    public Controller() {
        // Initialize database tables on startup
        dao.inicializarTabelas();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if(action.equals("/main")){
            listarProdutos(request, response);
            return;
        } else if(action.equals("/select")){
            selecionarProduto(request, response);
            return;
        } else if(action.equals("/update")){
            alterarStatus(request, response);
            return;
        } else if(action.equals("/delete")){
            apagarProduto(request, response);
            return;
        } else {
            response.sendRedirect("index.html");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if(action.equals("/insert")){
            novoProduto(request, response);
            return;
        }
    }

    protected void listarProdutos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<JavaBeans> lista = dao.listarProdutos();
        request.setAttribute("produtos", lista);
        RequestDispatcher rd = request.getRequestDispatcher("agenda.jsp");
        rd.forward(request, response);
    }

    protected void novoProduto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String nome = "";
            String descricao = "";
            String fotoUrl = "";
            String fotoPath = "";
            
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            
            // Parse multipart form data
            for (Part part : request.getParts()) {
                String name = part.getName();
                if (name.equals("nome")) {
                    nome = readInputStream(part.getInputStream());
                } else if (name.equals("descricao")) {
                    descricao = readInputStream(part.getInputStream());
                } else if (name.equals("fotoUrl")) {
                    fotoUrl = readInputStream(part.getInputStream());
                } else if (name.equals("foto") && part.getSize() > 0) {
                    String fileName = UUID.randomUUID().toString() + "_" + getFileName(part);
                    String filePath = uploadPath + File.separator + fileName;
                    File file = new File(filePath);
                    
                    try (InputStream input = part.getInputStream()) {
                        Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }
                    
                    fotoPath = UPLOAD_DIR + "/" + fileName;
                }
            }
            
            // Handle URL download if provided
            if (fotoPath.isEmpty() && fotoUrl != null && !fotoUrl.trim().isEmpty()) {
                try {
                    java.net.URL url = new java.net.URL(fotoUrl);
                    String fileName = UUID.randomUUID().toString() + "_image.jpg";
                    String filePath = uploadPath + File.separator + fileName;
                    File file = new File(filePath);
                    
                    try (InputStream input = url.openStream()) {
                        Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }
                    
                    fotoPath = UPLOAD_DIR + "/" + fileName;
                } catch (Exception e) {
                    System.out.println("Erro ao baixar imagem da URL: " + e.getMessage());
                }
            }

            produto.setNome(nome);
            produto.setDescricao(descricao);
            produto.setFoto(fotoPath);
            produto.setStatus("pendente");
            // Data será definida automaticamente pelo MySQL (DEFAULT CURRENT_TIMESTAMP)
            dao.inserirProduto(produto);
            response.sendRedirect("main");
        } catch (Exception e) {
            System.out.println(e);
            e.printStackTrace();
        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] elements = contentDisposition.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "";
    }

    private String readInputStream(InputStream is) {
        try {
            StringBuilder sb = new StringBuilder();
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = is.read(buffer)) != -1) {
                sb.append(new String(buffer, 0, bytesRead));
            }
            return sb.toString();
        } catch (IOException e) {
            return "";
        }
    }

    protected void selecionarProduto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        produto.setId(id);
        dao.selecionarProduto(produto);
        request.setAttribute("id", produto.getId());
        request.setAttribute("nome", produto.getNome());
        request.setAttribute("descricao", produto.getDescricao());
        request.setAttribute("status", produto.getStatus());
        RequestDispatcher rd = request.getRequestDispatcher("editar.jsp");
        rd.forward(request, response);
    }

    protected void alterarStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        produto.setId(id);
        produto.setStatus(request.getParameter("status"));
        dao.alterarStatusProduto(produto);
        response.sendRedirect("main");
    }

    protected void apagarProduto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        System.out.println("ID recebido para deletar: " + id);
        produto.setId(id);
        
        // Delete the photo file if exists
        dao.selecionarProduto(produto);
        if (produto.getFoto() != null && !produto.getFoto().isEmpty()) {
            String photoPath = getServletContext().getRealPath("") + File.separator + produto.getFoto();
            File photoFile = new File(photoPath);
            if (photoFile.exists()) {
                photoFile.delete();
            }
        }
        
        dao.apagarProduto(produto);
        response.sendRedirect("main");
    }
}
