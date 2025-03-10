Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFAD4A02
	for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741647357; cv=none; b=AVYwDQ3gMFt5zxnVpmBOq01hwWa1i5Z4go2/vrHO0BF5EbRfAJ1PP2NjdIoTFJg173QABwtGqXqwG1JnqbRnHDqZIuU7isAKQ84p5tLCi0ZzsOo2X12JMQQqKFmLbJHjSSaCHNdZx69yGzQgy6j44xlAzPNclIZS2wrxX3PhOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741647357; c=relaxed/simple;
	bh=nUpr8tofFnwqtx34jo1vyb9SbC73Oa3kn9pULYcMNM0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kjRzJ1LBQrzIE7jUsvBV/iSh5uFy6yG4a8x55/a6Zzd0dJbBeRQ1KjLDyrpSH1tQxZwajs1ciWX1+KYzf0FYctLVcSjHsG2CTXdllz/2rf/K8nphHTBfQZbpTrXM4i/HPc4WyxnPWUWOspMPPozMb+qvxZeUE1q0dswL4I5YAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Um/qXxd4; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Um/qXxd4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741647352; x=1741906552;
	bh=rbafq2HV8OuJcsSkcKS4IOWpfZy0G2JN62iTNdfqUQ4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Um/qXxd4ju6PZ7kVPv3W1QAYVud5aWr5x5pplJkww0pOcpGKCE6LR0mesQ885ySp7
	 Be4wtUjrM6B4W+WNVNHvJV1PcIKSLYr1mCQrNlnmhxPPn6EMya1ZIABVZbHRbsrTRg
	 3Ffz9Al0dckIeUnVM7BkFxwq5c8iJEwLwTsQJW6lubhETcRu88fCCUpPRty+ZNMx/b
	 3gb5Qsr0hDaHthgg2jZDlTJY7ddxRRft/fOpNN3ba0A6asmtCBp560IpwPE/qU8USy
	 Upypl60Hy6ldGNo8l8gT4ZqFOezakBEDJ4fSvugGqvwlFmoqCq5HuXS1R9i7oMiVQn
	 MJ7YUvTE0L9Bw==
Date: Mon, 10 Mar 2025 22:55:49 +0000
To: iwd@lists.linux.dev
From: rushiimachine@proton.me
Cc: rushiiMachine <rushiimachine@proton.me>
Subject: [PATCH] wiphy: non-LAA mac randomization
Message-ID: <20250310225418.198643-4-rushiimachine@proton.me>
Feedback-ID: 123797881:user:proton
X-Pm-Message-ID: c513a9c90288e42a256fbedf3bfb04411f002b94
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: rushiiMachine <rushiimachine@proton.me>

Add a secondary option to `AddressRandomizationRange` to not set the
locally-administered bit of `full` randomized MAC addresses. This
allows randomizing MAC addresses to not appear as Locally
Administered Addresses (LAA). Currently, there is no way to avoid
having this bit set other than setting `AddressRandomizationRange`
to `nic`, which undesirably copies the entire OUI and only randomizes
the last 3 octets.
---
 src/iwd.config.rst |  8 ++++++--
 src/wiphy.c        | 17 +++++++++++++----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 895a1012..55b95db9 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -107,7 +107,7 @@ The group ``[General]`` contains general settings.
        the permanent address.
=20
    * - AddressRandomizationRange
-     - Values: **full**, nic
+     - Values: **full**, full-uaa, nic
=20
        One can control which part of the address is randomized using this
        setting.
@@ -119,7 +119,11 @@ The group ``[General]`` contains general settings.
=20
        When using ``AddressRandomizationRange`` set to ``full``, all 6 oct=
ets
        of the address are randomized.  The locally-administered bit will b=
e
-       set.
+       set, and multicast bit will be cleared.
+
+       When using ``AddressRandomizationRange`` set to ``full-uaa``, all 6
+       octets of the address are randomized. The locally-administered and
+       multicast bits will be cleared.
=20
    * - RoamThreshold
      - Value: rssi dBm value, from -100 to 1, default: **-70**
diff --git a/src/wiphy.c b/src/wiphy.c
index fb544fe6..ccdc7645 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -64,6 +64,7 @@ static struct l_hwdb *hwdb;
 static char **whitelist_filter;
 static char **blacklist_filter;
 static int mac_randomize_bytes =3D 6;
+static bool mac_set_laa =3D true;
 static char regdom_country[2];
 static uint32_t work_ids;
 static unsigned int wiphy_dump_id;
@@ -778,8 +779,11 @@ static void wiphy_address_constrain(struct wiphy *wiph=
y, uint8_t addr[static 6])
 {
 =09switch (mac_randomize_bytes) {
 =09case 6:
-=09=09/* Set the locally administered bit */
-=09=09addr[0] |=3D 0x2;
+=09=09/* Set or clear the locally administered bit */
+=09=09if (mac_set_laa)
+=09=09=09addr[0] |=3D 0x2;
+=09=09else
+=09=09=09addr[0] &=3D 0xfd;
=20
 =09=09/* Reset multicast bit */
 =09=09addr[0] &=3D 0xfe;
@@ -2854,9 +2858,13 @@ static int wiphy_init(void)
 =09if (s) {
 =09=09if (!strcmp(s, "nic"))
 =09=09=09mac_randomize_bytes =3D 3;
-=09=09else if (!strcmp(s, "full"))
+=09=09else if (!strcmp(s, "full")) {
 =09=09=09mac_randomize_bytes =3D 6;
-=09=09else
+=09=09=09mac_set_laa =3D true;
+=09=09} else if (!strcmp(s, "full-uaa")) {
+=09=09=09mac_randomize_bytes =3D 6;
+=09=09=09mac_set_laa =3D false;
+=09=09} else
 =09=09=09l_warn("Invalid [General].AddressRandomizationRange"
 =09=09=09=09" value: %s", s);
 =09}
@@ -2884,6 +2892,7 @@ static void wiphy_exit(void)
 =09l_genl_family_free(nl80211);
 =09nl80211 =3D NULL;
 =09mac_randomize_bytes =3D 6;
+=09mac_set_laa =3D true;
=20
 =09l_dbus_unregister_interface(dbus_get_bus(), IWD_WIPHY_INTERFACE);
=20
--=20
2.48.1


