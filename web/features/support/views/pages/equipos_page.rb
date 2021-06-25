class EquiposPage
  include Capybara::DSL

  #como fazer um checkpoint dentro do pageObject sem colocar o expect
  #página tem o css verdadeiro ou falso
  #faz com que o capybara espere até que o elemento esteja visível na página

  def create(equipo)
    #checkpoint com timeout explícito
    page.has_css?("#equipoForm")

    upload(equipo[:img]) if equipo[:img].length > 0

    find("input[placeholder$=equipamento]").set equipo[:nome]
    select_cat(equipo[:categoria]) if equipo[:categoria].length > 0
    find("input[placeholder^=Valor]").set equipo[:preco]

    click_button "Cadastrar"
  end

  def upload(file_name)
    #acessa o diretório de execução do projeto
    imagem = Dir.pwd + "/features/support/fixtures/images/" + file_name

    #quando o elemento é invisível ao usuário, mas existe no css precisa colocar visible false
    find("#thumbnail input[type=file]", visible: false).set imagem
  end

  def select_cat(cat)
    find("#category").find("option", text: cat).select_option
  end
end
