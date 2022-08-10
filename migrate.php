<?php
/*
  Descrição do Desafio:
    Você precisa realizar uma migração dos dados fictícios que estão na pasta <dados_sistema_legado> para a base da clínica fictícia MedicalChallenge.
    Para isso, você precisa:
      1. Instalar o MariaDB na sua máquina. Dica: Você pode utilizar Docker para isso;
      2. Restaurar o banco da clínica fictícia Medical Challenge: arquivo <medical_challenge_schema>;
      3. Migrar os dados do sistema legado fictício que estão na pasta <dados_sistema_legado>:
        a) Dica: você pode criar uma função para importar os arquivos do formato CSV para uma tabela em um banco temporário no seu MariaDB.
      4. Gerar um dump dos dados já migrados para o banco da clínica fictícia Medical Challenge.
*/

// Importação de Bibliotecas:
include "./lib.php";

$separator = ';';

// Conexão com o banco da clínica fictícia:
$connMedical = mysqli_connect("localhost:3307", "root", "35622381", "MedicalChallenge")
  or die("Não foi possível conectar os servidor MySQL: MedicalChallenge\n");

// Informações de Inicio da Migração:
echo "Início da Migração: " . dateNow() . ".\n\n";

$filepath = "dados_sistema_legado/20210512_pacientes.csv";
$filepath2 = "dados_sistema_legado/20210512_agendamentos.csv";

if((!empty($filepath)) &&(!empty($filepath2))){

  //abrindo arquivo de agendamentos e pacientes
  $agen = fopen($filepath2, 'r');
  $pacientes = fopen($filepath, 'r');


  // Importacao dos convenios e procedimentos
  if ($agen === false){
    echo "Arquivo nao encontrado";
    exit();
  }else{
    fgetcsv($agen,0,$separator);

    //convenios
    while (($line2 = fgetcsv($agen,0,$separator)) !== false){
      $conv    = $line2[10];
    
      $prevConv = "SELECT id FROM convenios WHERE nome = '".$conv."'";
      $prevConv = $connMedical->query($prevConv);
      if($prevConv->num_rows > 0){
        continue;
      }else{
        $connMedical->query("INSERT INTO convenios (nome) VALUES ('".$conv."')");
        print("Adicionado convenio \n".$conv)."\n";
      }
    };

    //procedimentos
    rewind($agen);
    fgetcsv($agen,0,$separator);
    while (($line2 = fgetcsv($agen,0,$separator)) !== false){
      $proc = $line2[11];
    
      $prevProc = "SELECT id FROM procedimentos WHERE nome = '".$proc."'";
      $prevProc = $connMedical->query($prevProc);

      if($prevProc->num_rows > 0){
        continue;
      }else{
        $connMedical->query("INSERT INTO procedimentos (nome) VALUES ('".$proc."')");
        print("Adicionado procedimento ".$proc."\n");
      }
    };

    //profissionais
    rewind($agen);
    fgetcsv($agen,0,$separator);
    while (($line2 = fgetcsv($agen,0,$separator)) !== false){
      $prof = $line2[8];

      $prevProf = "SELECT id FROM profissionais WHERE nome = '".$prof."'";
      $prevProf = $connMedical->query($prevProf);

      if($prevProf->num_rows > 0){
        continue;
      }else{
        $connMedical->query("INSERT INTO profissionais (nome) VALUES ('".$prof."')");
      }
    }
  };

  //Importacao de pacientes
  if($pacientes === false){
    echo "Arquivo nao encontrado";
    exit();
  }else{
    fgetcsv($pacientes,0,$separator);
    
    while (($line = fgetcsv($pacientes,0,$separator)) !== false){
      $codp    = $line[0];
      $nomep   = $line[1];
      $date    = str_replace('/', '-',$line[2]);
      $date    = strtotime($date);
      $dtnp    = date('Y-m-d',$date);
      $paip    = $line[3];
      $maep    = $line[4];
      $cpfp    = $line[5];
      $rgp     = $line[6];
      if($line[7] == 'M'){
        $sexp = 1;
      }else{
        $sexp = 2;
      };
      $sqll = $connMedical->query("SELECT id FROM convenios WHERE nome = '".$line[9]."'");
      $idconvp = $sqll->fetch_array()[0];
      $convp   = $line[9];
      $obsp    = $line[10];

      //pacientes
      $prevPac = "SELECT id FROM pacientes WHERE cpf = '".$cpfp."'";
      $prevPac = $connMedical->query($prevPac);

      if ($prevPac->num_rows > 0){
        continue;
      }else{
        $connMedical->query("INSERT INTO pacientes (nome, sexo, nascimento, cpf, rg, id_convenio, cod_referencia) VALUES ('".$nomep."', '".$sexp."', '".$dtnp."', '".$cpfp."', '".$rgp."', '".$idconvp."', '".$codp."')");
      };
    };
  };

  if ($agen === false){
    echo "Arquivo nao encontrado";
    exit();
  }else{
    rewind($agen);
    fgetcsv($agen,0,$separator);
  
    while (($line2 = fgetcsv($agen,0,$separator)) !== false){
      $desc    = $line2[1];
      $dia     = $line2[2];

      $horaini = $line2[3];
      $horafin = $line2[4];

      $dhinicio = str_replace('/', '-',$dia);
      $dhinicio = $dhinicio." ".$horaini;
      $dhinicio = strtotime($dhinicio);
      $dhinicio = date('Y-m-d H:i:s',$dhinicio);

      $dhfinal = str_replace('/', '-',$dia);
      $dhfinal = $dhfinal." ".$horafin;
      $dhfinal = strtotime($dhfinal);
      $dhfinal = date('Y-m-d H:i:s',$dhfinal);

      
      $sqll = $connMedical->query("SELECT id FROM pacientes WHERE cod_referencia = '".$line2[5]."'");
      $codpaciente = $sqll->fetch_array()[0];
      
      $sqll = $connMedical->query("SELECT id FROM profissionais WHERE nome = '".$line2[8]."'");
      $codprof = $sqll->fetch_array()[0];
      
      $sqll = $connMedical->query("SELECT id FROM convenios WHERE nome = '".$line2[10]."'");
      $codconv = $sqll->fetch_array()[0];

      $sqll = $connMedical->query("SELECT id FROM procedimentos WHERE nome = '".$line2[11]."'");
      $codproc = $sqll->fetch_array()[0];
    
      $connMedical->query("INSERT INTO agendamentos (id_paciente, id_profissional, dh_inicio, dh_fim, id_convenio, id_procedimento, observacoes) VALUES ('".$codpaciente."', '".$codprof."', '".$dhinicio."', '".$dhfinal."', '".$codconv."', '".$codproc."', '".$desc."')");
      
    }
  }
};

// Encerrando as conexões:
$connMedical->close();

// Informações de Fim da Migração:
echo "Fim da Migração: " . dateNow() . ".\n";