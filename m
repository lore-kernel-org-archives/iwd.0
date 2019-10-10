Content-Type: multipart/mixed; boundary="===============4341496364698458603=="
MIME-Version: 1.0
From: Andrew Zaborowski <balrogg@gmail.com>
Subject: [RFCv3] Document P2P dbus interfaces
Date: Thu, 10 Oct 2019 22:51:00 +0200
Message-ID: <20191010205100.18404-1-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4341496364698458603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

Proposed minimum P2P interfaces for establishing basic connections.  The
device discovery results in creation of P2PPeer objects.

In the Wi-Fi Display API we are passing raw IE data because there's a
relatively big set of different values that may be encoded in them.  We
could reduce them to 2-3 bools and integers but this might limit the
client implementations feature set.
---
 doc/p2p-api.txt                | 82 ++++++++++++++++++++++++++++++++++
 doc/p2p-peer-api.txt           | 66 +++++++++++++++++++++++++++
 doc/p2p-wfd-agent-api.txt      | 34 ++++++++++++++
 doc/signal-level-agent-api.txt |  4 ++
 4 files changed, 186 insertions(+)
 create mode 100644 doc/p2p-api.txt
 create mode 100644 doc/p2p-peer-api.txt
 create mode 100644 doc/p2p-wfd-agent-api.txt

