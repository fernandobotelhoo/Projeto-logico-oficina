# Projeto lógico oficina

## Objetivo:
Desenvolver um banco de dados lógico para gerenciar informações de uma oficina mecânica, desde clientes e veículos até ordens de serviço e peças. Este projeto visa demonstrar a aplicação prática de conceitos de modelagem de dados e SQL.

## Funcionalidades do Banco de dados 
- **Cadastro de clientes:** Garantindo que os clientes possam cadastrar seus veículos
- **Informações pessoais:** (nome, CPF, endereço, telefone)
- **Veículos associados ao cliente:** placa, modelo e cor.
- **Histórico de serviços realizados:** data, serviço, valor e peças utilizadas.
- **Múltiplas formas de pagamento:** Suporte a Pix, cartão e boleto.
- **Status de OS:** Acompanhamento da Ordem de Serviço.

## Consultas SQL 
Foram elaboradas algumas consultas SQL para explorar a capacidade do banco de dados.

- **Recuperações simples:** SELECT * FROM Cliente;
- **Filtros:** SELECT * FROM OrdemServico WHERE status = 'Concluído';
- **Ordenação:** SELECT * FROM Peca ORDER BY ValorUnitario DESC;
