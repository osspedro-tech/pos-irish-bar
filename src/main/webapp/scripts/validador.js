/**
 * Validaçao de funcionário
 * @author Pedro Oliveira
 */

function validar(){
    let nome = frmContato.nome.value
    let contato = frmContato.contato.value
    if (nome === ""){
        alert('Preencha o campo Nome')
        frmContato.nome.focus()
        return false
    } else if (contato === "") {
        alert('Preencha o campo Contacto')
        frmContato.contato.focus()
        return false
    } else {
        document.forms["frmContato"].submit()
    }
}