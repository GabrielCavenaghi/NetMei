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
    public partial class Tela_Cadastro : Form
    {
        public Tela_Cadastro()
        {
            InitializeComponent();
            MySqlConnection conectar = new MySqlConnection("SERVER=localhost;DATABASE=netmei;UID=root;PASSWORD= ");
            conectar.Open();
            MySqlCommand consulta = new MySqlCommand();
            consulta.Connection = conectar;
            consulta.CommandText = "SELECT * FROM permissao";

            MySqlDataReader resultado = consulta.ExecuteReader();
            if (resultado.HasRows)
            {
                while (resultado.Read())
                {
                    string permissao = resultado["permissao"].ToString();
                    if (permissao != "adm") // Verifica se a permissão não é "adm"
                    {
                        comboBox1.Items.Add(permissao); // Adiciona apenas permissões permitidas
                    }
                   
                }
                resultado.Close();
            }
            else
            {
                MessageBox.Show("Erro ao carregar as permissões.");
            }
            conectar.Close();
        
    }


        private void btn_Cadastrar_Click(object sender, EventArgs e)
        {
            if (tBox_Senha.Text == tBox_senhaConfirma.Text)
            {


                MySqlConnection conexao = new MySqlConnection();
                conexao.ConnectionString = "SERVER=localhost;DATABASE=netmei;UID=root;PASSWORD= ; ";
                conexao.Open();

                MySqlConnection conexao2 = new MySqlConnection();
                conexao2.ConnectionString = "SERVER=localhost;DATABASE=netmei;UID=root;PASSWORD= ; ";
                conexao2.Open();

                string inserir = "INSERT INTO usuario(nome, email, senha, telefone) values('" + tBox_Nome.Text + "','" + tBox_Email.Text + "','" + tBox_Senha.Text + "','" + tBox_Telefone.Text + "');";
                MySqlCommand comandos = new MySqlCommand(inserir, conexao);
                comandos.ExecuteNonQuery();

                MySqlCommand consulta = new MySqlCommand();
                consulta.Connection = conexao;
                consulta.CommandText = "SELECT * FROM usuario WHERE usuario.nome = '" + tBox_Nome.Text + "'AND usuario.email = '" + tBox_Email.Text + "' AND usuario.senha = '" + tBox_Senha.Text + "' AND usuario.telefone = '" + tBox_Telefone.Text + "' ;";
                MySqlDataReader resultado = consulta.ExecuteReader();

                MySqlCommand consulta2 = new MySqlCommand();
                consulta2.Connection = conexao2;
                consulta2.CommandText = "SELECT * FROM permissao WHERE permissao.permissao = '" + comboBox1.Text + "';";
                MySqlDataReader resultado2 = consulta2.ExecuteReader();


                string id_usuario = ""; //(id_pessoa)
                string id_permissao = ""; //(id_festa)
                string[] split = comboBox1.Text.Split('-');

                id_usuario = split[0];
                if (resultado.HasRows)
                {
                    while (resultado.Read())
                    {
                        id_usuario = resultado[0].ToString();
                    }
                }

                id_permissao = split[0];
                if (resultado2.HasRows)
                {
                    while (resultado2.Read())
                    {
                        id_permissao = resultado2[0].ToString();
                    }
                }

                conexao.Close();
                conexao2.Close();
                conexao.Open();

                string inserir2 = "INSERT INTO usuario_permissao(id_usuario_id, id_permissao_id) values(" + id_usuario + "," + id_permissao + ")";
                MySqlCommand comandos2 = new MySqlCommand(inserir2, conexao);
                comandos2.ExecuteNonQuery();

                conexao.Close();

                MessageBox.Show("Cadastro realizado com sucesso");
                tBox_Nome.Text = "";
                tBox_Email.Text = "";
                tBox_Senha.Text = "";
                tBox_Telefone.Text = "";
                tBox_senhaConfirma.Text = "";
                comboBox1.ResetText();


            }
            else
            {
                MessageBox.Show("Confirme sua senha");
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {

            Tela_Entrar novaAba = new Tela_Entrar();
            novaAba.Show();
        }
    }
}
