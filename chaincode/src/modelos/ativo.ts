import { Object, Property } from 'fabric-contract-api';

@Object()
export abstract class Ativo {

    @Property()
    protected abstract tipoAtivo: string;
    protected idAtivo: number;
    
    extrairChave():string{
        return this.tipoAtivo+"_"+this.idAtivo
    }
}