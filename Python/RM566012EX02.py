def main():

    parcelas_acrescimo = {
        6: 3,
        12: 6,
        18: 9,
        24: 12,
        30: 15,
        36: 18,
        42: 21,
        48: 24,
        54: 27,
        60: 30
    }

    while True:
        try:
            valor_carro = float(input("Digite o valor do carro: R$ "))
            if valor_carro > 0:
                break
            else:
                print("O valor deve ser maior que zero!")
        except ValueError:
            print("Por favor, digite um valor numérico válido.")

    valor_a_vista = valor_carro * 0.80
    print("\n{:<15} {:<15} {:<15}".format("Preço Final", "Parcelas", "Valor Parcela"))
    print("-" * 45)
    print("{:<15.2f} {:<15} {:<15.2f}".format(valor_a_vista, "À vista", valor_a_vista))

    for parcelas, acrescimo in parcelas_acrescimo.items():
        preco_final = valor_carro * (1 + acrescimo / 100)
        valor_parcela = preco_final / parcelas
        print("{:<15.2f} {:<15} {:<15.2f}".format(preco_final, f"{parcelas}x", valor_parcela))

if __name__ == "__main__":
    main()
input()