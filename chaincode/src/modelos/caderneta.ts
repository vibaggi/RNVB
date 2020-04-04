import { Object, Property } from 'fabric-contract-api';
import { Ativo } from './ativo';

@Object()
export class Caderneta extends Ativo{
    
    @Property()
    protected tipoAtivo = 'CADERNETA'
    public cpf: number;
    public vacinasIDs: [number];

    constructor(){
        super()
    }
}
