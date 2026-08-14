/** Confirmação de exclusão de produto **/

function confirmar(id){
    let resposta = confirm("Eliminar este pedido?")
    if (resposta === true){
        window.location.href = "delete?id=" + id
    }
}