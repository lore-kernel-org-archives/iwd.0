Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DDA17BB01
	for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722006531; cv=none; b=Kb75ODb3lUJdyp2DpXK7sMVtiNVZatCdIq6mfrpVzbDnw5NnXRjAAYT/aQ9byFv4AFcrM735N1F1k2GVdog1KYPCg7R/m1sh41OZbOPkAHERvkGANQTO2z0VpgW/N1mjPSkM3UHRjw35I/yFx6XaO4aeNV9bK8BtNoJQx2NERnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722006531; c=relaxed/simple;
	bh=NxkLkXFtir7H05mucFEPzCxdyintuBEf/qRX8I8f524=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEK1h/eLxNwImgR0Yzp44AT8PUa3fQcTeJK5GLE5KuhNnueLMfUxiT34gKyoeYXYAvLtSxikSTFNf60QWyslq547xYWRWEoQUiFBWvwV0icsSHmrW26vymuHvXrQkY2z3EUwUnE4qguSKqM7S84gfvOh0xAqfzaFTT9pyFTSxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBEL1kSR; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBEL1kSR"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-704156d0e0dso697819a34.1
        for <iwd@lists.linux.dev>; Fri, 26 Jul 2024 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722006529; x=1722611329; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7Q6kfIDb1CsZfBAPjNgZKO6RjvbdFPyajZGNHRq1MM=;
        b=PBEL1kSR1O+NDbnxU/uO4iJu5+7EOMHgJfY6vRtcZC+BM7M1qQ8M5faSG+2KEgNK2W
         BilG2iiPNU46KnFV5USChcp747D6x+ko/C3Hrr+R3ZDqMlptDxh+FR1uqGmoHvkdazh+
         QkmJOoSu5wJV9k3jN8l7rGpoGHmCRRf3Tk7zCyeRHAEM+KYSqh480d57OGnu5BvBRvq7
         syy86DfaHkJWD5oEaf8k+jnaEBOdIIoaXOXDVzjnB+/ygXiWVIvUqEbcTpqjaX5DTSE5
         GKA+AEUScjQAvVIkeWZtAiBoEWAf/1ZeV5Zws1Bz74TIccWX05yAg21E1qhg/5xVaS0K
         Pt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722006529; x=1722611329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7Q6kfIDb1CsZfBAPjNgZKO6RjvbdFPyajZGNHRq1MM=;
        b=oo/8aJl3sUKjhjRtc+gKQhI904+M0SeeEMsNwjKcnlKzoQwZBKZrPUj8uImWAsVlSI
         bQY+01SvlubxnLb84KsdZznpSh1L+qIeJ4i6pm4SAUcBB1sXg/gZyPvr+fi1OVlOg1Ag
         bVzexO1UEeC5yg3TK3dfdy6mfW1Rl0jT2X/ckg9SUeGpnHJY+jB2wdx5uW62/04/nHrD
         vOv3vEW+dP3MsFTNdVqO5j/NxjbyfGsnycSX3SZA0xIUp4wxu7Gehqb6LiIXXDBkQ+kr
         tkI2irf0j1kwkY8JwvADDV2sIkdCRcGpccCNq06sbO8D7Kiq5fBW5q1VnoPSbmNtMWCT
         K6GA==
X-Gm-Message-State: AOJu0YzyMyFQFZLb3IAdpx2dnXW2QkpRaIE+SLnWpywtgmJATfecAYUr
	oEq7DDktXsCilUOF/fHRPaFNyQekR1HKzV+sShTOhM/DlmIQiQmHHlLdGg==
X-Google-Smtp-Source: AGHT+IE89Lp6m2KhV5VDr8idO+psckQ/3RRasNNTWGbm9+5XNDJPrkoB79xwvPZ5RwU4L1RTHJ/rsw==
X-Received: by 2002:a05:6830:3703:b0:709:674:6e4 with SMTP id 46e09a7af769-7092e6eed2cmr7848892a34.19.1722006528803;
        Fri, 26 Jul 2024 08:08:48 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930785d17sm762842a34.67.2024.07.26.08.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:08:48 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/2] monitor: Use genl APIs instead of open coding
Date: Fri, 26 Jul 2024 10:08:27 -0500
Message-ID: <20240726150846.146628-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l_genl class has nice ways of discovering and requesting families.  The
genl functionality has been added after the iwmon skeleton was created,
but it is now time to migrate to using these APIs.
---
 monitor/main.c | 93 ++++++--------------------------------------------
 1 file changed, 11 insertions(+), 82 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index 8f354d52607d..32f5ec4fc7f3 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -224,110 +224,39 @@ struct iwmon_interface {
 	char *ifname;
 	bool exists;
 	struct l_netlink *rtnl;
-	struct l_netlink *genl;
+	struct l_genl *genl;
 	struct l_io *io;
 };
 
 static struct iwmon_interface monitor_interface = { };
 
