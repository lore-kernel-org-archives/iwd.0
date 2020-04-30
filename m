Content-Type: multipart/mixed; boundary="===============2740767360588079570=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [RFC] Wi-Fi Display DBus API doc
Date: Thu, 30 Apr 2020 15:52:32 +0200
Message-ID: <20200430135232.62377-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2740767360588079570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/p2p-service-api.txt | 84 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 doc/p2p-service-api.txt

diff --git a/doc/p2p-service-api.txt b/doc/p2p-service-api.txt
new file mode 100644
index 00000000..9ab59355
--- /dev/null
+++ b/doc/p2p-service-api.txt
@@ -0,0 +1,84 @@
+P2P Service Manager hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.p2p.ServiceManager [Experimental]
+Object path	/net/connman/iwd
+
+Methods		void RegisterService(string service_name, object path)
+
+			Register a P2P service handler.  An application
+			can register as implementing a specific P2P service,
+			a concept similar to Bluetooth profiles.  When IWD
+			knows there's an application running that handles
+			a supported service, it may advertise that
+			capability to P2P peers, negotiate connection
+			parameters related to that service when establishing
+			a new connection, and expose discovered peers'
+			capilities relating to the service.  Once a P2P
+			connection is set up to a peer supporting the same
+			service, the application is resposible for setting
+			up higher layers of the service protocols and making
+			use of it.
+
+			The only service supported by IWD is 'wifi-display'.
+			The application must pass a path to an object
+			having the net.connman.iwd.p2p.Service and
+			net.connman.iwd.p2p.WifiDisplay interfaces attached.
+			The latter interface is also going to be added on
+			objects representing discovered peers.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.AlreadyExists
+					 [service].Error.NotSupported
+
+		void UnregisterService(object path)
+
+			Unregister a P2P service handler.
+
+			Possible Errors: [service].Error.NotFound
+
+
+P2P Service hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	net.connman.iwd.p2p.Service [Experimental]
+Object path	freely definable
+
+Methods		void Release()
+
+			This method gets called when IWD unregisters its
+			services.  There is no need for the application to
+			unregister the service at that point because when
+			this method is called it has already been
+			unregistered.
+
+
+Wi-fi Display hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	net.connman.iwd.p2p.WifiDisplay [Experimental]
+Object path	freely definable
+
+Properties	boolean Source [readonly]
+
+			Whether the peer represented by the object is
+			a WFD source.
+
+		boolean Sink [readonly]
+
+			Whether the peer represented by the object has
+			a WFD sink capability.  At least one of this and
+			'Source' should be true.
+
+		uint16 Port [readonly]
+
+			WFD Session Management Control port -- a TCP & UDP
+			port number.
+
+		uint16 MaxThroughput [readonly]
+
+			Declared WFD maximum throughput in megabits per
+			second.
-- =

2.25.1

--===============2740767360588079570==--

