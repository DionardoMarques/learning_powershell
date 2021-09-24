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