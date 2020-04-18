import { Object, Property } from 'fabric-contract-api';
import { Ativo } from './ativo';
import { estadosCaderneta } from './../bibliotecas/types';

@Object()
export class Caderneta extends Ativo{
    
    @Property()
    protected situacao: estadosCaderneta;
    public cpf: number;
    private aplicacoes: {
        idVacina: number,
        dataAplicacao: Date,
        aplicador: string,
        unidade: string,
        organizacao: string
    }[];

    constructor(cpf: number){
        super('CADERNETA')
        this.cpf = cpf
        this.idAtivo = cpf
        this.situacao = 'ATIVA'
    }

    public aplicarVacina(idVacina: number, aplicador: string, unidade: string, organizacao: string): void {
        this.aplicacoes.push({ idVacina, aplicador, unidade, organizacao, dataAplicacao: new Date() })
    }


}
