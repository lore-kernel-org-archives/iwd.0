Content-Type: multipart/mixed; boundary="===============4943734472255444814=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Wed, 13 Nov 2019 22:40:55 -0600
Message-ID: <99990fc4-80d3-020c-4fe3-cf28f97067b7@gmail.com>
In-Reply-To: <20191010205100.18404-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4943734472255444814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/10/19 3:51 PM, Andrew Zaborowski wrote:
> From: Andrew Zaborowski <andrew.zaborowski@intel.com>
> =

> Proposed minimum P2P interfaces for establishing basic connections.  The
> device discovery results in creation of P2PPeer objects.
> =

> In the Wi-Fi Display API we are passing raw IE data because there's a
> relatively big set of different values that may be encoded in them.  We
> could reduce them to 2-3 bools and integers but this might limit the
> client implementations feature set.

So I'm not really a huge fan of this.  We'd still need to be able to =

understand what is inside the IE in order to verify it properly.  I'd =

err on the side of providing some attributes instead of full on binary =

IEs.

Also, some of the subelements involved should really be filled in by iwd =

itself and not the external application.  Otherwise you'll end up with =

some sort of Frankenstein where the app provides some info but we'd need =

to rewrite or modify it anyway.

> ---
>   doc/p2p-api.txt                | 82 ++++++++++++++++++++++++++++++++++
>   doc/p2p-peer-api.txt           | 66 +++++++++++++++++++++++++++
>   doc/p2p-wfd-agent-api.txt      | 34 ++++++++++++++
>   doc/signal-level-agent-api.txt |  4 ++
>   4 files changed, 186 insertions(+)
>   create mode 100644 doc/p2p-api.txt
>   create mode 100644 doc/p2p-peer-api.txt
>   create mode 100644 doc/p2p-wfd-agent-api.txt
> =

> diff --git a/doc/p2p-api.txt b/doc/p2p-api.txt
> new file mode 100644
> index 00000000..84f862e5
> --- /dev/null
> +++ b/doc/p2p-api.txt
> @@ -0,0 +1,82 @@
> +P2P hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		net.connman.iwd
> +Interface	net.connman.iwd.P2P [Experimental]
> +Object path	/{phy0,phy1,...}

So we changed the paths for 1.0 and this might need to be updated.

> +
> +Methods		array(on) GetPeers()
> +
> +			Returns a list (possibly empty) of detected P2P peers.
> +			Each record returned contains a tuple of the following
> +			values.
> +
> +			object Object
> +
> +				net.connman.iwd.P2PPeer object representing

Name this iwd.Peer?

> +				the peer device.
> +
> +			int16 SignalStrength
> +
> +				Peer's maximum signal strength expressed
> +				in 100 * dBm.  The value is the range of 0
> +				(strongest signal) to -10000 (weakest signal)
> +
> +		void RegisterSignalLevelAgent(object path,
> +						 array(int16) levels)
> +
> +			Register the agent object to receive signal strength
> +			level change notifications on the
> +			net.connman.iwd.SignalLevelAgent interface, see
> +			signal-level-agent-api.txt.  The "levels"

We moved this into the station api.  So maybe just refer to that here...

Though really, I wonder if you even want to bother with this for the =

first iteration?  I'd maybe leave this out?

> +			parameters decides the thresholds in dBm that will
> +			generate a call to the agent's Changed
> +			method whenever current RSSI crosses any of the
> +			values.  The values must be passed in descending
> +			order.  The number and distance between requested
> +			threshold values is a compromise between resolution
> +			and the frequency of system wakeups and
> +			context-switches that are going to be occuring to
> +			update the client's signal meter.  Only one agent
> +			can be registered at any time.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +					 [service].Error.Failed
> +					 [service].Error.AlreadyExists
> +					 [service].Error.NotSupported
> +
> +		void RegisterWFDService(object path, array(byte) payload)

I would maybe make this a bit more generic in case other P2P services =

are supported in the future, like file sharing, etc.

But, I'm not sure this belongs here?  P2P is a per-phy interface; do you =

really want the clients to register WiFi Display per phy?  Or just once =

and have it apply to all devices in the system, current or ones yet to =

be plugged in?  Perhaps we need a ServiceManager or add this to =

AgentManager API?

I suppose it might be in theory possible to support both a Sink and a =

Source role on different phys, but then shouldn't you be distinguishing =

between the roles somehow?

> +
> +			Register the Wi-Fi Display service running on local
> +			host with this P2P device so that device discovery
> +			and connection setup phases include necessary WFD

okay...

> +			information for the peers and receive peer's WFD
> +			service information.  An object may be provided to
> +			receive relevant WFD information about peers and
> +			connections through method calls on the object's
> +			net.connman.iwd.P2PWFDAgent interface.  See
> +			p2p-wfd-agent-api.txt.  Only one agent can be
> +			registered at any time.  The byte array provided
> +			will be included in WFD Information Elements
> +			present in relevant frames sent to peers.

So besides the IE information (which I don't really want transported in =

binary), what real use is the WFD agent?

> +
> +			Possible Errors: [service].Error.InvalidArguments
> +					 [service].Error.AlreadyExists
> +					 [service].Error.NotSupported
> +
> +Properties	boolean Enabled [readwrite]
> +
> +			Whether local P2P device is started, i.e. is scanning
> +			for peers, is discoverable by peers and/or connected
> +			to peer(s).
> +
> +		string Name [readwrite]
> +
> +			Sets local P2P device name as it is going to be
> +			presented on other devices that we will connect to
> +			or ones that discover us in scanning.
> +
> +		uint16 MaxConnections [readonly]
> +
> +			Maximum number of concurrent P2P peers that local
> +			hardware is capable of connecting to.  Often 1.

