Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.143.172.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096871;
	b=RdsZJ/oIvLX5u3YXh3XvKvsRSwHeOfU2yMUos4AvDQjrVu2yw9aTjCQutB8TS/69m3mI
	 kT83sTsBRo/t7ErAEMtRGVCwf0U2Ul7di5D8O0t0nY74b0RVev6VVEDOvF+UDbRZcbDc6
	 AGymxBXJ1lJbRpcw2uJRW6JFL5Y2e0cCYTmWhAAyjSQCEICTg6BT8dOk0MclbKxBan92D
	 Sw4EvxgXJAwvDMqZAarNN7uaYIkYiMzgoP8TDWOcFnaipOwU8r4I/x8OzZTLYR9bPeYnm
	 jlXDrmd61U21hOSch6IkqdzieUPfK2hVwhgeOQRxePaQUqUrHp4+fr1+TETNDbtjHzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096871;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Bar:X-Rspamd-Report:X-Rspamd-Score:DKIM-Signature;
	bh=3rYbp0to0As9+qHJyXYnjeDVAcY7hnB8k1kM0na5DB8=;
	b=Zzoq4H8+bRcQITT7G1NNiFGX1leB7x4HUZzTSuR30nx0yAqgcqqne4MD6c69YR0dNnJW
	 137wL8tWgrYIybZVnIVZY/POAKIAY3Eb8wOXsTR373h7sMnTcGDwQ/MO76xex5fRmMNk1
	 x2IUlRxFEG30FxHgYwdAhrs+MAvXimt3DsTr18J/1DtN7XAmt7TJfVeb6MQmP5x6/U0+K
	 Np4zbfoUPje/YIqRLBRGIDIS+D4CJC3EJ3572m/Iz7sR/mA41wa6lTM9euQ9aa6Dybj4R
	 cb+sTH6M5ucnIEDfDam0hVrk4rHfJQPVWLY/NCRKhyEWUiEYeh1t67TBN221wDPZ/qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jhbruhn.de;
	spf=pass smtp.mailfrom=jhbruhn.de;
	dkim=pass header.d=jhbruhn.de header.i=@jhbruhn.de header.a=rsa-sha256 header.s=uberspace header.b=tbGgcUqY;
	arc=none smtp.remote-ip=95.143.172.20
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A23606A31A
	for <iwd@lists.linux.dev>; Tue, 27 Oct 2026 10:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1A23606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jhbruhn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jhbruhn.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=jhbruhn.de header.i=@jhbruhn.de header.a=rsa-sha256 header.s=uberspace header.b=tbGgcUqY
Received: from boethin.uberspace.de (boethin.uberspace.de [185.26.156.96])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 40069615E3
	for <iwd@lists.linux.dev>; Tue, 27 Oct 2026 11:27:42 +0100 (CET)
Received: (qmail 14450 invoked by uid 990); 27 Oct 2026 10:27:42 -0000
Authentication-Results: boethin.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
	by boethin.uberspace.de (Haraka/3.1.1) with ESMTPSA; Tue, 27 Oct 2026 11:27:41 +0100
