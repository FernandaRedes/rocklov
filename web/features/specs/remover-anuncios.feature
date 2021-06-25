#language: pt

Funcionalidade: Remover Anúncios
    Sendo um anunciante que possui um equipamento indesejado
    Quero poder remover esse anúncio
    Para que eu possa manter meu dashboard atualizado


    Contexto: Login
        * Login com "spider@hotmail.com" e "pwd123"

    
    Cenario: Remover um anúncio

        Dado que eu tenho um anúncio indesejado:
            | img       | telecaster.jpg    |
            | nome      | Fender Telecaster |
            | categoria | Cordas            |
            | preco     | 50                |
        Quando eu solicito a exclusão desse item
            E confirmo a exclusão
        Então não devo ver esse item no meu Dashboard

    
    Cenario: Desistir da exclusão

        Dado que eu tenho um anúncio indesejado:
            | img       | conga.jpg |
            | nome      | Conga     |
            | categoria | Outros    |
            | preco     | 100       |
        Quando eu solicito a exclusão desse item
            Mas não confirmo a solicitação
        Então esse item deve permanecer no meu Dashboard