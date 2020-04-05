import { Context } from "fabric-contract-api";

const ClientIdentity = require('fabric-shim').ClientIdentity;

/**
 * Uteis contém funções auxiliares para lidar com extrações e formatações 
 * entre a biblioteca Fabric e o Chaincode construido. 
 * 
 * Perceba que seus métodos são todos STATIC, não tente criar um objeto para a classe.
 */

 export class Uteis {

    static extrairMSPID(ctx: Context): string|null {
        let clientIdentity = new ClientIdentity(ctx.stub);
        return clientIdentity.getMSPID() || null;
    }

    /**
     * Transforma o Iterator retornado pelo Fabric em um array. 
     * Converte os dados Buffer para String.
     * @param iterator Iterator de ctx.stub.getQueryResult()
     */
    static async queryIteratorParaArray(iterator): Promise<any[]>{
        if (!iterator) throw new Error ("CHAINCODE :: UTEIS :: iterator undefined")
        let array = [];
        while (true) {
            let res = await iterator.next();
            if (res.value && res.value.value.toString()) array.push(JSON.parse(res.value.value.toString('utf8')));
            if (res.done) {
                await iterator.close();
                return array;
            }
        }
    }


 }