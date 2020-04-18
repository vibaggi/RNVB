// import { Object, Property } from 'fabric-contract-api';
import { Ativo } from './ativo';
import { estadosVacina } from '../bibliotecas/types';



// @Object()
export class Vacina extends Ativo{

    // @Property()
    protected situacao: estadosVacina;
    public nomeDoenca: string;
    public dataValidadePosAplicacao: Date;
    public dataValidadeParaAplicacao: Date;

    constructor(idVacina: number, nomeDoenca: string, dataValidadePosAplicacao: Date, dataValidadeParaAplicacao: Date){
        super('VACINA')
        this.idAtivo = idVacina
        this.dataValidadeParaAplicacao  = dataValidadeParaAplicacao
        this.dataValidadePosAplicacao   = dataValidadePosAplicacao
        this.nomeDoenca = nomeDoenca
    }


    

}