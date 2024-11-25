    using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;


namespace NetMei
{
    public partial class Tela_Entrar : Form
    {
        public Tela_Entrar()
        {
            InitializeComponent();
        }

        private void btn_CriarConta_Click(object sender, EventArgs e)
        {
            Tela_Cadastro novaAba = new Tela_Cadastro();
            novaAba.Show();
        }

        private void btn_Entrar_Click(object sender, EventArgs e)
        {
            MySqlConnection conectar = new MySqlConnection("SERVER=localhost;DATABASE=netmei;UID=root;PASSWORD= ");
            conectar.Open();

            //fazer uma única consulta
            MySqlCommand consulta = new MySqlCommand();
            consulta.Connection = conectar;
            consulta.CommandText = @"
            SELECT permissao.permissao
            FROM usuario 
            INNER JOIN usuario_permissao ON usuario.id_usuario = usuario_permissao.id_usuario_id
            INNER JOIN permissao ON usuario_permissao.id_permissao_id = permissao.id_permissao
            WHERE usuario.email = @Email AND usuario.senha = @Senha ";

     

            consulta.Parameters.AddWithValue("@Email", textBox1.Text);
            consulta.Parameters.AddWithValue("@Senha", textBox2.Text);
           

           

            string permissao = consulta.ExecuteScalar()?.ToString(); // Verificar o tipo de permissao

            if (permissao == "adm")
            {
                MessageBox.Show("Login bem sucedido");

                tela_ADM novaAba = new tela_ADM();  
                novaAba.Show();
            }
            else if (permissao == "user")
            {
                MessageBox.Show("Login bem sucedido");

                Tela_Menu_Usuario novaAba = new Tela_Menu_Usuario();
                novaAba.Show();
            }
            else if (permissao == "mei")
            {
                MessageBox.Show("Login bem sucedido");

                Tela_Menu_Mei novaAba = new Tela_Menu_Mei();
                novaAba.Show();
            }

            else
            {
                MessageBox.Show("Email ou Senha incorretos, digite novamente");
            }
        }
    }
}
