Content-Type: multipart/mixed; boundary="===============6211774147303525992=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] doc: Update agent API with possible errors
Date: Thu, 24 Oct 2019 13:02:05 -0700
Message-ID: <20191024200205.29804-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6211774147303525992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/agent-api.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index ef80499e..5200dfb5 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -43,6 +43,7 @@ Methods		void Release()
 			a network and passphrase is required.
 =

 			Possible Errors: net.connman.iwd.Agent.Error.Canceled
+					 net.connman.iwd.Agent.Error.Failed
 =

 		string RequestPrivateKeyPassphrase(object network)
 =

@@ -52,6 +53,7 @@ Methods		void Release()
 			obtain that private key's encryption passphrase.
 =

 			Possible Errors: net.connman.iwd.Agent.Error.Canceled
+					 net.connman.iwd.Agent.Error.Failed
 =

 		(string, string) RequestUserNameAndPassword(object network)
 =

@@ -60,6 +62,7 @@ Methods		void Release()
 			user name and password.
 =

 			Possible Errors: net.connman.iwd.Agent.Error.Canceled
+					 net.connman.iwd.Agent.Error.Failed
 =

 		string RequestUserPassword(object network, string user)
 =

@@ -69,6 +72,7 @@ Methods		void Release()
 			in the parameter.
 =

 			Possible Errors: net.connman.iwd.Agent.Error.Canceled
+					 net.connman.iwd.Agent.Error.Failed
 =

 		void Cancel(string reason)
 =

-- =

2.13.6

--===============6211774147303525992==--

