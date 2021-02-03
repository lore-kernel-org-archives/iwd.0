Content-Type: multipart/mixed; boundary="===============7430216413803256841=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] station: add Frequency to diagnostics dictionary
Date: Wed, 03 Feb 2021 09:20:44 -0800
Message-ID: <20210203172045.180677-2-prestwoj@gmail.com>
In-Reply-To: <20210203172045.180677-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7430216413803256841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/station.c b/src/station.c
index aee90c23..df7140c0 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3557,6 +3557,8 @@ static void station_get_diagnostic_cb(
 =

 	dbus_append_dict_basic(builder, "ConnectedBss", 's',
 					util_address_to_string(info->addr));
+	dbus_append_dict_basic(builder, "Frequency", 'u',
+				&station->connected_bss->frequency);
 =

 	diagnostic_info_to_dict(info, builder);
 =

-- =

2.26.2

--===============7430216413803256841==--