From: Jan-Henrik Bruhn <git@jhbruhn.de>
To: iwd@lists.linux.dev
Cc: Jan-Henrik Bruhn <kernel@jhbruhn.de>
Subject: [PATCH 1/2] vendor_quirks: add PMKID mismatch quirk
Date: Tue, 27 Oct 2026 11:27:34 +0100
Message-ID: <20261027102735.140381-1-git@jhbruhn.de>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Post: <mailto:iwd@lists.linux.dev>
List-Help: <mailto:iwd+help@lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iwd+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-1.469619) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.069619
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=jhbruhn.de; s=uberspace;
	h=from:to:cc:subject:date;
	bh=xKBRrCtOc/uZ7l3CaMik2q55L4bLAMJ7WnhKXDjXF3A=;
	b=tbGgcUqYjsz4SZQRf0yqM+ad1KjqSrkxvzZDkpcKlxSGeLTbXXkGtzLcLGSYMT6i4TrqVEhHY1
	iOHWVFwpHyDDqTSUvbIjv9pwFDZae4a+y/CnynobeNNDbIx5AdkvdwogdP7dvOIBL4eKqdugYotq
	7GAozsCOI/5x5iGABeS6hf7Y4GijfdyA3q4qaK8UsK5zWB54FoQMwFDyD9LktycOc+DM8+DCFtww
	ua5Omk8CH3nKZY41YzMwQUNwiyZh42CBv0VavNDoUph900vj4AzqvU+e9nayjxHZ+FEFCCqWvaQf
	AO7l6bnagAcvwKIbWYobgMPeDWxL6gfmKkexnBJCmH0x/S0BkEn2PCjFeeBH6Ozp8GQTcJ7dUybL
	HuQ4YeQS3mgkwizTAJwVUzM/fOgtzQufbSWbIb6OO3FZOkhDqbXGxhu6Gz9yAm+At3DCdtnKE7yx
	2VLsnqt+IGxPdqstlwKpXjEXnFz9g2cnFFTEA3vEXogJQieyi2ehC1Yk3aTMvYyBO9Hf+DNneNUo
	LCIPEtNWLZviJ3lcvcAcYAQJBNtcba6SpAMhUmInUU5rXHRtKQMHTPgYko3bcNHp2X9mUKlN6MXl
	6KIoZkQYey7qz+VrOw4cmyA8hwDkF0afpFp3MlDCFE6zQGuuXbLB6ftZhdnIH2svgEYF46xKezKZ
	0=

From: Jan-Henrik Bruhn <kernel@jhbruhn.de>

pmkid_mismatch:
  Extreme Networks APs running WiNG include a PMKID in message 1/4
  of the FT-8021X 4-way handshake which does not match any PMKID IWD
  derives, even directly after a full EAP authentication. This quirk
  is intended to relax the PMKID check for these APs. They are
  identified by the Zebra Technologies OUI in their vendor IE.

---
 src/vendor_quirks.c | 9 +++++++++
 src/vendor_quirks.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/src/vendor_quirks.c b/src/vendor_quirks.c
index 4fba0c3..accd6b8 100644
--- a/src/vendor_quirks.c
+++ b/src/vendor_quirks.c
@@ -45,6 +45,11 @@ static const struct {
 		{ 0x00, 0x0b, 0x86 },
 		{ .replay_counter_mismatch = true },
 	},
+	{
+		/* Zebra Technologies, WiNG APs now owned by Extreme */
+		{ 0x00, 0xa0, 0xf8 },
+		{ .pmkid_mismatch = true },
+	},
 };
 
 void vendor_quirks_append_for_oui(const uint8_t *oui,
@@ -62,6 +67,7 @@ void vendor_quirks_append_for_oui(const uint8_t *oui,
 				quirk->ignore_bss_tm_candidates;
 		quirks->replay_counter_mismatch |=
 				quirk->replay_counter_mismatch;
+		quirks->pmkid_mismatch |= quirk->pmkid_mismatch;
 	}
 }
 
@@ -77,6 +83,9 @@ const char *vendor_quirks_to_string(struct vendor_quirk quirks)
 	if (quirks.replay_counter_mismatch)
 		s += snprintf(pos, sizeof(out) - s, "ReplayCounterMismatch");
 
+	if (quirks.pmkid_mismatch)
+		s += snprintf(pos, sizeof(out) - s, "PmkidMismatch");
+
 	if (!s)
 		return NULL;
 
diff --git a/src/vendor_quirks.h b/src/vendor_quirks.h
index b5d726c..ab45c28 100644
--- a/src/vendor_quirks.h
+++ b/src/vendor_quirks.h
@@ -29,6 +29,7 @@
 struct vendor_quirk {
 	bool ignore_bss_tm_candidates : 1;
 	bool replay_counter_mismatch : 1;
+	bool pmkid_mismatch : 1;
 };
 
 void vendor_quirks_append_for_oui(const uint8_t *oui,
-- 
2.43.0

