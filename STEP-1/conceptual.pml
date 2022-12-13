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

    entity type Message {
        attachment : blob,
        from_smokestack : string,
        message : string,
        message_digest : string,
        message_identity_digest : string,
        message_read : string,
        message_sent : string,
        siphash_id_digest : string,
        timestamp : int
        identifier {
            siphash_id_digest
            message_digest
        }
    }

    entity type Key {
        keystream : string,
        keystream_digest : string,
        siphash_id_digest : string,
        timestamp : int
        identifier {
            keystream_digest
        }
    }

    entity type Arson_key {
        enabled : string,
        message_keystream : string,
        message_keystream_digest : string,
        siphash_id_digest : string,
        identifier {
            message_keystream_digest
            siphash_id_digest
        }
    }

    entity type Outbound_queue {
        oid : int,
        attempts : int,
        messages : string,
        message_identity_digest : string,
        neighbor_oid : int,
        timestamp : int,
        identifier {
            messages
            neighbor_oid
        }
    }

    entity type Neighbor {
        bytes_read : int,
        bytes_written : int,
        echo_queue_size : int,
        ip_version : string,
        last_error : string,
        local_ip_address : string,
        local_ip_address_digest : string,
        local_port : string,
        local_port_digest : string,
        non_tls : string,
        passthrough : string,
        proxy_ip_address : string,
        proxy_port : string,
        proxy_type : string,
        remote_certificate : string,
        remote_ip_address : string,
        remote_ip_address_digest : string,
        remote_port : string,
        remote_port_digest : string,
        remote_scope_id : string,
        session_cipher : string,
        status : string,
        status_control : string,
        transport : string,
        transport_digest : string,
        uptime : string,
        user_defined_digest : string
        identifier {
            remote_ip_address_digest
            remote_port_digest
            transport_digest
        }
    }

    relationship type participantSipHashId {
        participant[1] : Participant,
        siphash[1] : Siphashid, 
    }

    relationship type messageSipHashId {
        message[0-N] : Message,
        siphash[1] : Siphashid, 
    }

    relationship type keySipHashId {
        key[0-N] : Key,
        siphash[1] : Siphashid, 
    }

    relationship type arson_keySipHashId {
        key[0-N] : Arson_key,
        siphash[1] : Siphashid, 
    }

    relationship type NeighborQueue {
        neighbor[1] : Neighbor,
        queue[1] : Outbound_queue,
    }



}