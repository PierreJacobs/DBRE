relational schema enrichedSmokeDB : SCH {
    
    table arson_keys {
        columns {
            enabled,
            message_keystream,
            message_keystream_digest,
            siphash_id_digest
        }
        
        references {
            has: siphash_id_digest -> siphash_ids.siphash_id_digest
        }
    }
    
    table congestion_control {
        columns {
            digest,
            timestamp
        }
    }
    
    table fire {
        columns {
            name,
            name_digest
        }
    }
    
    table log {
        columns {
            event,
            timestamp	
        }
    }
    
    table neighbors {
        columns {
            oid,
            bytes_read,
            bytes_written,
            echo_queue_size,
            ip_version,
            last_error,
            local_ip_address,
            local_ip_address_digest,
            local_port,
            local_port_digest,
            non_tls,
            passthrough,
            proxy_ip_address,
            proxy_port,
            proxy_type,
            remote_certificate,
            remote_ip_address,
            remote_ip_address_digest,
            remote_port,
            remote_port_digest,
            remote_scope_id,
            session_cipher,
            status,
            status_control,
            transport,
            transport_digest,
            uptime,
            user_defined_digest
        }
    }
    
    table outbound_queue {
        columns {
            oid,
            attempts,
            messages,
            message_identity_digest,
            neighbor_oid,
            timestamp
        }

        references {
            queued_neighbor: neighbor_oid -> neighbors.oid
        }
    }

    table participants {
        columns {
            oid,
            encryption_public_key,
            encryption_public_key_algorithm,
            encryption_public_key_digest,
            encryption_public_key_signed,
            identity,
            keystream,
            last_status_timestamp,
            options,
            signature_public_key,
            signature_public_key_digest,
            signature_public_key_signed,
            siphash_id,
            siphash_id_digest
        }

        references {
            has: siphash_id_digest -> siphash_ids.siphash_id_digest
        }
        
    }

    table participants_keys {
        columns {
            oid,
            keystream,
            keystream_digest,
            siphash_id_digest,
            timestamp
        }

        references {
            has: siphash_id_digest -> siphash_ids.siphash_id_digest
        }
    }
    
    table participants_messages {
        columns {
            oid,
            attachment,
            from_smokestack,
            message,
            message_digest,
            message_identity_digest,
            message_read,
            message_sent,
            siphash_id_digest,
            timestamp
        }

        references {
            has: siphash_id_digest -> siphash_ids.siphash_id_digest
        }
    }

    table settings {
        columns {
            name,
            name_digest,
            value_
        }
    }
    
    table siphash_ids {
        columns {
            oid,
            name,
            siphash_id,
            siphash_id_digest,
            stream
        }
    }
    
    table steam_files {
        columns {
            oid,
            absolute_filename,
            destination,
            display_filename,
            ephemeral_private_key,
            ephemeral_public_key,
            file_digest,
            file_identity,
            file_identity_digest,
            file_size,
            is_download,
            is_locked,
            key_type,
            keystream,
            read_interval,
            read_offset,
            someoid,
            status,
            transfer_rate
        }
    }
    
}