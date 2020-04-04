"use strict";
/*
 * SPDX-License-Identifier: Apache-2.0
 */
// import { Object, Property } from 'fabric-contract-api';
exports.__esModule = true;
// @Object()
var Ativo = /** @class */ (function () {
    function Ativo() {
    }
    Ativo.prototype.extrairChave = function (idAtivo) {
        return this.tipoAtivo + "_" + idAtivo;
        // return "ok"
    };
    Ativo.extrairChave = function (idAtivo) {
        console.log(typeof this);
        return "OK";
    };
    return Ativo;
}());
exports.Ativo = Ativo;
