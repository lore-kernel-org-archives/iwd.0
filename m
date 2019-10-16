Content-Type: multipart/mixed; boundary="===============3537751669642917596=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] ie: reorder ie_parse_osen to fix uninitialized value
Date: Wed, 16 Oct 2019 16:43:04 -0700
Message-ID: <20191016234304.14716-4-prestwoj@gmail.com>
In-Reply-To: <20191016234304.14716-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3537751669642917596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RSNE_ADVANCE could result in a jump to the done label where info would
be copied without being initialized.
---
 src/ie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index 4bc56589..ba5210c8 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -827,13 +827,13 @@ int ie_parse_osen(struct ie_tlv_iter *iter, struct ie=
_rsn_info *out_info)
 	if (!is_ie_wfa_ie(iter->data, iter->len, IE_WFA_OI_OSEN))
 		return -EPROTOTYPE;
 =

-	RSNE_ADVANCE(data, len, 4);
-
 	memset(&info, 0, sizeof(info));
 	info.group_cipher =3D IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC;
 	info.pairwise_ciphers =3D IE_RSN_CIPHER_SUITE_CCMP;
 	info.akm_suites =3D IE_RSN_AKM_SUITE_8021X;
 =

+	RSNE_ADVANCE(data, len, 4);
+
 	if (parse_ciphers(data, len, ie_parse_osen_akm_suite, &info) < 0)
 		return -EBADMSG;
 =

-- =

2.17.1

--===============3537751669642917596==--

