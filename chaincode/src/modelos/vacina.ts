import { Object, Property } from 'fabric-contract-api';
import { Ativo } from './ativo';

@Object()
export class Vacina extends Ativo{

    @Property()
    protected tipoAtivo = 'VACINA'
    public nomeDoenca: string;
    public dataValidadePosAplicacao: Date;
    public dataValidadeParaAplicacao: Date;

}