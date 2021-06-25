# Dado("que estou logado como {string} e {string}") do |email, password|
#   @email = email

#   @login_page.open
#   @login_page.with(email, password)
# end

Dado("Login com {string} e {string}") do |email, password|
  @email = email

  @login_page.open
  @login_page.with(email, password)

  #checkpoint para garantir que estamos no dashboard
  expect(@dash_page.on_dash?).to be true
end

Dado("que acesso o formulario de cadastro de anúncios") do
  @dash_page.goto_equipo_form
end

Dado("que eu tenho o seguinte equipamento:") do |table|
  # table is a Cucumber::MultilineArgument::DataTable
  # Como anúncio está dentro desse dado, o quando não conseguiria ler ele
  # Ao colocar o @ na frente de uma variável, ela se torna uma variável de instância
  #  + - uma variável global, ficando disponível durante toda a execução do cenario

  @anuncio = table.rows_hash
  #log @anuncio

  #Removendo equipamento para poder cadastrar novamente mesma massa de teste
  MongoDB.new.remove_equipo(@anuncio[:nome], @email)
end

Quando("submeto o cadastro desse item") do
  @equipos_page.create(@anuncio)
end

Então("devo ver esse item no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @anuncio[:nome]
  #interpolação de string pra pegar o valor da diária
  expect(@dash_page.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end

Então("deve conter a mensagem de alerta: {string}") do |expect_alert|
  #deve conter a mensagem, ignorando o ícone
  expect(@alert.dark).to have_text expect_alert
end


#Remover anúncios

# Cadastra o anúncio pela API
Dado("que eu tenho um anúncio indesejado:") do |table|     
  
  user_id = page.execute_script("return localStorage.getItem('user')")
  # log user_id    

  thumb = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:img]), "rb")

  @equipo = {
    thumbnail: thumb,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],
  }

  EquiposService.new.create(@equipo, user_id)

  #visit acessa a pagina, current_path é a página atual (F5 pra atualizar a página)
  visit current_path
end                                                                                  
                                                                                     
Quando("eu solicito a exclusão desse item") do                                       
  @dash_page.request_removal(@equipo[:name])
  sleep 1 #think time
end                                                                                  
                                                                                     
Quando("confirmo a exclusão") do                                                     
  @dash_page.confirm_removal    
end   

Quando("não confirmo a solicitação") do
  @dash_page.cancel_removal
end
                                                                                     
Então("não devo ver esse item no meu Dashboard") do                                       
  expect(
    @dash_page.has_no_equipo?(@equipo[:name])
  ).to be true
end   

Então("esse item deve permanecer no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @equipo[:name]
end
                                                                                     