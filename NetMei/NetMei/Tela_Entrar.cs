using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

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
    }
}
