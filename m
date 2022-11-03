Received: from mail.pappacoda.it (mail.pappacoda.it [128.116.175.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50E2F21
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 10:56:58 +0000 (UTC)
Received: from satellite.uninsubria.it (nat-wifi-ateneo-va-70.uninsubria.it [193.206.181.70])
	by mail.pappacoda.it (Postfix) with ESMTPSA id 8545A3D4FC;
	Thu,  3 Nov 2022 11:56:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pappacoda.it;
	s=20211226; t=1667473015;
	bh=B54YDCV5MRPnGapyNDYVg7yP15dSqbWIASwWq7bYDdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmXE2JMVBUwsCjWzINd6ZyFXYgvF06bh8FZhXi3QatlZwHK/DgEA6SvyyTS47YVxq
	 dCWGOahIn2pREsxf/j0Eg+s8hcp8zq/WG0FwrwBoX/GB6AieOvcq2qg5Mu3CcwbIiP
	 zZDjvTF07MuCVYu14I5CQw65ENIU65Yaee0fUVa1cbNmBPwi4cOeNTLCQ0pWcxRmK3
	 gA1x+5hd2RGjVqjnzqwBS+Og0qSOK40YI+CDh7B8IxZBtEer868BnCCrGqHpdDK3G7
	 DpOpguZj0d5fUrPewY0/3mtZU07HIMiG3PhJbDt4N5SG+szDFsz00BwK/3jmfBSdir
	 n4wCngyq5R+cw==
From: Andrea Pappacoda <andrea@pappacoda.it>
To: iwd@lists.linux.dev
Cc: Andrea Pappacoda <andrea@pappacoda.it>
Subject: [PATCH 2/2] doc: document global MulticastDNS option
Date: Thu,  3 Nov 2022 11:56:39 +0100
Message-Id: <20221103105639.8289-2-andrea@pappacoda.it>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221103105639.8289-1-andrea@pappacoda.it>
References: <20221103105639.8289-1-andrea@pappacoda.it>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documents the new MulticastDNS global option, also adding some more
details regarding how and when systemd-resolved enables mDNS, and how
iwd handles it.
---
See <https://lore.kernel.org/iwd/A4TIKR.5DC9OCNE90W6@pappacoda.it/T/>
for more context.

 doc/main.conf       |  6 ++++++
 src/iwd.config.rst  | 19 +++++++++++++++++++
 src/iwd.network.rst |  4 ++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/doc/main.conf b/doc/main.conf
index e85aab10..f49d27db 100644
--- a/doc/main.conf
+++ b/doc/main.conf
@@ -37,6 +37,12 @@
 #
 #NameResolvingService=resolvconf
 #
+# If NameResolvingService=systemd is set, iwd can tell systemd-resolved to
+# enable multicast DNS for a given interface. Uncomment the value below to
+# enable mDNS for all the interfaces:
+#
+#MulticastDNS=true
+#
 # iwd's support for IPv6 is still experimental and is disabled by default.
 # If you want to try it anyway, uncomment the setting below.  Note that
 # configuration via SLAAC is currently not supported (DHCPv6 only).
diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index bafb6b85..27433cb1 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -249,6 +249,25 @@ The group ``[Network]`` contains network configuration related settings.
        If ``none`` is specified, then DNS and domain name information is
        ignored.
 
+   * - MulticastDNS
+     - Values: true, false, resolve
+
+       When ``NameResolvingService`` is set to ``systemd``, **iwd** can tell
+       **systemd-resolved** to enable multicast DNS for a given interface.
+       This setting configures the default for all the interfaces.
+
+       If ``EnableNetworkConfiguration`` is enabled and no other network
+       manager is configured, mDNS will be completely governed by this
+       option, assuming that MulticastDNS is enabled in ``resolved.conf``.
+
+       Note that individual network profiles can override this global value;
+       also see ``man 5 iwd.network``.
+
+       When no value is set, systemd-resolved's per-link setting will remain
+       untouched.
+
+       See ``man 5 resolved.conf`` for details.
+
    * - RoutePriorityOffset
      - Values: uint32 value (default: **300**)
 
diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index d3692834..4a207514 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -330,8 +330,8 @@ file.
      - Values: true, false, resolve
 
        Configures multicast DNS for this network. If not specified,
-       systemd-resolved's default value will remain untouched.
-       See ``man 5 systemd.network`` for details.
+       the global iwd default will be used instead.
+       See ``man 5 iwd.config`` for details.
 
        Only applies when ``NameResolvingService=systemd``.
 
-- 
2.35.1

