import { Object, Property } from 'fabric-contract-api';
import { Ativo } from './ativo';

@Object()
export class Caderneta extends Ativo{
    
    @Property()
    protected tipoAtivo = 'CADERNETA'
    public cpf: number;
    public aplicacoes: {
        idVacina: number,
        dataAplicacao: Date,
        aplicador: string
    }[];

    constructor(cpf: number){
        super()
        this.cpf = cpf
        this.idAtivo = cpf
    }

    public aplicarVacina(idVacina: number, aplicador: string): void {
        this.aplicacoes.push({ idVacina, aplicador, dataAplicacao: new Date() })
    }


}
