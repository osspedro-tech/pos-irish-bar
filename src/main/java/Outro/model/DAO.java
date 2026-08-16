package Outro.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

public class DAO {
    /** Módulo de conecção **/
    // Parametros de conexao
    private String driver = "com.mysql.cj.jdbc.Driver";
    private String url = "jdbc:mysql://127.0.0.1:3306/dbagenda2?useTimezone=true&serverTimexone=UTC";
    private String user = "root";
    private String password = "NovaPasswordForte";

    private Connection conetar(){
        Connection con = null;
        try{
            // Check if using Render.com (PostgreSQL) or local (MySQL)
            String dbUrl = System.getenv("DATABASE_URL");
            if (dbUrl != null && !dbUrl.isEmpty()) {
                // PostgreSQL for Render.com
                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection(dbUrl);
            } else {
                // MySQL for local development
                Class.forName(driver);
                con = DriverManager.getConnection(url, user, password);
            }
            return con;
        } catch (Exception e){
            System.out.println(e);
            return null;
        }
    }
    // Teste de conecçao
    public void testeConexao(){
        try{
            Connection con = conetar();
            System.out.println(con);
            con.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /** CRUD CREATE **/
    public void inserirProduto(JavaBeans produto){
        String create = "insert into produtos(nome, descricao, foto, status) values (?,?,?,?)";
        try{
            Connection con = conetar();
            System.out.println("Conexão para insert: " + (con != null));
            System.out.println("Inserindo produto: " + produto.getNome());
            PreparedStatement pst = con.prepareStatement(create);
            pst.setString(1, produto.getNome());
            pst.setString(2, produto.getDescricao());
            pst.setString(3, produto.getFoto());
            pst.setString(4, produto.getStatus());
            pst.executeUpdate();
            con.close();
            System.out.println("Produto inserido com sucesso");
        } catch (Exception e) {
            System.out.println("Erro ao inserir produto: " + e);
            e.printStackTrace();
        }
    }
    
    /** Initialize database tables for PostgreSQL **/
    public void inicializarTabelas() {
        try {
            Connection con = conetar();
            String createTable = "CREATE TABLE IF NOT EXISTS produtos (" +
                "id SERIAL PRIMARY KEY, " +
                "nome VARCHAR(255), " +
                "descricao TEXT, " +
                "foto VARCHAR(255), " +
                "status VARCHAR(50), " +
                "data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                ")";
            PreparedStatement pst = con.prepareStatement(createTable);
            pst.executeUpdate();
            con.close();
            System.out.println("Tabela produtos inicializada com sucesso");
        } catch (Exception e) {
            System.out.println("Erro ao inicializar tabela: " + e);
        }
    }
    /** CRUD READ **/
    public ArrayList<JavaBeans> listarProdutos(){
        ArrayList<JavaBeans> produtos = new ArrayList<>();

        String read = "select * from produtos order by id desc";
        try{
            Connection con = conetar();
            System.out.println("Conexão estabelecida: " + (con != null));
            PreparedStatement pst = con.prepareStatement(read);
            ResultSet rs = pst.executeQuery();
            int count = 0;
            while(rs.next()){
                count++;
                String id=rs.getString("id");
                String nome=rs.getString("nome");
                String descricao=rs.getString("descricao");
                String foto=rs.getString("foto");
                String status=rs.getString("status");
                Timestamp dataCriacao = rs.getTimestamp("data_criacao");
                produtos.add(new JavaBeans(id, nome, descricao, foto, status, dataCriacao));
                System.out.println("Produto encontrado: " + nome);
            }
            con.close();
            System.out.println("Total de produtos encontrados: " + count);
            return produtos;
        } catch (Exception e) {
            System.out.println("Erro ao listar produtos: " + e);
            e.printStackTrace();
            return null;
        }
    }
    /** CRUD UPDATE **/
    public void selecionarProduto(JavaBeans produto){
        String read2 = "select * from produtos where id= ?";
        try{
            Connection con = conetar();
            PreparedStatement pst = con.prepareStatement(read2);
            pst.setString(1, produto.getId());
            ResultSet rs = pst.executeQuery();
            while (rs.next()){
                produto.setId(rs.getString("id"));
                produto.setNome(rs.getString("nome"));
                produto.setDescricao(rs.getString("descricao"));
                produto.setFoto(rs.getString("foto"));
                produto.setStatus(rs.getString("status"));
                produto.setDataCriacao(rs.getTimestamp("data_criacao"));
            }
            con.close();
        }catch (Exception e){
            System.out.println(e);
        }
    }

    public void alterarStatusProduto(JavaBeans produto){
        String update = "update produtos set status=? where id=?";
        try{
            Connection con = conetar();
            PreparedStatement pst = con.prepareStatement(update);
            pst.setString(1, produto.getStatus());
            pst.setString(2, produto.getId());
            pst.executeUpdate();
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    /** CRUD DELETE**/
    public void apagarProduto(JavaBeans produto){
        String delete = "delete from produtos where id=?";
        try{
            Connection con = conetar();
            PreparedStatement pst = con.prepareStatement(delete);
            pst.setString(1, produto.getId());
            pst.executeUpdate();
            con.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
