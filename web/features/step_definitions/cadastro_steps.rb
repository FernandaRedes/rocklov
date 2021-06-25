Dado("que acesso a página de cadastro") do
  @signup_page.open
end

# Quando("submeto o meu cadastro completo") do

#     MongoDB.new.remove_user("fernanda@gmail.com")
#     find("#fullName").set "Fernanda Rocha"
#     #find("#email").set Faker::Internet.free_email
#     find("#email").set "fernanda@gmail.com"
#     find("#password").set "pwd123"

#     click_button "Cadastrar"
# end

Quando("submeto o seguinte formulário de cadastro:") do |table|
  # table is a Cucumber::MultilineArgument::DataTable

  #   log table.hashes

  user = table.hashes.first
  #converte pra array e me dá a primeira posição do array
  #   log user

  MongoDB.new.remove_user(user[:email])
  @signup_page.create(user)
end

# Quando('submeto o meu cadastro sem o nome') do
#     find("#email").set Faker::Internet.free_email
#     find("#password").set "pwd123"
#     click_button "Cadastrar"
# end

# Quando('submeto o meu cadastro sem o email') do
#     find("#fullName").set "Fernanda Rocha"
#     find("#password").set "pwd123"
#     click_button "Cadastrar"
# end

# Quando('submeto o meu cadastro com email incorreto') do
#     find("#fullName").set "Fernanda Rocha"
#     find("#email").set "fernanda*gmail.com"
#     find("#password").set "pwd123"
#     click_button "Cadastrar"
# end

# Quando('submeto o meu cadastro sem a senha') do
#     find("#fullName").set "Fernanda Rocha"
#     find("#email").set "fernanda@gmail.com"
#     click_button "Cadastrar"
# end

# Então('vejo a mensagem de alerta: Oops. Informe seu nome completo!') do
#     alert = find(".alert-dark")
#     expect(alert.text).to eql "Oops. Informe seu nome completo!"
# end

# Então('vejo a mensagem de alerta: Oops. Informe um email válido!') do
#     alert = find(".alert-dark")
#     expect(alert.text).to eql "Oops. Informe um email válido!"
# end

# Então('vejo a mensagem de alerta: Oops. Informe sua senha secreta!') do
#     alert = find(".alert-dark")
#     expect(alert.text).to eql "Oops. Informe sua senha secreta!"
# end
