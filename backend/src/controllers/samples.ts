
import { Response, Request, NextFunction } from 'express';

import { getContract } from '../services/blockchain';
import storeMultipleFiles from '../lib/documents';
import { sequelize, QueryTypes } from '../services/postgres';
import userSchema from '../lib/validators/user';
import patientSchema from '../lib/validators/patient';

/*  Exemplo de como buscar um asset do blockchain   */
const getAsset = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const id = req.params.id;
        const contract = await getContract();
        const rawAsset = await contract.evaluateTransaction("readAsset", id);
        const asset = JSON.parse(rawAsset.toString());

        return res.send({ asset });

    } catch (error) {
        next(error)
    }
};

/*  Exemplo de como gravar vários arquivos no object storage  */
const storeFiles = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const files: any = req.files;
        const response = await storeMultipleFiles(files);

        return res.send(response);

    } catch (error) {
        next(error)
    }

};

/*  Exemplo de como fazer uma query simples no postgres  */
const getDataFromTable = async (req: Request, res: Response, next: NextFunction) => {

    const response = await sequelize.query("SELECT * FROM myTable", { type: QueryTypes.SELECT });

    return res.send(response);
};


/*  Exemplo de como aplicar validação de campos do body usando a lib Joy   */
const processPayload = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const { error, value: validPayload } = userSchema.validate(req.body);

        if (error) {
            return res.status(422).json({ error: error.details });
        }

        return res.send(validPayload);

    } catch (error) {
        next(error)
    }
};

/*  Exemplo de como chamar uma criar um asset no blockchain   */
const createPatient = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const { error, value: validPayload } = patientSchema.validate(req.body);

        if (error) {
            return res.status(422).json({ error: error.details });
        }

        const contract = await getContract();
        const result = await contract.submitTransaction("createPatient", JSON.stringify(validPayload));

        return res.send(JSON.parse(result.toString()));
    } catch (error) {
        next(error)
    }
}

/*  Exemplo de como chamar uma query simples do chaincode   */
const getAllPatients = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const contract = await getContract();
        const patientsAsBuffer = await contract.evaluateTransaction("getAllPatients");
        const patients = JSON.parse(patientsAsBuffer.toString());

        return res.send({ patients });

    } catch (error) {
        next(error)
    }
}

export default {
    getAsset,
    storeFiles,
    getDataFromTable,
    processPayload,
    createPatient,
    getAllPatients,
};



