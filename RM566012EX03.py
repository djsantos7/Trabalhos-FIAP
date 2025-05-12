def main():
    tabela_parcelamento = {
        1: 0,
        3: 10,
        6: 15,
        9: 20,
        12: 25
    }

    while True:
        try:
            valor_divida = float(input("Digite o valor da dívida: R$ "))
            if valor_divida > 0:
                break
            else:
                print("O valor deve ser maior que zero!")
        except ValueError:
            print("Por favor, digite um valor numérico válido.")

    print("\n{:<15} {:<15} {:<15} {:<15}".format(
        "Valor Dívida", "Valor Juros", "Parcelas", "Valor Parcela"))
    print("-" * 60)

    for parcelas, juros in tabela_parcelamento.items():
        valor_juros = valor_divida * (juros / 100)
        valor_total = valor_divida + valor_juros
        valor_parcela = valor_total / parcelas if parcelas > 1 else valor_total
        
        print("{:<15.2f} {:<15.2f} {:<15} {:<15.2f}".format(
            valor_total, valor_juros, parcelas, valor_parcela))

if __name__ == "__main__":
    main()
input()