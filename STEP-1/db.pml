physical schemas {

	////////////////// Schéma conceptuel //////////////////

	conceptual schema conceptualSmokeDB {
		
		entity type arson_key {
			enabled : string,
			message_keystream : string,
			message_keystream_digest : string,
			siphash_id_digest : string,
			
			identifier {
				message_keystream_digest
				siphash_id_digest
			}
		}
		
		entity type congestion_control {
			digest : string,
			timestamp: int
			
			identifier {
				digest
			}
		}

		entity type fire {
			name : string,
			name_digest : string,
			stream : string,
			stream_digest : string
			
			identifier {
				stream_digest
			}
		}
		
		// Pas de clef primaire pour cette table
		
		entity type log {
			event : string,
			timestamp : int
		}
		
		entity type neighbors {
			oid : int
			bytes_read : string,
			bytes_written : string,
			echo_queue_size : string,
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
			proxy_port : string,
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
				remote_ip_address_digest,
				remote_port_digest,
				transport_digest
			}
		}
		
		entity type outbound_queue {
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
		

		entity type participants {
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

		entity type participants_keys {
			oid : int
			keystream : string,
			keystream_digest : string,
			siphash_id_digest : string,
			timestamp : int
			
			identifier {
				keystream_digest
			}
		}
		
		entity type participants_messages {
			oid : int,
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
		
		entity type settings {
			name : string,
			name_digest : string,
			value_ : string
			
			identifier {
				name_digest
			}
		}
		
		entity type siphash_ids {
			oid : int,
			name : string,
			siphash_id : string,
			siphash_id_digest : string,
			stream : string
			
			identifier {
				siphash_id_digest
			}
		}
		
		entity type steam_files {
			oid : int,
			absolute_filename : string,
			destination : string,
			display_filename : string,
			ephemeral_private_key : string,
			ephemeral_public_key : string,
			file_digest : string,
			file_identity : string,
			file_identity_digest : string,
			file_size : string,
			is_download : string,
			is_locked : int,
			key_type : string,
			keystream : string,
			read_interval : string,
			read_offset : string,
			someoid : int,
			status : string,
			transfer_rate : string
			
			identifier {
				someoid
			}
		}

		relationship type participantSipHashId {
			participant[1] : participants,
			siphash[0-1] : siphash_ids, 
		}

		relationship type messageSipHashId {
			message[1] : participants_messages,
			siphash[0-N] : siphash_ids, 
		}

		relationship type keySipHashId {
			pkey[1] : participants_keys,
			siphash[0-N] : siphash_ids, 
		}

		relationship type arson_keySipHashId {
			akey[1] : arson_keys,
			siphash[0-N] : siphash_ids, 
		}

		relationship type NeighborQueue {
			queued[1] : outbound_queue,
			neighbor[0-N] : neighbors,
		}

	}

	////////////////// Schéma physique enrichi //////////////////

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
				name_digest,
				stream,
				stream_digest
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
				siphash_id_digest,
				special_value_a,
				special_value_b,
				special_value_c,
				special_value_d,
				special_value_e
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

	////////////////// Schéma physique tel qu'implémenté //////////////////
	
	relational schema smokeDB : SCH {
		
		table arson_keys {
			columns {
				enabled,
				message_keystream,
				message_keystream_digest,
				siphash_id_digest
			}
			
			references {
				a: siphash_id_digest -> siphash_ids.siphash_id_digest
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
				name_digest,
				stream,
				stream_digest
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
				siphash_id_digest,
				special_value_a,
				special_value_b,
				special_value_c,
				special_value_d,
				special_value_e
			}
			
			references {
				a: siphash_id_digest -> siphash_ids.siphash_id_digest
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
				a: siphash_id_digest -> siphash_ids.siphash_id_digest
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
				a: siphash_id_digest -> siphash_ids.siphash_id_digest
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
	
}

mapping rules {
	
	conceptualSmokeDB.arson_keys(enabled, message_keystream, message_keystream_digest) -> enrichedSmokeDB.arson_keys(enabled,message_keystream,message_keystream_digest, siphash_id_digest),
	conceptualSmokeDB.congestion_control(digest, timestamp) -> enrichedSmokeDB.congestion_control(digest, timestamp),
	conceptualSmokeDB.fire(name, name_digest, stream, stream_digest) -> enrichedSmokeDB.fire(name, name_digest, stream, stream_digest),
	conceptualSmokeDB.log(event, timestamp) -> enrichedSmokeDB.log(event_timestamp),
	conceptualSmokeDB.neighbors(oid,encryption_public_key,encryption_public_key_algorithm,encryption_public_key_digest,encryption_public_key_signed,identity,keystream,last_status_timestamp,options,signature_public_key,signature_public_key_digest,signature_public_key_signed,siphash_id,siphash_id_digest,special_value_a,special_value_b,special_value_c,special_value_d,special_value_e) -> enrichedSmokeDB.neighbors(oid,encryption_public_key,encryption_public_key_algorithm,encryption_public_key_digest,encryption_public_key_signed,identity,keystream,last_status_timestamp,options,signature_public_key,signature_public_key_digest,signature_public_key_signed,siphash_id,siphash_id_digest,special_value_a,special_value_b,special_value_c,special_value_d,special_value_e),
	conceptualSmokeDB.outbound_queue(oid,attempts,messages,message_identity_digest,neighbor_oid,timestamp) -> enrichedSmokeDB.outbound_queue(oid,attempts,messages,message_identity_digest,neighbor_oid,timestamp)
	conceptualSmokeDB.participants(oid,encryption_public_key,encryption_public_key_algorithm,encryption_public_key_digest,encryption_public_key_signed,identity,keystream,last_status_timestamp,options,signature_public_key,signature_public_key_digest,signature_public_key_signed,siphash_id,siphash_id_digest,special_value_a,special_value_b,special_value_c,special_value_d,special_value_e) -> enrichedSmokeDB.participants(oid,encryption_public_key,encryption_public_key_algorithm,encryption_public_key_digest,encryption_public_key_signed,identity,keystream,last_status_timestamp,options,signature_public_key,signature_public_key_digest,signature_public_key_signed,siphash_id,siphash_id_digest,special_value_a,special_value_b,special_value_c,special_value_d,special_value_e),
	conceptualSmokeDB.participants_keys(oid,keystream,keystream_digest,siphash_id_digest,timestamp) -> enrichedSmokeDB.participants_keys(oid,keystream,keystream_digest,siphash_id_digest,timestamp),
	conceptualSmokeDB.participants_messages(oid,attachment,from_smokestack,message,message_digest,message_identity_digest,message_read,message_sent,siphash_id_digest,timestamp) -> enrichedSmokeDB.participants_messages(oid,attachment,from_smokestack,message,message_digest,message_identity_digest,message_read,message_sent,siphash_id_digest,timestamp),
	conceptualSmokeDB.settings(name,name_digest,value_) -> enrichedSmokeDB.settings(name,name_digest,value_),
	conceptualSmokeDB.siphash_ids(oid,name,siphash_id,siphash_id_digest,stream) -> enrichedSmokeDB.DB.siphash_ids(oid,name,siphash_id,siphash_id_digest,stream),
	conceptualSmokeDB.steam_files(oid,absolute_filename,destination,display_filename,ephemeral_private_key,ephemeral_public_key,file_digest,file_identity,file_identity_digest,file_size,is_download,is_locked,key_type,keystream,read_interval,read_offset,someoid,status,transfer_rate) -> enrichedSmokeDB.steam_files(oid,absolute_filename,destination,display_filename,ephemeral_private_key,ephemeral_public_key,file_digest,file_identity,file_identity_digest,file_size,is_download,is_locked,key_type,keystream,read_interval,read_offset,someoid,status,transfer_rate),
	
	// Relations
	
	conceptualSmokeDB.participantSipHashId.participant -> enrichedSmokeDB.participants.has,
	conceptualSmokeDB.messageSipHashId.message -> enrichedSmokeDB.participants_messages.has,
	conceptualSmokeDB.keySipHashId.pkey -> enrichedSmokeDB.participants_keys.has,
	conceptualSmokeDB.arson_keySipHashId.akey -> enrichedSmokeDB.arson_keys.has,
	conceptualSmokeDB.NeighborQueue.neighbor -> enrichedSmokeDB.outbound_queue.queued_neighbor
		
}

databases {
	
	sqlite SCH {
		dbname : "smokeDB"
		host: "localhost"
		port: 6969
	}
	
}
