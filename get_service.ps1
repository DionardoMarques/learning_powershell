# Usar a tecla (TAB) para autocompletar um comando no PowerShell

# Get-Service pegará o serviço que queremos pelo nome dele

# - (hífen) sempre indica que estamos passando um parâmetro

# "" (aspas duplas) indica o nome deste parâmetro que queremos inputar
Get-Service -Name "STLCLIMgrSYSTEM" -ComputerName "BR00MCMPRD00197"

# Para declarar uma variável precisamos sempre do $(dólar)
$service = Get-Service -Name "STLCLIMgrSYSTEM" -ComputerName "BR00MCMPRD00197"

# Quando quisermos verificar o que podemos visualizar dentro de uma variável, utilizamos o . (ponto) após a variável e apertamos a tecla (TAB)
$service.Status
# Verificando a variável
$service

# Verificando a propriedade "Status" do objeto "service"
# Operador -eq significa = (igual)
if ($service.Status -eq "Running") {
#Parando o serviço
$service.Stop()
echo "Serviço parado!"
}
# Buscando o status do serviço novamente
$service = Get-Service -Name "STLCLIMgrSYSTEM" -ComputerName "BR00MCMPRD00197"
# Verficando o a váriavel novamente
$service
# Criando um novo if para que não de erro de argumentos no.start()
if ($service.Status -eq "Stopped") {
# Iniciando o serviço
$service.Start()
echo "Serviço iniciado!"
}
$service = Get-Service -Name "STLCLIMgrSYSTEM" -ComputerName "BR00MCMPRD00197"
$service
# Caso não sejá possível parar, a mensagem abaixo será exibida
else {
echo "Serviço não está executando!"
}

# Verificar arquivos via alias GCI (Get-ChildItem) e retornar as colunas necessárias
# Sem quebra de linha (estrutura linear)
gci -Recurse -File | Where-Object Name -Like "*hid*" | Select-Object Name, Length

# Com quebra de linha (estrutura horizontal)
gci -Recurse -File `
| Where-Object Name -like "*hid*" `
| Select-Object Name, Length

# Verificar serviços via alias GSV (Get-Service) e retornar as colunas necessárias (Nome do serviço, tipo de inicialização, nome da máquina e serviços necessários)
# Sem quebra de linha (estrutura linear)
gsv | Where-Object Name -like "*sequor*" | Select-Object ServiceName, StartType, Status, MachineName, RequiredServices

# Declarando variáveis para substituirmos no código
$service_name = "Name"
$start_type = "Type"
$status = "Status"
$machine_name = "MCM"

# Com quebra de linha (estrutura horizontal)
gsv |
    Where-Object Name -like "*sequor*"|
    Select-Object `
    $service_name, $start_type, $status, $machine_name, RequiredServices

# Running
$service_name = "Name"
# $start_type = "Start Type"
$status = "status"
$machine_name = "MCM"
# $required_services = "required_services"

gsv |
    Where-Object Name -like "*sequor*"|
    Select-Object `
    $service_name, $status, $machine_name
    
# v2
$service_name = "Name"
$status = "status"
$machine_name = "MCM"

# Criando um array para jogar as nossas variáveis dentro. O @ chamado de "Literal de array" deixa explicitamente sinalizado ao PS que queremos criar um array.
$params = @($service_name, $status, $machine_name)

gsv |
    Where-Object Name -like "*sequor*"|
    Select-Object `
    $service_name, $status, $machine_name

# v3
# Hashtable service_name
$service_name = @ {}
$service_name.Add("Label", "Nome")
$service_name.Add("Expression", { $_.Name })

# Hashtable 2 status
$status = @ {}
$status.Add("Label", "Status")
$status.Add("Expression", { $_.Status })

# Hashtable 3 service_description
$service_description = @ {}
$service_description.Add("Label", "Descrição")
$service_description.Add("Expression", { $_.Description })

$params = @($service_name, $status, $service_description)

gsv |
    Where-Object Name -like "*sequor*"|
    Select-Object $params

# Running v3
$service_name = @{}
$service_name.Add("Label", "Nome")
$service_name.Add("Expression", { $_.Name })

$status = @{}
$status.Add("Label", "Status")
$status.Add("Expression", { $_.Status })

$display_name = @{}
$display_name.Add("Label", "Descrição")
$display_name.Add("Expression", { $_.DisplayName })

$params = @($service_name, $status, $display_name)

gsv |
    Where-Object Name -like "*sequor*"|
    Select-Object $params

# v4
$service_name = @{
    Label = "Nome";
    Expression = { $_.Name }
}

$status = @{
    Label = "Status";
    Expression = { $_.Status }
}

$display_name = @{
    Label = "Descrição";
    Expression = { $_.DisplayName }
}

$params = @($service_name, $status, $display_name)

gsv |
    Where-Object Name -like "*sequor*"|
    Select-Object $params