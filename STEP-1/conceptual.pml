conceptual schema smokeDB {

    entity type Participant {
        oid : int,
        encryption_public_key : string,
        encryption_public_key_algorithm : string,
        encryption_public_key_digest : string,
        identity : string,
        keystream : string,
        last_status_timestamp : int,
        options : string,
        signature_public_key : string,
        signature_public_key_digest : string,
        signature_public_key_signed : string,
        siphash_id : string,
        siphash_id_digest : string,
        special_value_a : string,
        special_value_b : string,
        special_value_c : string,
        special_value_d : string,
        special_value_e : string
        identifier {
            siphash_id_digest
        }
    }




}