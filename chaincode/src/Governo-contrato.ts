import { Context, Contract } from 'fabric-contract-api'
import { Uteis } from './bibliotecas/uteis'
import { Caderneta } from './modelos/caderneta'

export class GovernoContrato extends Contract {

    async beforeTransaction(ctx: Context){
        //Verificar qual o mspid da organizacao
        //verificar se o tipo dessa organizacao é valido
        let tipo = Uteis.extrairTipoOrganizacaoMSPID(ctx); 
        if(tipo != "governofederal") throw new Error('Sua organização não é um governo!')
    }

    async afterTransaction(ctx: Context){}

    async cadastrarCaderneta(ctx: Context, cpf: number): Promise<string>{
        let bufferCaderneta = await ctx.stub.getState(Uteis.gerarChave('CADERNETA',cpf))
        if(bufferCaderneta.length != 0) throw new Error('Já existe uma caderneta cadastrada!')
        
        let caderneta = new Caderneta(cpf)
        await ctx.stub.putState(caderneta.extrairChave(), Buffer.from(JSON.stringify(caderneta)))

        return "OK"
    }

    async cadastrarVacina(ctx: Context, idVacina: number): Promise<string>{
        let bufferVacina = await ctx.stub.getState(Uteis.gerarChave('VACINA', idVacina))
        

        return "OK"
    }


}