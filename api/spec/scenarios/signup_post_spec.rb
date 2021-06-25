describe "POST /signup" do
    context "novo usuario" do
        before(:all) do
            payload = { name: "Noah", email: "noah@bol.com", password: "pwd123" }
            MongoDB.new.remove_user(payload[:email])
            
            @result = Signup.new.create(payload)
        end    

        it "valida status code" do 
            expect(@result.code).to eql 200
        end
            
        it "valida id do usuário" do
            expect(@result.parsed_response["_id"].length).to eql 24
        end   
    end   
    
    context "usuario ja existe" do
        before(:all) do
            # dado que eu tenho um novo usuário
            payload = { name: "João da Silva", email: "joao@ig.com.br", password: "pwd123" }
            MongoDB.new.remove_user(payload[:email])

            #e o email desse usuário já foi cadastrado no sistema
            Signup.new.create(payload)

            #quando faço uma requisição para a rota /signup
            @result = Signup.new.create(payload)
        end
        it "deve retornar 409" do 
            #então deve retornar 409
            expect(@result.code).to eql 409
        end
            
        it "deve retornar mensagem" do
            expect(@result.parsed_response["error"]).to eql "Email already exists :("
        end  
    end
    
    examples = [
        {
            title: "Campo nome em branco",
            payload: { name: "", email: "betao@yahoo.com", password: "senha"},
            code: 412,
            error: "required name",
        },
        {
            title: "Sem o campo nome",
            payload: { email: "betao@yahoo.com", password: "senha"},
            code: 412,
            error: "required name",
        },
        {
            title: "Campo email invalido",
            payload: { name: "Roberto", email: "betaoig.com.br", password: "senha"},
            code: 412,
            error: "wrong email",
        },
        {
            title: "Campo email em branco",
            payload: { name: "Roberto", email: "", password: "senha"},
            code: 412,
            error: "required email",
        },
        {
            title: "Sem o campo email",
            payload: { name: "Roberto", password: "senha"},
            code: 412,
            error: "required email",
        },
        {
            title: "Campo senha em branco",
            payload: { name: "Roberto", email: "betao@yahoo.com", password: ""},
            code: 412,
            error: "required password",
        },
        {
            title: "Sem o campo senha",
            payload: { name: "Roberto", email: "betao@yahoo.com"},
            code: 412,
            error: "required password",
        },      
    ]

    examples.each do |e|
        context "#{e[:title]}" do
            before(:all) do
            @result = Signup.new.create(e[:payload])
            end

            it "valida status code #{e[:code]}" do 
                expect(@result.code).to eql e[:code]
            end
                
            it "valida mensagem de erro" do
                expect(@result.parsed_response["error"]).to eql e[:error]
            end   
        end      
    end
end