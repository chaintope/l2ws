require 'bitcoin'

Bitcoin.network = :regtest
BTC = 100000000 #satoshi

prev_tx_hash = "47b894b67312cf2400861da2ea7f237b5d1d6b48e63d9186664e277810f9125c"
prev_output_index = 0

tx = Bitcoin::Protocol::Tx.new

tx_in = Bitcoin::Protocol::TxIn.from_hex_hash(prev_tx_hash, prev_output_index)
tx.add_in(tx_in)

payee_address = "mfyqzuy85f3GQ7LZVHAsUuZNni7dMwoGWc"
value = 50 * BTC - 50000 # => 4999950000
tx_out = Bitcoin::Protocol::TxOut.value_to_address(value, payee_address)
tx.add_out(tx_out)

prev_tx = Bitcoin::Protocol::Tx.new("02000000010000000000000000000000000000000000000000000000000000000000000000ffffffff03510101ffffffff0200f2052a010000002321026647cd3193793b5d867895f3f9547a13026f34d7179864b315115c72d8874d3dac0000000000000000266a24aa21a9ede2f61c3f71d1defd3fa999dfa36953755c690689799962b48bebd836974e8cf900000000".htb)

secret_key = "cRNSvkGqZyekUJGrjeiB4XRQGA3BdoR8gq1kkSYtAh5A6a39X68x"
key = Bitcoin::Key.from_base58(secret_key)
sig_hash = tx.signature_hash_for_input(0, prev_tx, Bitcoin::Script::SIGHASH_TYPE[:all])
signature = key.sign(sig_hash)
script_sig = Bitcoin::Script.pack_pushdata(signature + [Bitcoin::Script::SIGHASH_TYPE[:all]].pack("C"))
tx.in[0].script_sig = script_sig

verify_tx = Bitcoin::Protocol::Tx.new(tx.to_payload)
p verify_tx.verify_input_signature(0, prev_tx)