I think we've talked about this before.  Given what we now know, I would =

drop this for now.  I think the likelihood of this becoming > 1 is =

astronomically small and we shouldn't even worry about this.  This means =

we can also move some attributes / methods from the Peer interface onto =

this one.

> diff --git a/doc/p2p-peer-api.txt b/doc/p2p-peer-api.txt
> new file mode 100644
> index 00000000..898f4fb9
> --- /dev/null
> +++ b/doc/p2p-peer-api.txt
> @@ -0,0 +1,66 @@
> +P2PPeer hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		net.connman.iwd
> +Interface	net.connman.iwd.P2PPeer [Experimental]
.iwd.Peer?

> +Object path	/{phy0,phy1,...}/p2p_peers/{aa_bb_cc_dd_ee_ff}

Object path needs to be updated post 1.0

> +
> +Methods		ConnectPushButton()
> +
> +			Connect to the P2P peer in the Push Button mode
> +			using the device pointed to by the .Device property.
> +			Returns when connection is complete.

Why are you method names different from SimpleConfiguration?  in fact, =

why not just add .SimpleConfiguration interface to the same object path =

and just have clients use that?

> +
> +			Possible errors: net.connman.iwd.Aborted
> +					 net.connman.iwd.Busy
> +					 net.connman.iwd.Failed
> +					 net.connman.iwd.NotSupported
> +					 net.connman.iwd.Timeout
> +					 net.connman.iwd.InProgress
> +
> +		ConnectPIN(string pin)
> +
> +			Connect to the P2P peer in PIN mode.  Returns when
> +			connection is complete.
> +
> +			See net.connman.iwd.WiFiSimpleConfiguration.StartPIN()
> +			for how the pin argument is used.
> +
> +			Possible errors: net.connman.iwd.Aborted
> +					 net.connman.iwd.Busy
> +					 net.connman.iwd.Failed
> +					 net.connman.iwd.NotSupported
> +					 net.connman.iwd.Timeout
> +					 net.connman.iwd.InProgress
> +
> +		Disconnect() [optional]

A method can't be optional?  Anyway, I'd put this on the P2P interface =

instead.

> +
> +			If connected, disconnect from this peer.
> +
> +			Possible errors: net.connman.iwd.Failed
> +
> +Properties	string Name [readonly]
> +
> +			P2P Peer's display name
> +
> +		string DeviceCategory [readonly]
> +
> +			The category part of the peer's declared
> +			Primary Device Type.
> +
> +		string DeviceSubcategory [readonly, optional]
> +
> +			The Sub Category part of the peer's declared
> +			Primary Device Type.
> +
> +		object Device [readonly]
> +
> +			The object with a net.connman.iwd.P2P interface
> +			that discovered this peer.

Okay

> +
> +		boolean Connected [readonly]
> +
> +			Whether there's currently an active connection
> +			to this peer.  The property is read-only and
> +			changes as a result of the Connect and
> +			Disconnect methods calls.

This wording might need to be updated....

> diff --git a/doc/p2p-wfd-agent-api.txt b/doc/p2p-wfd-agent-api.txt
> new file mode 100644
> index 00000000..be0ee01b
> --- /dev/null
> +++ b/doc/p2p-wfd-agent-api.txt
> @@ -0,0 +1,34 @@
> +P2PWFDAgent hierarchy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Service		unique name
> +Interface	net.connman.iwd.P2PWFDAgent
> +Object path	freely definable
> +
> +Methods		void Release(object device)
> +
> +			This method gets called when IWD unregisters the
> +			WFD service on a specific P2P device. An agent can
> +			use it to do cleanup tasks. There is no need to
> +			unregister the agent, because when this method
> +			gets called it has already been unregistered.
> +
> +		void WFDPeersChanged(object device,
> +					array(object, array(byte)) peers)
> +
> +			Called when the set of discovered WFD-capable
> +			peers has changed during device discovery.
> +
> +			The device object has the net.connman.iwd.P2P
> +			interface while the objects in the peers array
> +			have net.connman.iwd.P2PPeer interfaces.  The byte
> +			array included contains the reassembled payload of
> +			the WFD Information Elements presented by the peer.

Okay, so you want to notify the agent instead of adding a WFD specific =

interface to the Peer object.  I still wonder if we can avoid =

transporting raw IEs here... Also, how are you making sure that the =

peers are actually ones that the agent cares about?  There's no sense in =

sending Source role peer info if we're also a Source...

Can we be a source and a sink at the same time?

> +
> +		void NewConnection(object peer, array(byte) payload)
> +
> +			Called when a new P2P connection has been established
> +			to a WFD-capable peer.  The peer object has the
> +			net.connman.iwd.P2PPerr interface.  The byte array

typo

> +			contains the reassembled payload of the WFD
> +			Information Elements presented by the peer.

So I'm not entirely sure how this is useful?  The fact that we made a =

connection to a peer is already available via the Peer.Connected =

property.  Is the payload somehow different from what was sent via =

WFDPeersChanged?

> diff --git a/doc/signal-level-agent-api.txt b/doc/signal-level-agent-api.=
txt
> index 847e7ca3..1c786d96 100644
> --- a/doc/signal-level-agent-api.txt
> +++ b/doc/signal-level-agent-api.txt
> @@ -31,3 +31,7 @@ Methods		void Release(object device)
>   			0 would mean signal is received at -40 or more dBm
>   			and 3 would mean below -60 dBm and might correspond
>   			to 1 out of 4 bars on a UI signal meter.
> +
> +			The device parameter may be either a
> +			net.connman.iwd.Station object or a
> +			net.connman.iwd.P2PPeer object.
> =


This file no longer exists FYI.

Regards,
-Denis
--===============4943734472255444814==--

