(You have either followed the Quick Install on the readme (`./install.sh`), or have
followed a manual installation as per [here](INSTALL.md)).

(If you want to run Joinmarket-Qt, start with the [walkthrough](JOINMARKET-QT-GUIDE.md) instead of this.)

### Zeroth step: configuring for Bitcoin Core (or using Electrum servers).

It's highly recommended to run Joinmarket using a Bitcoin Core instance to connect to the Bitcoin network,
and in the case of running a yield generator it's basically required. It gives better privacy, performance
and reliability.

The Bitcoin Core node *can* be pruned.

To run one or more simple coinjoins without requiring Bitcoin Core, you can set the value of `blockchain_source` in the `[BLOCKCHAIN]` section of `joinmarket.cfg` (see below) to `electrum-server`.
This will choose servers randomly and should sync the wallet quite quickly (a few seconds), but is not *perfectly* reliable (connections will fail occasionally; just try again).

Configuring Joinmarket for Core is now reduced, since there is no longer any `walletnotify` used.

First thing to do: in `scripts/`, run:

    python wallet-tool.py generate

This *should* quit with an error, because the rpc is not configured. Open the newly created file `joinmarket.cfg`,
and edit:

    [BLOCKCHAIN]
    rpc_user = yourusername-as-in-bitcoin.conf
    rpc_password = yourpassword-as-in-bitcoin.conf
    rpc_host = localhost #default usually correct 
    rpc_port = 8332 # default for mainnet

(or, if not using Core, just make the edit mentioned above for `electrum-server`).

Then retry the same `generate` command; it should now not error (see below).
If you still get rpc connection errors, make sure you can connect to your Core node using the command line first.

### First step: make a Joinmarket wallet

Use [this](https://github.com/JoinMarket-Org/joinmarket/wiki/Using-the-JoinMarket-internal-wallet) guide,
BUT: a couple of differences:

* The `wallet-tool.py` script is in the `scripts/` directory, so start there.
* The output when you "display balance" will look a bit different: the addresses start with '3'.
* The layout is also slightly different, but it's the same information.
* The BIP32 paths look like m/49'/0'/0'/0/000 instead of m/0/0/0/000; that's just a new segwit standard.

(The new standard (BIP49) *should* be compatible with TREZOR, Ledger, Electrum, Samourai and some others, including the 12 word seed).

### Second step: Funding the wallet.

Read [this section](https://github.com/JoinMarket-Org/joinmarket/wiki/Using-the-JoinMarket-internal-wallet#funding-wallet-and-displaying-balance)
in the previously linked page. Don't neglect the point mentioned that, if you are planning to do your own coinjoins
(act as "Taker", you must fund multiple different addresses to avoid inconvenience in future. For Makers, that's not necessary.

If you are upgrading from non-Segwit JM, you'll want to read this [upgrade guide](SEGWIT-UPGRADE.md).

### Third step: Try out a coinjoin

To try doing one coinjoin, use the `sendpayment.py` script. See [here](https://github.com/JoinMarket-Org/joinmarket/wiki/Sending-payments-with-CoinJoin#send-payment)

(Note that the `patientsendpayment` option, also described on that page, is not yet implemented in this version, but probably will be soon).

(Note also that you can use 'schedule' files in this new version, but that's more advanced so ignore it for now.)

### 4a step: if you want to be a "Maker" or "yield generator".

Read the introductory guide [here](https://github.com/JoinMarket-Org/joinmarket/wiki/Running-a-Yield-Generator).

You can use the `yield-generator-basic.py` script in the `scripts/` directory.
The new script (much simplified) has the same fields at the top you can edit; note
the new offertypes are 'swreloffer', 'swabsoffer' - they function the same, but use segwit.


### 4b step: if you want to run the tumbler script.

Read the instructions [here](tumblerguide.md)