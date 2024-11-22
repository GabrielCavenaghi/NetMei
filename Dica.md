## DESCOBRI ISSO COM UM ISSUE NO NOSSO PROJETO
**Estavamos fazendo múltiplas consultas, para verificar as 3 permissões: adm, user e mei.**



**Isso é extremamente errado e devíamos ter feito apenas uma consulta utilizando o INNER JOIN, ficando da seguinte forma:**
--------------------------------------------------------------------

consulta.CommandText = @"
SELECT permissao.permissao

FROM usuario 

INNER JOIN usuario_permissao ON usuario.id_usuario = usuario_permissao.id_usuario_id

INNER JOIN permissao ON usuario_permissao.id_permissao_id = permissao.id_permissao

WHERE usuario.email = @Email AND usuario.senha = @Senha ";

     
## ESSA SINTAXE ABAIXO FACILITA MUITO MAIS DO QUE FICAR UTILIZANDO A CONCATENAÇÃO DAS TEXTBOXES PARA PUXAR OS VALORES:

consulta.Parameters.AddWithValue("@Email", textBox1.Text);

consulta.Parameters.AddWithValue("@Senha", textBox2.Text);

## COMO FAZÍAMOS: 
**
    MySqlCommand consulta = new MySqlCommand();
    
            consulta.Connection = conectar;
            
            consulta.CommandText = "SELECT COUNT(*) 
            
            FROM usuario 
            
            INNER JOIN permissao 
            
            WHERE usuario.email = '" + textBox1.Text + "'
            
            AND usuario.senha = '"+ textBox2.Text + "' 
            
            AND permissao.permissao = 'adm';"; **

**Parem de usar text boxes concatenadas para puxar valores! Percebam que é mais fácil desse jeito mostrado e menos confuso!!**
  
Nas minhas pesquisas percebi que é mais facil adicionar o .Parameters.AddWithValue( );

Pois usar valores concatenados das textBoxes é algo que deve ser evitado por confusão e outros problemas, aquela sintaxe simplifica muito mais, pois já colocamos o valor da textBox nela para só ser chamada depois como no exemplo acima @Email ou @Senha, que já terão os devidos valores e entrarão na consulta facilmente.


---------------------------------------------------------------------------------------------------------------------------

OU SEJA: O que foi feito? 

1- Select apenas na permissão, pois depois armazenamos a resposta da consulta numa variável, a resposta no caso é a permissão que nossa consulta voltará 

EX: string permissao = consulta.ExecuteScalar()?.ToString();

2- INNER JOIN nas tabelas, na que relaciona usuario com permissao, ligando suas chaves para saber qual usuário possui qual permissão.

3- RECEBIMENTO na variável string permissao, para então fazer um IF para cada retorno, mandando cada um para sua tela pós login.
