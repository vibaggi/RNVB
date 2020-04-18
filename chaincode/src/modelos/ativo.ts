import { Object, Property } from 'fabric-contract-api';
import { tiposAtivo } from './../bibliotecas/types'
@Object()
export abstract class Ativo {

    @Property()
    protected abstract situacao: string;
    protected readonly tipoAtivo: tiposAtivo;
    protected idAtivo: number;

    constructor(tipoAtivo: tiposAtivo) {
        this.tipoAtivo = tipoAtivo
    }
    
    public extrairChave():string{
        return this.tipoAtivo+"_"+this.idAtivo
    }
}