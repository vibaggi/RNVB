import { Context, Contract } from 'fabric-contract-api'
import { Uteis } from './bibliotecas/uteis'
import { Caderneta } from './modelos/caderneta'

export class GovernoContrato extends Contract {

    async beforeTransaction(ctx: Context){}

    async afterTransaction(ctx: Context){}

    async cadastrarCaderneta(ctx: Context, cpf: number): Promise<string>{

        return "OK"
    }

    async cadastrarVacina(ctx: Context): Promise<string>{

        return "OK"
    }


}