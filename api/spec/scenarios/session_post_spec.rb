describe "POST /sessions" do
    context "login com sucesso" do
        before(:all) do
           payload = { email: "betao@hotmail.com", password: "pwd123"}
           @result = Sessions.new.login(payload)
        end

        it "valida status code" do 
            expect(@result.code).to eql 200
        end
            
        it "valida id do usuário" do
            expect(@result.parsed_response["_id"].length).to eql 24
        end         
        # O tamanho do id do usuário é de 24 caracteres, é um padrão do mongodb 

        # puts result.class
        # puts result.parsed_response["_id"]
        # puts result.parsed_response.class
    end

    context "senha inválida" do
        before(:all) do
           payload = { email: "betao@hotmail.com", password: "123456"}
           @result = Sessions.new.login(payload)
        end

        it "valida status code" do 
            expect(@result.code).to eql 401
        end
            
        it "valida id do usuário" do
            expect(@result.parsed_response["error"]).to eql "Unauthorized"
        end         
    end    

    # context "usuário não existe" do
    #     before(:all) do
    #        payload = { email: "404@yahoo.com", password: "pwd123"}
    #        @result = Sessions.new.login(payload)
    #     end

    #     it "valida status code" do 
    #         expect(@result.code).to eql 401
    #     end
            
    #     it "valida id do usuário" do
    #         expect(@result.parsed_response["error"]).to eql "Unauthorized"
    #     end         
    # end    

    # examples = [
    #     {
    #         title: "senha incorreta",
    #         payload: { email: "betao@yahoo.com", password: "senha"},
    #         code: 401,
    #         error: "Unauthorized",
    #     },
    #     {
    #         title: "usuario nao existe",
    #         payload: { email: "404@yahoo.com", password: "senha"},
    #         code: 401,
    #         error: "Unauthorized",
    #     },
    #     {
    #         title: "email em branco",
    #         payload: { email: "", password: "senha"},
    #         code: 412,
    #         error: "required email",
    #     },
    #     {
    #         title: "sem o campo email",
    #         payload: { password: "senha"},
    #         code: 412,
    #         error: "required email",
    #     },
    #     {
    #         title: "senha em branco",
    #         payload: { email: "betao@yahoo.com", password: ""},
    #         code: 412,
    #         error: "required password",
    #     },
    #     {
    #         title: "sem o campo senha",
    #         payload: { email: "betao@yahoo.com"},
    #         code: 412,
    #         error: "required password",
    #     },      
    # ]

    # puts examples.to_json
    #converter em json para depois jogar no site (google: json to yaml)e converter

    examples = Helpers::get_fixture("login")

    examples.each do |e|
        context "#{e[:title]}" do
            before(:all) do
            @result = Sessions.new.login(e[:payload])
            end

            it "valida status code #{e[:code]}" do 
                expect(@result.code).to eql e[:code]
            end
                
            it "valida id do usuário" do
                expect(@result.parsed_response["error"]).to eql e[:error]
            end   
        end      
    end
end 
