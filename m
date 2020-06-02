Content-Type: multipart/mixed; boundary="===============3478239135465787883=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/10] doc: document new 'Delay' property for hwsim Rules
Date: Tue, 02 Jun 2020 10:30:19 -0700
Message-ID: <20200602173021.20085-9-prestwoj@gmail.com>
In-Reply-To: <20200602173021.20085-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3478239135465787883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/hwsim-rules-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/hwsim-rules-api.txt b/doc/hwsim-rules-api.txt
index 0002db36..448ede14 100644
--- a/doc/hwsim-rules-api.txt
+++ b/doc/hwsim-rules-api.txt
@@ -68,3 +68,8 @@ Properties	string Source
 =

 		bool Drop
 			If true, nothing is passed to the receiver.
+
+		uint32 Delay
+			Set the millisecond delay for any matching packets. This
+			value cannot be less than 1 as a 1ms delay is required
+			for test reliability.
-- =

2.21.1

--===============3478239135465787883==--