-static void genl_parse(uint16_t type, const void *data, uint32_t len,
-							const char *ifname)
+static void nl80211_appeared(const struct l_genl_family_info *info,
+					void *user_data)
 {
-	const struct genlmsghdr *genlmsg = data;
-	const struct nlattr *nla;
-	char name[GENL_NAMSIZ];
-	uint16_t id = 0;
-
-	if (nlmon)
-		return;
-
-	if (type != GENL_ID_CTRL)
-		return;
-
-	if (genlmsg->cmd != CTRL_CMD_NEWFAMILY)
-		return;
-
-	for (nla = data + GENL_HDRLEN; NLA_OK(nla, len);
-						nla = NLA_NEXT(nla, len)) {
-		switch (nla->nla_type & NLA_TYPE_MASK) {
-		case CTRL_ATTR_FAMILY_ID:
-			id = *((uint16_t *) NLA_DATA(nla));
-			break;
-		case CTRL_ATTR_FAMILY_NAME:
-			strncpy(name, NLA_DATA(nla), GENL_NAMSIZ - 1);
-			break;
-		}
-	}
-
-	if (id == 0)
-		return;
-
-	if (strcmp(name, NL80211_GENL_NAME))
-		return;
+	const char *ifname = user_data;
 
 	monitor_interface.io = open_packet(ifname);
 	if (!monitor_interface.io)
 		goto failed;
 
-	nlmon = nlmon_open(id, writer_path, &config);
+	nlmon = nlmon_open(l_genl_family_info_get_id(info),
+						writer_path, &config);
 	if (!nlmon)
 		goto failed;
 
 	l_io_set_read_handler(monitor_interface.io, nlmon_receive, nlmon, NULL);
-
 	return;
 
 failed:
 	l_main_quit();
 }
 
-static void genl_notify(uint16_t type, const void *data,
-						uint32_t len, void *user_data)
-{
-	const char *ifname = user_data;
-
-	genl_parse(type, data, len, ifname);
-}
-
-static void genl_callback(int error, uint16_t type, const void *data,
-						uint32_t len, void *user_data)
-{
-	const char *ifname = user_data;
-
-	if (error < 0) {
-		fprintf(stderr, "Failed to lookup nl80211 family\n");
-		l_main_quit();
-		return;
-	}
-
-	genl_parse(type, data, len, ifname);
-}
-
-static struct l_netlink *genl_lookup(const char *ifname)
+static struct l_genl *genl_lookup(const char *ifname)
 {
-	struct l_netlink *genl;
-	char buf[GENL_HDRLEN + NLA_HDRLEN + GENL_NAMSIZ];
-	struct genlmsghdr *genlmsg;
-	struct nlattr *nla;
-
-	genl = l_netlink_new(NETLINK_GENERIC);
-
-	l_netlink_register(genl, GENL_ID_CTRL, genl_notify, NULL, NULL);
-
-	genlmsg = (struct genlmsghdr *) buf;
-	genlmsg->cmd = CTRL_CMD_GETFAMILY;
-	genlmsg->version = 0;
-	genlmsg->reserved = 0;
-
-	nla = (struct nlattr *) (buf + GENL_HDRLEN);
-	nla->nla_len = NLA_HDRLEN + GENL_NAMSIZ;
-	nla->nla_type = CTRL_ATTR_FAMILY_NAME;
-	strncpy(buf + GENL_HDRLEN + NLA_HDRLEN,
-					NL80211_GENL_NAME, GENL_NAMSIZ);
-
-	l_netlink_send(genl, GENL_ID_CTRL, 0, buf, sizeof(buf),
-					genl_callback, (char *) ifname, NULL);
+	struct l_genl *genl = l_genl_new();
 
+	l_genl_request_family(genl, NL80211_GENL_NAME, nl80211_appeared,
+					(char *) ifname, NULL);
 	return genl;
 }
 
@@ -957,7 +886,7 @@ int main(int argc, char *argv[])
 
 	l_io_destroy(monitor_interface.io);
 	l_netlink_destroy(monitor_interface.rtnl);
-	l_netlink_destroy(monitor_interface.genl);
+	l_genl_unref(monitor_interface.genl);
 	l_free(monitor_interface.ifname);
 
 	nlmon_close(nlmon);
-- 
2.45.2

