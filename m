Content-Type: multipart/mixed; boundary="===============6947136240458460523=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 10/12] doc: Add NetworkConfigurationAgent API description
Date: Thu, 21 Oct 2021 10:50:39 +0200
Message-ID: <20211021085041.294524-10-andrew.zaborowski@intel.com>
In-Reply-To: 20211021085041.294524-1-andrew.zaborowski@intel.com

--===============6947136240458460523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Document the new API that clients can use to get notified of new network
configuration and be responsible for committing it to the netdev, the
resolver, etc.
---
 doc/agent-api.txt | 106 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 9da913e0..92317e57 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -25,6 +25,48 @@ Methods		void RegisterAgent(object path)
 					 [service].Failed
 					 [service].NotFound
 =

+		void RegisterNetworkConfigurationAgent(object path)
+
+			Register the agent for handling IPv4 and IPv6
+			configuration setting.  This method and its
+			corresponding unregister method are only supported
+			if network configuration is enabled: see
+			EnableNetworkConfiguration in iwd.config(5) and
+			NetworkConfigurationEnabled in
+			net.connman.iwd.Daemon.GetInfo in daemon-api.txt.
+
+			During a station-mode, AP-mode or P2P connection, IWD
+			will obtain the IP configuration values for a network
+			interface, either automatically from a remote server
+			(DHCP or otherwise), generate it or read it from a
+			settings file.  If no network configuration agent is
+			present, IWD immediately writes (commits) those
+			values to the corresponding interface, the routing
+			table and communicates them to the resolver.  If such
+			agent is registered, IWD requests the agent to do
+			this last step.
+
+			Connection success is not signalled until the agent
+			method has returned.  The agent may also be invoked
+			during the connection lifetime whenever the IP
+			configuration changes and after a roam.  The agent
+			object must have the NetworkConfigurationAgent
+			interface.
+
+			Possible Errors: [service].InvalidArguments
+					 [service].Failed
+					 [service].AlreadyExists
+					 [service].NotSupported
+
+		void UnregisterNetworkConfigurationAgent(object path)
+
+			Unregister an existing network configuration agent.
+
+			Possible Errors: [service].InvalidArguments
+					 [service].Failed
+					 [service].NotFound
+					 [service].NotAvailable
+
 =

 Agent hierarchy
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -86,3 +128,67 @@ Examples	Requesting a passphrase for WPA2 network
 =

 			RequestPassphrase("/net/connman/iwd/0/3/54657374_psk")
 			=3D=3D> "secret123"
+
+
+NetworkConfigurationAgent hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		unique name
+Interface	net.connman.iwd.NetworkConfigurationAgent
+Object path	freely definable
+
+Methods		void Release() [noreply]
+
+			This method gets called when the service daemon
+			unregisters the agent. An agent can use it to do
+			cleanup tasks. There is no need to unregister the
+			agent, because when this method gets called it has
+			already been unregistered.
+
+		void ConfigureIPv4(object device, string interface, dict config)
+
+			This method gets called during a connection setup
+			when a new set of IPv4 configuration values is to
+			be written to a network interface.  The connection
+			is aborted if the method call returns an error or
+			times out.  The 'config' dictionary (a{sv}) maps
+			string keys to values of types defined per key.
+
+			The following key/value pairs are used, but more
+			may be added in future versions.
+
+			string Method - Indicates whether the local address
+			was set statically (value "static") or obtained
+			automatically such as through DHCP (value "auto").
+			Even when the address was obtained from the remote
+			end some configuration bits, such as DNS addresses,
+			may have been overridden locally.
+
+			string Address - Local IP address string.
+
+			byte PrefixLength - Holds the prefix-length of the
+			local subnet.  For IPv4 this maps to the netmask.
+
+			string Gateway [optional] - Local subnet's gateway
+			address if one exists.
+
+			array(string) DomainNameServers [optional] - Holds
+			the list of DNS addresses configured if any exist.
+
+			array(string) DomainNames [optional] - Holds the
+			network's local domain names if any exist.
+
+			Possible Errors: net.connman.iwd.Agent.Error.Canceled
+
+		void ConfigureIPv6(object device, string interface, dict config)
+
+			Same as ConfigureIPv4 above but for IPv6.
+
+		void Cancel(object device, string interface,
+						string reason) [noreply]
+
+			This method gets called to indicate that the connection
+			request failed before a reply was returned.  The
+			argument will indicate why the request is being
+			cancelled and may be "out-of-range", "user-canceled",
+			"timed-out" or "shutdown".
-- =

2.32.0

--===============6947136240458460523==--

