require 'openassets'

Bitcoin.network = :regtest

api = OpenAssets::Api.new({
    network:           'regtest',
    rpc: {
      user:                'user',
      password:            'password',
      schema:             'http',
      port:                 18332,
      host:          'localhost'}
  })

# listup unspent transaction (UTXO)
utxo_list = api.list_unspent
puts JSON.pretty_generate(utxo_list)


btc_address = 'mxpc1LnTMDFxwy1Va6Xpd4p1nDwRUopeic'

# Retreve OpenAssets address from Bitcoin Address
oa_address = OpenAssets.address_to_oa_address(btc_address)

metadata = 'u=https://goo.gl/uapCsJ'

# Issue asstes
tx = api.issue_asset(oa_address, 100, metadata)

# Retreve hash160 of publickey from Bitcoin address
hash160 = Bitcoin.hash160_from_address(btc_address)

# Get Asset ID from hash160 of publickey
asset_id = OpenAssets.pubkey_hash_to_asset_id(hash160)

asset_id = 'oQDVsbKEAkkBz1nN5BTGUwMxu9Y5CmhFEU'

# destination address
to_oa_address = OpenAssets.address_to_oa_address('mvAQLozzMcAKPGyFwck4opDCQb86pmz3TZ')

# send assets 30
tx = api.send_asset(oa_address, asset_id, 30, to_oa_address)
