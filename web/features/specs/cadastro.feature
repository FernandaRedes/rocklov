#language: pt

Funcionalidade: Cadastro
    Sendo um músico que possui equipamentos musicais
    Quero fazer o meu cadastro no RockLov
    Para que eu possa disponibilizá-los para locação

    @cadastro
    Cenario: Fazer cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulário de cadastro:
            | nome           | email               | password |
            | Fernanda Rocha | fernandaR@gmail.com | pwd123   |
        Então sou redirecionado para o Dashboard
        
    
    Esquema do Cenario: Tentativa de Cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulário de cadastro:
            | nome   | email   | password   |
            | <nome> | <email> | <password> |
        Então vejo a mensagem de alerta: "<mensagem>"

        Exemplos:
            | nome           | email              | password | mensagem                         |
            |                | fernanda@gmail.com | pwd123   | Oops. Informe seu nome completo! |
            | Fernanda Rocha |                    | pwd123   | Oops. Informe um email válido!   |
            | Fernanda Rocha | fernanda*gmail.com | pwd123   | Oops. Informe um email válido!   |
            | Fernanda Rocha | fernanda&gmail.com | pwd123   | Oops. Informe um email válido!   |
            | Fernanda Rocha | fernanda@gmail.com |          | Oops. Informe sua senha secreta! |


# @tentativa_cadastro
# Cenario: Submeter cadastro sem o nome

#     Dado que acesso a página de cadastro
#     Quando submeto o seguinte formulário de cadastro
#         |nome |email             |senha |
#         |     |fernanda@gmail.com|pwd123|
#     Então vejo a mensagem de alerta: "Oops. Informe seu nome completo!"

# @tentativa_cadastro
# Cenario: Submeter cadastro sem o email

#     Dado que acesso a página de cadastro
#     Quando submeto o seguinte formulário de cadastro
#         |nome           |email|senha |
#         |Fernanda Rocha|      |pwd123|
#     Então vejo a mensagem de alerta: "Oops. Informe um email válido!"

# @tentativa_cadastro
# Cenario: Submeter cadastro com email incorreto

#     Dado que acesso a página de cadastro
#     Quando submeto o seguinte formulário de cadastro
#         |nome           |email            |senha |
#         |Fernanda Rocha|fernanda*gmail.com|pwd123|
#     Então vejo a mensagem de alerta: "Oops. Informe um email válido!"

# @tentativa_cadastro
# Cenario: Submeter cadastro sem a senha

#     Dado que acesso a página de cadastro
#     Quando submeto o seguinte formulário de cadastro
#         |nome           |email            |senha|
#         |Fernanda Rocha|fernanda@gmail.com|     |
#     Então vejo a mensagem de alerta: "Oops. Informe sua senha secreta!"
