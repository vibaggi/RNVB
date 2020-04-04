/*
 * SPDX-License-Identifier: Apache-2.0
 */

import crypto = require('crypto');
import { Context, Contract, Info, Returns, Transaction } from 'fabric-contract-api';
import { Caderneta } from '../modelos/caderneta';

@Info({title: 'CadernetaControlador', description: 'My Private Data Smart Contract' })
export class CadernetaControlador extends Contract {

    @Transaction(false)
    @Returns('boolean')
    public async cadernetaExiste(ctx: Context, cadernetaId: number): Promise<boolean> {
        const buffer: Buffer = await ctx.stub.getState( Caderneta.extrairChave(cadernetaId) );
        return (!!buffer && buffer.length > 0);
    }


}