diff --git a/doc/p2p-api.txt b/doc/p2p-api.txt
new file mode 100644
index 00000000..84f862e5
--- /dev/null
+++ b/doc/p2p-api.txt
@@ -0,0 +1,82 @@
+P2P hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.P2P [Experimental]
+Object path	/{phy0,phy1,...}
+
+Methods		array(on) GetPeers()
+
+			Returns a list (possibly empty) of detected P2P peers.
+			Each record returned contains a tuple of the following
+			values.
+
+			object Object
+
+				net.connman.iwd.P2PPeer object representing
+				the peer device.
+
+			int16 SignalStrength
+
+				Peer's maximum signal strength expressed
+				in 100 * dBm.  The value is the range of 0
+				(strongest signal) to -10000 (weakest signal)
+
+		void RegisterSignalLevelAgent(object path,
+						 array(int16) levels)
+
+			Register the agent object to receive signal strength
+			level change notifications on the
+			net.connman.iwd.SignalLevelAgent interface, see
+			signal-level-agent-api.txt.  The "levels"
+			parameters decides the thresholds in dBm that will
+			generate a call to the agent's Changed
+			method whenever current RSSI crosses any of the
+			values.  The values must be passed in descending
+			order.  The number and distance between requested
+			threshold values is a compromise between resolution
+			and the frequency of system wakeups and
+			context-switches that are going to be occuring to
+			update the client's signal meter.  Only one agent
+			can be registered at any time.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.Failed
+					 [service].Error.AlreadyExists
+					 [service].Error.NotSupported
+
+		void RegisterWFDService(object path, array(byte) payload)
+
+			Register the Wi-Fi Display service running on local
+			host with this P2P device so that device discovery
+			and connection setup phases include necessary WFD
+			information for the peers and receive peer's WFD
+			service information.  An object may be provided to
+			receive relevant WFD information about peers and
+			connections through method calls on the object's
+			net.connman.iwd.P2PWFDAgent interface.  See
+			p2p-wfd-agent-api.txt.  Only one agent can be
+			registered at any time.  The byte array provided
+			will be included in WFD Information Elements
+			present in relevant frames sent to peers.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.AlreadyExists
+					 [service].Error.NotSupported
+
+Properties	boolean Enabled [readwrite]
+
+			Whether local P2P device is started, i.e. is scanning
+			for peers, is discoverable by peers and/or connected
+			to peer(s).
+
+		string Name [readwrite]
+
+			Sets local P2P device name as it is going to be
+			presented on other devices that we will connect to
+			or ones that discover us in scanning.
+
+		uint16 MaxConnections [readonly]
+
+			Maximum number of concurrent P2P peers that local
+			hardware is capable of connecting to.  Often 1.
diff --git a/doc/p2p-peer-api.txt b/doc/p2p-peer-api.txt
new file mode 100644
index 00000000..898f4fb9
--- /dev/null
+++ b/doc/p2p-peer-api.txt
@@ -0,0 +1,66 @@
+P2PPeer hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.P2PPeer [Experimental]
+Object path	/{phy0,phy1,...}/p2p_peers/{aa_bb_cc_dd_ee_ff}
+
+Methods		ConnectPushButton()
+
+			Connect to the P2P peer in the Push Button mode
+			using the device pointed to by the .Device property.
+			Returns when connection is complete.
+
+			Possible errors: net.connman.iwd.Aborted
+					 net.connman.iwd.Busy
+					 net.connman.iwd.Failed
+					 net.connman.iwd.NotSupported
+					 net.connman.iwd.Timeout
+					 net.connman.iwd.InProgress
+
+		ConnectPIN(string pin)
+
+			Connect to the P2P peer in PIN mode.  Returns when
+			connection is complete.
+
+			See net.connman.iwd.WiFiSimpleConfiguration.StartPIN()
+			for how the pin argument is used.
+
+			Possible errors: net.connman.iwd.Aborted
+					 net.connman.iwd.Busy
+					 net.connman.iwd.Failed
+					 net.connman.iwd.NotSupported
+					 net.connman.iwd.Timeout
+					 net.connman.iwd.InProgress
+
+		Disconnect() [optional]
+
+			If connected, disconnect from this peer.
+
+			Possible errors: net.connman.iwd.Failed
+
+Properties	string Name [readonly]
+
+			P2P Peer's display name
+
+		string DeviceCategory [readonly]
+
+			The category part of the peer's declared
+			Primary Device Type.
+
+		string DeviceSubcategory [readonly, optional]
+
+			The Sub Category part of the peer's declared
+			Primary Device Type.
+
+		object Device [readonly]
+
+			The object with a net.connman.iwd.P2P interface
+			that discovered this peer.
+
+		boolean Connected [readonly]
+
+			Whether there's currently an active connection
+			to this peer.  The property is read-only and
+			changes as a result of the Connect and
+			Disconnect methods calls.
diff --git a/doc/p2p-wfd-agent-api.txt b/doc/p2p-wfd-agent-api.txt
new file mode 100644
index 00000000..be0ee01b
--- /dev/null
+++ b/doc/p2p-wfd-agent-api.txt
@@ -0,0 +1,34 @@
+P2PWFDAgent hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	net.connman.iwd.P2PWFDAgent
+Object path	freely definable
+
+Methods		void Release(object device)
+
+			This method gets called when IWD unregisters the
+			WFD service on a specific P2P device. An agent can
+			use it to do cleanup tasks. There is no need to
+			unregister the agent, because when this method
+			gets called it has already been unregistered.
+
+		void WFDPeersChanged(object device,
+					array(object, array(byte)) peers)
+
+			Called when the set of discovered WFD-capable
+			peers has changed during device discovery.
+
+			The device object has the net.connman.iwd.P2P
+			interface while the objects in the peers array
+			have net.connman.iwd.P2PPeer interfaces.  The byte
+			array included contains the reassembled payload of
+			the WFD Information Elements presented by the peer.
+
+		void NewConnection(object peer, array(byte) payload)
+
+			Called when a new P2P connection has been established
+			to a WFD-capable peer.  The peer object has the
+			net.connman.iwd.P2PPerr interface.  The byte array
+			contains the reassembled payload of the WFD
+			Information Elements presented by the peer.
diff --git a/doc/signal-level-agent-api.txt b/doc/signal-level-agent-api.txt
index 847e7ca3..1c786d96 100644
--- a/doc/signal-level-agent-api.txt
+++ b/doc/signal-level-agent-api.txt
@@ -31,3 +31,7 @@ Methods		void Release(object device)
 			0 would mean signal is received at -40 or more dBm
 			and 3 would mean below -60 dBm and might correspond
 			to 1 out of 4 bars on a UI signal meter.
+
+			The device parameter may be either a
+			net.connman.iwd.Station object or a
+			net.connman.iwd.P2PPeer object.
-- =

2.20.1

--===============4341496364698458603==--

