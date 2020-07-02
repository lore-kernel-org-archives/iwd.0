Content-Type: multipart/mixed; boundary="===============2828933618948413282=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/8] wiphy: add convenience API wiphy_find_by_wdev
Date: Thu, 02 Jul 2020 10:35:27 -0700
Message-ID: <20200702173533.8712-2-prestwoj@gmail.com>
In-Reply-To: <20200702173533.8712-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2828933618948413282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/wiphy.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/wiphy.h b/src/wiphy.h
index 2a597878..dba2cc9c 100644
--- a/src/wiphy.h
+++ b/src/wiphy.h
@@ -62,6 +62,8 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiph=
y,
 					bool fils_capable_hint);
 =

 struct wiphy *wiphy_find(int wiphy_id);
+#define wiphy_find_by_wdev(w) wiphy_find(w >> 32)
+
 bool wiphy_is_blacklisted(const struct wiphy *wiphy);
 =

 struct wiphy *wiphy_create(uint32_t wiphy_id, const char *name);
-- =

2.21.1

--===============2828933618948413282==--

