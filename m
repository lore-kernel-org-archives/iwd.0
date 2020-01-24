Content-Type: multipart/mixed; boundary="===============2581371987884772875=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH v4] Document P2P dbus interfaces
Date: Fri, 24 Jan 2020 04:40:42 +0100
Message-ID: <20200124034042.2576-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2581371987884772875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Proposed minimum P2P interfaces for establishing basic connections.  The
device discovery results in creation of Peer objects.
---
I removed any mentions of WFD or services for now.  I did keep the
signal level agent as we have all the code in netdev and there's no
reason not to make the notifications available for client-mode
connections.  For connections where don't have the data (GO-mode until
kernel support is there) we will not send them (obviously).
---
 doc/p2p-api.txt      | 97 ++++++++++++++++++++++++++++++++++++++++++++
 doc/p2p-peer-api.txt | 45 ++++++++++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 doc/p2p-api.txt
 create mode 100644 doc/p2p-peer-api.txt

diff --git a/doc/p2p-api.txt b/doc/p2p-api.txt
new file mode 100644
index 00000000..ecf0a521
--- /dev/null
+++ b/doc/p2p-api.txt
@@ -0,0 +1,97 @@
+P2P hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.p2p.Device [Experimental]
+Object path	/net/connman/iwd/{phy0,phy1,...}
+
+Methods		array(on) GetPeers()
+
+			Returns a list (possibly empty) of detected P2P peers.
+			Each record returned contains a tuple of the following
+			values.
+
+			object Object
+
+				The net.connman.iwd.p2p.Peer object
+				representing the peer device.
+
+			int16 SignalStrength
+
+				Peer's signal strength expressed in 100 * dBm.
+				The value is the range of 0 (strongest signal)
+				to -10000 (weakest signal.)
+
+		void RequestDiscovery()
+
+			Starts device discovery if not already happening and
+			registers the calling D-Bus client as requiring device
+			discovery.  The discovery phase will be active until
+			all registered clients have called ReleaseDiscovery()
+			or disconnected from D-Bus.
+
+			Possible errors: [service].Error.AlreadyExists
+
+		void ReleaseDiscovery()
+
+			Unregisters the calling client as requiring device
+			discovery.  Clients should do this as soon as they
+			stop displaying or otherwise using the list of
+			discovered peer devices to avoid keeping the Wi-Fi
+			adapter occupied unnecessarily.
+
+			Possible errors: [service].Error.NotAvailable
+
+		void RegisterSignalLevelAgent(object path,
+						 array(int16) levels)
+
+			Register the agent object to receive signal strength
+			level change notifications on the
+			net.connman.iwd.Station.SignalLevelAgent interface,
+			see station-api.txt.  The "levels" parameter decides
+			the thresholds in dBm that will generate a call to
+			the agent's Changed method whenever current RSSI
+			crosses any of the values.  The values must be
+			passed in descending order.  The number and distance
+			between requested threshold values is a compromise
+			between resolution and the frequency of system
+			wakeups and context-switches that are going to be
+			occuring to update the client's signal meter.  Only
+			one agent can be registered at any time.
+
+			Possible errors: [service].Error.InvalidArguments
+					 [service].Error.Failed
+					 [service].Error.AlreadyExists
+					 [service].Error.NotSupported
+
+		void UnregisterSignalLevelAgent(object path)
+
+			Unregister an existing agent.
+
+			Possible errors: [service].Error.InvalidArguments
+					 [service].Error.NotFound
+
+Properties	boolean Enabled [readwrite]
+
+			Whether local P2P device is started and ready to
+			start device discovery, become discoverable by peers
+			and connect to peers.
+
+		string Name [readwrite]
+
+			Sets local P2P device name as it is going to be
+			presented on other devices that we will connect to
+			or ones that discover us in scanning.
+
+		uint16 AvailableConnections [readonly]
+
+			Minimum number of peers the hardware is capable of
+			connecting to in the current configuration and in
+			addition to any connections already established.
+			Often 1 while idle and 0 if connected to a peer,
+			connecting, disconnecting or otherwise busy.
+
+			A non-zero number is to be interpreted as meaning
+			that the device is capable of making *at least*
+			that many new connections as the final number may
+			depend on parameters negotiated with future peers.
diff --git a/doc/p2p-peer-api.txt b/doc/p2p-peer-api.txt
new file mode 100644
index 00000000..2245b2e3
--- /dev/null
+++ b/doc/p2p-peer-api.txt
@@ -0,0 +1,45 @@
+P2PPeer hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.p2p.Peer [Experimental]
+Object path	/net/connman/iwd/{phy0,phy1,...}/p2p_peers/{aa_bb_cc_dd_ee_ff}
+
+Methods		Disconnect()
+
+			If connected, disconnect from this peer.
+			Connections are established by calling methods on
+			the net.connman.iwd.SimpleConfiguration interface
+			on the same object -- see wsc-api.txt.
+
+			Possible errors: [service].Failed
+					 [service].NotConnected
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
+			The object with a net.connman.iwd.p2p.Device
+			interface that discovered this peer -- see
+			p2p-api.txt.
+
+		boolean Connected [readonly]
+
+			Whether there's currently an active connection
+			to this peer.  This property is read-only and
+			changes as a result of method calls on the
+			net.connman.iwd.SimpleConfiguration interface
+			on the same object -- see wsc-api.txt -- and
+			calls to Disconnect on this interface.
-- =

2.20.1

--===============2581371987884772875==--

