"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
exports.__esModule = true;
// import { Object, Property } from 'fabric-contract-api';
var ativo_1 = require("./ativo");
// @Object()
var Vacina = /** @class */ (function (_super) {
    __extends(Vacina, _super);
    function Vacina() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        // @Property()
        _this.tipoAtivo = 'VACINA';
        return _this;
    }
    return Vacina;
}(ativo_1.Ativo));
exports.Vacina = Vacina;
