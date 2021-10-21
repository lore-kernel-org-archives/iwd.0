Content-Type: multipart/mixed; boundary="===============8396661093860375954=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 09/12] doc: Update agent-api.txt to match code and clarify
Date: Thu, 21 Oct 2021 10:50:38 +0200
Message-ID: <20211021085041.294524-9-andrew.zaborowski@intel.com>
In-Reply-To: 20211021085041.294524-1-andrew.zaborowski@intel.com

--===============8396661093860375954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/agent-api.txt | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index f3d8514e..9da913e0 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -7,19 +7,23 @@ Object path	/net/connman/iwd
 =

 Methods		void RegisterAgent(object path)
 =

-			Register new agent for handling user requests.
+			Register new agent for handling user secrets requests.
+			The agent object's methods on the net.connman.iwd.Agent
+			interface will be called when IWD needs to request
+			credentials for a connection to a network in station
+			mode.
 =

-			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.Failed
-					 [service].Error.AlreadyExists
+			Possible Errors: [service].InvalidArguments
+					 [service].Failed
+					 [service].AlreadyExists
 =

 		void UnregisterAgent(object path)
 =

 			Unregister an existing agent.
 =

-			Possible Errors: [service].Error.InvalidArguments
-					 [service].Error.Failed
-					 [service].Error.NotFound
+			Possible Errors: [service].InvalidArguments
+					 [service].Failed
+					 [service].NotFound
 =

 =

 Agent hierarchy
@@ -80,5 +84,5 @@ Methods		void Release() [noreply]
 =

 Examples	Requesting a passphrase for WPA2 network
 =

-			RequestPassphrase("/network1")
+			RequestPassphrase("/net/connman/iwd/0/3/54657374_psk")
 			=3D=3D> "secret123"
-- =

2.32.0

--===============8396661093860375954==--

