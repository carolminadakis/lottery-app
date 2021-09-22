//
//  ViewController.swift
//  Loteria
//
//  Created by Ana Carolina Bernardes Minadakis on 22/09/21.
//

import UIKit

enum GameType: String {
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

//como argumento recebemos a quantidade de bolinhas e o número máximo válido que pode ser sorteado
func chooseNumbers(total: Int, universe: Int) -> [Int] {
    var result: [Int] = []
    //enquanto o array tiver valores menores do que a quantidade total de bolinhas por jogo
    while result.count < total {
        //sorteia um número aleatório. Como o arc4random gera número de 0 até o máximo esperado
        //preciso somar +1, para que ele não comece sorteando apartir do 0 e sim do 1
        let randomNumber = Int(arc4random_uniform(UInt32(universe))+1)
        //checo se o número não existe no array
        if !result.contains(randomNumber) {
            //adiciono-o caso não exista
            result.append(randomNumber)
        }
    }
    //para sair os números em ordem crescente, uso o método sorted()
    return result.sorted()
}


class ViewController: UIViewController {

    
    @IBOutlet weak var lbGameType: UILabel!
    @IBOutlet weak var scGameType: UISegmentedControl!
    //Usamos o OutletCollection para criar um array de botões, podendo associá-lo aos demais botões
    @IBOutlet var balls: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //para que o jogo comece já com os números aleatórios para mega-sena
        showNumbers(for: .megasena)
    }

    func showNumbers(for type: GameType) {
        //Pego o jogo escolhido na tela e mudo o texto para o seu tipo de jogo
        lbGameType.text = type.rawValue
        var game: [Int] = []
        switch type {
        //uso o enum para escolher o cenário do jogo
            case .megasena:
                game = chooseNumbers(total: 6, universe: 60)
                //através desse comando eu deixo a sexta bolinha aparecer no jogo da sena
                balls.last!.isHidden = false
            case .quina:
                game = chooseNumbers(total: 5, universe: 80)
                //através desse comando eu deixo a sexta bolinha escondida no jogo da quina
                balls.last!.isHidden = true
    }
        //para recuperar o index e o valor no array game, uso o método enumerated(), que me devolve uma tupla
        for (index, game) in game.enumerated() {
            //pego o valor dos números sorteados e seto na bolinha para que apareça o número sorteado
            balls[index].setTitle("\(game)", for: .normal)
        }
    
}
    //Esta função está atrelada tanto ao tipo de jogo quanto ao botão de gerar jogo
    @IBAction func generateGame() {
        //de acordo com o jogo selecionado na tela, trocamos chamamos a função showNumbers, que se adequará
        //a quantidades de bolinhas a serem mostradas e os números, que são escolhidos aleatóriamente.
        switch scGameType.selectedSegmentIndex {
        // 0 é referente ao index do jogo mega-sena
        case 0:
            showNumbers(for: .megasena)
        //o valor default valerá para o jogo quina
        default:
            showNumbers(for: .quina)
        }
    }
    
}


