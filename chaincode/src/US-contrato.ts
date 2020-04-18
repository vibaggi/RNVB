import { Context, Contract } from 'fabric-contract-api'
import { Uteis } from './bibliotecas/uteis'
import { Caderneta } from './modelos/caderneta'

export class USContrato extends Contract {

    async beforeTransaction(ctx: Context){
        //Verificar qual o mspid da organizacao
        //verificar se o tipo dessa organizacao é valido
        let tipo = Uteis.extrairTipoOrganizacaoMSPID(ctx); 
        if(tipo != "unidadesaude") throw new Error('Sua organização não é uma unidade de saude!')

    }

    async afterTransaction(ctx: Context){}
    
    async aplicarVacina(ctx: Context, idCaderneta: number, idVacina: number, aplicador: string, unidade: string): Promise<string>{
        let bufferVacina = await ctx.stub.getState(Uteis.gerarChave('VACINA', idVacina))
        if(bufferVacina.length == 0) throw new Error('Vacina não existente')

        let bufferCaderneta = await ctx.stub.getState(Uteis.gerarChave("CADERNETA", idCaderneta))
        if(bufferCaderneta.length == 0) throw new Error('Cadernete não existe')

        let caderneta = JSON.parse(bufferCaderneta.toString()) as Caderneta

        caderneta.aplicarVacina(idVacina, aplicador, unidade, Uteis.extrairMSPID(ctx))

        await ctx.stub.putState(caderneta.extrairChave(), Buffer.from(JSON.stringify(caderneta)))

        return "OK"
    }


}