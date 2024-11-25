using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;

namespace NetMei
{
    public partial class Tela_Menu_Usuario : Form
    {
        public Tela_Menu_Usuario()
        {
            InitializeComponent();

            dataGridView1.Rows.Clear();

            MySqlConnection conexao = new MySqlConnection();
            conexao.ConnectionString = ("SERVER=127.0.0.1; DATABASE=netmei;UID = root; PASSWORD = ; ");
            conexao.Open();
            using (MySqlCommand con = new MySqlCommand("DESC mei", conexao))
            {
                using (MySqlDataReader reader = con.ExecuteReader())
                {
                    comboBox1.Items.Clear();
                    while (reader.Read())
                    {
                        comboBox1.Items.Add(reader[0].ToString());
                        string columnName = reader["Field"].ToString();
                        dataGridView1.Columns.Add(columnName, columnName);

                    }
                }
            }
            conexao.Close();
            conexao.ConnectionString = ("SERVER=127.0.0.1; DATABASE=netmei;UID = root; PASSWORD = ; ");
            conexao.Open();
            using (MySqlCommand consulta = new MySqlCommand("SELECT * FROM mei", conexao))
            {
                using (MySqlDataReader resultado = consulta.ExecuteReader())
                {
                    if (resultado.HasRows)
                    {
                        while (resultado.Read())
                        {
                            // Cria uma nova linha para cada registro retornado
                            var row = new DataGridViewRow();
                            row.CreateCells(dataGridView1);

                            for (int i = 0; i < dataGridView1.Columns.Count; i++)
                            {
                                row.Cells[i].Value = resultado[i].ToString();
                            }

                            dataGridView1.Rows.Add(row);
                        }
                    }
                    else
                    {
                        MessageBox.Show("Nenhum registro foi encontrado.");
                    }
                }
            }
        }

        private void Tela_Menu_Usuario_Load(object sender, EventArgs e)
        {

        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
    }
}
